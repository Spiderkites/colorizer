(function($, document, window, viewport){
    'use strict';

    var _stock_info = ['out-of-stock', 'in-short-supply', 'in-stock'],
        $v,
        ArticleClass = function () {
            this.init();
        };

    ArticleClass.DEFAULTS = {
        input: {
            id: 'a',
            childId: 'VariKindArtikel',
            quantity: 'anzahl'
        },
        action: {
            compareList: 'Vergleichsliste',
            compareListRemove: 'Vergleichsliste.remove',
            wishList: 'Wunschliste',
            wishListRemove: 'Wunschliste.remove'
        },
        selector: {
            navUpdateCompare: '#comparelist-dropdown-content',
            navBadgeUpdateCompare: '#comparelist-badge',
            navCompare: '#shop-nav-compare',
            navContainerWish: '#wishlist-dropdown-container',
            navBadgeWish: '#badge-wl-count',
            navBadgeAppend: '#shop-nav li.cart-menu',
            boxContainer: '#sidebox',
            boxContainerWish: '#sidebox',
            quantity: 'input.quantity'
        },
        modal: {
            id: 'modal-article-dialog',
            wrapper: '#result-wrapper',
            wrapper_modal: '#result-wrapper-modal'
        }
    };

    ArticleClass.prototype = {
        modalShown: false,
        modalView: null,

        constructor: ArticleClass,

        init: function () {
            this.options = ArticleClass.DEFAULTS;
            this.gallery = null;
        },

        onLoad: function() {
            if (this.isSingleArticle()) {
                var that = this;
                var form = $.evo.io().getFormValues('buy_form');

                if (typeof history.replaceState === 'function') {
                    history.replaceState({
                        a: form.a,
                        a2: form.VariKindArtikel || form.a,
                        url: document.location.href,
                        variations: {}
                    }, document.title, document.location.href);
                }

                window.addEventListener('popstate', function (event) {
                    if (event.state) {
                        that.setArticleContent(event.state.a, event.state.a2, event.state.url, event.state.variations);
                    }
                }, false);
            }
        },

        isSingleArticle: function() {
            return $('#buy_form').length > 0;
        },

        getWrapper: function(wrapper) {
            return typeof wrapper === 'undefined' ? $(this.options.modal.wrapper) : $(wrapper);
        },

        getCurrent: function($item) {
            var $current = $item.hasClass('variation') || ($item.length === 1 && $item[0].tagName === 'SELECT')
                ? $item
                : $item.closest('.variation');
            if ($current.length === 1 && $current[0].tagName === 'SELECT') {
                $current = $item.find('option:selected');
            } else if ($current.length === 0) {
                $current = $item.next('.variation');
            }

            return $current;
        },

        register: function(wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            if (this.isSingleArticle()) {
                this.registerGallery($wrapper);
                this.registerConfig();
                this.registerHoverVariations($wrapper);
            }

            this.registerSimpleVariations($wrapper);
            this.registerSwitchVariations($wrapper);
            this.registerBulkPrices($wrapper);
            this.registerAccordion();
            // this.registerImageSwitch($wrapper);
            //this.registerArticleOverlay($wrapper);
            this.registerFinish($wrapper);
            window.initNumberInput();
            this.initAbnahmeIntervallError();
        },

        registerAccordion: function() {
            $('.is-mobile .accordion [id^="tab-"]').on('click', function () {
                let self = $(this);
                $.evo.destroyScrollSearchEvent();
                setTimeout(function() {
                    $('html').animate(
                        {scrollTop: self.offset().top},
                        100,
                        'linear',
                        function () {
                            setTimeout(function() {
                                $.evo.initScrollSearchEvent();
                            }, 500);
                        });
                }, 400);
            });
        },

        registerGallery: function(wrapper) {
            /*
             * product slider and zoom (details)
             */
            function slickinit()
            {
                $('.initial-slick-dots').on('click', function () {
                    let mainNode = $('#gallery');
                    mainNode.removeClass('slick-lazy');
                    $.evo.extended().initSlick(mainNode, mainNode.data('slick-type'));
                    if(mainNode.slick('getSlick').slideCount > mainNode.slick('slickGetOption', 'slidesToShow')) {
                        mainNode.slick('slickGoTo', 1);
                    }
                });
            }

            function toggleFullscreen(fullscreen = false)
            {
                let $imgWrapper = $('#image_wrapper'),
                    $gallery    = $('#gallery');
                if (!$gallery.hasClass('slick-initialized') || (fullscreen && $imgWrapper.hasClass('fullscreen'))){
                    return;
                }

                let maxHeight       = Math.max(document.documentElement.clientHeight, window.innerHeight || 0),
                    otherElemHeight = 0,
                    current         = ($('#gallery .slick-current').data('slick-index')),
                    $galleryImages  = $('#gallery img, #gallery picture source'),
                    hidePreview     = maxHeight < 700,
                    previewHeight   = $('#gallery_preview_wrapper').length > 0 && !hidePreview ? 170 : 30,
                    $previewBar     = $('.product-detail-image-preview-bar');

                if (fullscreen) {
                    $imgWrapper.addClass('fullscreen');
                    let $galleryTopbar = $('#image_wrapper .product-detail-image-topbar');

                    otherElemHeight = $galleryTopbar.outerHeight()
                        + 2*parseInt($imgWrapper.css('paddingTop'))
                        + previewHeight;

                    $galleryImages.removeAttr('sizes');
                    lazySizes.autoSizer.updateElem($galleryImages);

                    if (hidePreview) {
                        $previewBar.addClass('d-none');
                    }

                    $galleryImages.css('max-height', maxHeight-otherElemHeight);
                    $gallery.css('max-height', maxHeight-otherElemHeight);

                    $('body').off('click.toggleFullscreen').on('click.toggleFullscreen', function (event) {
                        if (!($(event.target).hasClass('product-image') || $(event.target).hasClass('slick-arrow'))) {
                            toggleFullscreen(false);
                            $('body').off('click.toggleFullscreen');
                        }
                    });
                } else {
                    $imgWrapper.removeClass('fullscreen');
                    $galleryImages.css('max-height', '100%');
                    $gallery.css('max-height', '100%');
                    $previewBar.removeClass('d-none');
                }

                $gallery.slick('slickSetOption','initialSlide', current, true);
                $('#gallery_preview').slick('slickGoTo', current, true);

                //fix firefox height bug
                $('.slick-slide, .slick-arrow').css({'display': 'none'});
                setTimeout(function(){
                    $('.slick-slide, .slick-arrow').css({'display': 'block'});
                }, 50);
            }

            function addClickListener() {
                $('#gallery img').off('click').on('click', e => {
                    if (window.innerWidth > globals.breakpoints.lg) {
                        toggleFullscreen(true);
                    }
                });
            }

            slickinit();

            if (wrapper[0].id.indexOf(this.options.modal.wrapper_modal.substr(1)) === -1) {
                addClickListener();

                $(document).on('keyup', e => {
                    if (e.key === "Escape" && $('#image_wrapper').hasClass('fullscreen')) {
                        toggleFullscreen();
                        addClickListener();
                    }
                });
            }
        },

        registerConfig: function() {
            var that   = this,
                config = $('#product-configurator')
                    .closest('form')
                    .find('input[type="radio"], input[type="text"], input[type="checkbox"], input[type="number"], select'),
                dropdown = $('#product-configurator')
                    .closest('form')
                    .find('select');

            if (dropdown.length > 0) {
                dropdown.on('change', function () {
                    var item = $(this).val();
                    $(this).parents('.cfg-group').find('.cfg-drpdwn-item.collapse.show').collapse('hide');
                    $('#drpdwn_qnt_' + item).collapse('show');
                })
            }

            if (config.length > 0) {
                config.on('change', function() {
                    that.configurator();
                })
                    .on('keypress', function (e) {
                        if (e.key === 'Enter') {
                            return false;
                        }
                    });
                // timeout fixes problem with loading order of bootstrap dropdowns
                setTimeout(function(){
                    that.configurator(true);
                },0);
            }
        },

        registerSimpleVariations: function($wrapper) {
            var that = this;

            $('.variations select', $wrapper).selectpicker({
                iconBase: 'fa',
                tickIcon: 'fa-check',
                hideDisabled: true,
                showTick: true
            });

            $('.simple-variations input[type="radio"]', $wrapper)
                .on('change', function() {
                    var val = $(this).val(),
                        key = $(this).parent().data('key');
                    $('.simple-variations [data-key="' + key + '"]').removeClass('active');
                    $('.simple-variations [data-value="' + val + '"]').addClass('active');
                    $(this).closest(".swatches").addClass("radio-selected");
                });

            $('.simple-variations input[type="radio"], .simple-variations select', $wrapper)
                .each(function(i, item) {
                    var $item   = $(item),
                        wrapper = '#' + $item.closest('form').closest('div[data-wrapper="true"]').attr('id');

                    $item.on('change', function () {
                        that.variationPrice($(this), true, wrapper);
                    });
                });
            $('.simple-variations input[type="text"]', $wrapper)
                .each(function(i, item) {
                    let $item   = $(item),
                        wrapper = '#' + $item.closest('form').closest('div[data-wrapper="true"]').attr('id'),
                        timeout = null;
                    $item.on('keyup', function (e) {
                        clearTimeout(timeout);
                        let self = $(this);

                        timeout = setTimeout(function () {
                            that.variationPrice(self, true, wrapper);
                        }, 500);
                    });
                });
        },

        registerBulkPrices: function($wrapper) {
            var $bulkPrice = $('.bulk-price', $wrapper),
                that       = this,
                $config    = $('#product-configurator');

            if (($bulkPrice.length > 0 && $config.length === 0) || $('#product-list').length > 0) {
                $('#quantity, [data-bulk="1"] .quantity', $wrapper)
                    .each(function(i, item) {
                        var $item   = $(item),
                            wrapper = '#' + $item.closest('form').closest('div[data-wrapper="true"]').attr('id');

                        $item.on('change', function () {
                            that.variationPrice($(this), true, wrapper);
                        });
                    });
            }
        },

        registerSwitchVariations: function($wrapper) {
            var that = this;

            $('.switch-variations input[type="radio"], .switch-variations select', $wrapper)
                .each(function(i, item) {
                    var $item   = $(item),
                        wrapper = '#' + $item.closest('form').closest('div[id]').attr('id');

                    $item.on('change', function () {
                        that.variationSwitch($(this), false, wrapper);
                    });
                });

            if (isTouchCapable()) {
                $('.variations .swatches .variation', $wrapper)
                    .on('mouseover', function() {
                        $(this).trigger('click');
                    });
            }

            // ie11 fallback
            if (typeof document.body.style.msTransform === 'string') {
                $('.variations label.variation', $wrapper)
                    .on('click', function (e) {
                        if (e.target.tagName === 'IMG') {
                            $(this).trigger('click');
                        }
                    });
            }
        },

        registerHoverVariations: function ($wrapper) {
            let delay=300, setTimeoutConst;
            $('.variations label.variation', $wrapper)
                .on('mouseenter', function (e) {
                    setTimeoutConst = setTimeout(function () {
                        let mainImageHeight = $('.js-gallery-images').innerHeight();
                        $('.variation-image-preview.vt' + $(e.currentTarget).data('value')).addClass('show d-md-block')
                            .css('top', $(e.currentTarget).offset().top - $(e.currentTarget).closest('#content').position().top - mainImageHeight / 2 - 12);
                    }, delay)
                })
                .on('mouseleave', function (e) {
                    clearTimeout(setTimeoutConst);
                    $('.variation-image-preview.vt' + $(this).data('value')).removeClass('show d-md-block');
                });

            $('.variations .selectpicker')
                .on('show.bs.select', function () {
                    $(this).parent().find('li .variation')
                        .on('mouseenter', function (e) {
                            setTimeoutConst = setTimeout(function () {
                                let mainImageHeight = $('.js-gallery-images').innerHeight();
                                $('.variation-image-preview.vt' + $(e.currentTarget).find('span[data-value]').data("value"))
                                    .addClass('show d-md-block')
                                    .css('top', $(e.currentTarget).offset().top - $(e.currentTarget).closest('#content').position().top - mainImageHeight / 2 - 12);
                            }, delay)
                        })
                        .on('mouseleave', function () {
                            clearTimeout(setTimeoutConst);
                            $('.variation-image-preview.vt' + $(this).find('span[data-value]').data("value"))
                                .removeClass('show d-md-block');
                    });
                })
                .on('hide.bs.select', function () { 
                    $(this).parent().find('li .variation').off('mouseenter mouseleave');
                    $('.variation-image-preview').removeClass('show');
                });
        },

        registerImageSwitch: function($wrapper) {
            var that     = this,
                imgSwitch,
                gallery  = this.gallery;

            if (gallery !== null) {
                imgSwitch = function (context, temporary, force) {
                    var $context = $(context),
                        id       = $context.attr('data-key'),
                        value    = $context.attr('data-value'),
                        data     = $context.data('list'),
                        title    = $context.attr('data-title');

                    if (typeof temporary === 'undefined') {
                        temporary = true;
                    }

                    if ((!$context.hasClass('active') || force) && !!data) {
                        gallery.setItems([data], value);

                        if (!temporary) {
                            var items  = [data],
                                stacks = gallery.getStacks();
                            for (var s in stacks) {
                                if (stacks.hasOwnProperty(s) && s.match(/^_[0-9a-zA-Z]*$/) && s !== '_' + id) {
                                    items = $.merge(items, stacks[s]);
                                }
                            }

                            gallery.setItems([data], '_' + id);
                            gallery.setItems(items, '__');
                            gallery.render('__');

                            that.galleryIndex     = gallery.index;
                            that.galleryLastIdent = gallery.ident;
                        } else {
                            gallery.render(value);
                        }
                    }
                }
            } else {
                imgSwitch = function (context, temporary) {
                    var $context = $(context),
                        value    = $context.attr('data-value'),
                        data     = $context.data('list'),
                        title    = $context.attr('data-title');

                    if (typeof temporary === 'undefined') {
                        temporary = true;
                    }

                    if (!!data) {
                        var $wrapper = $(context).closest('.product-wrapper'),
                            $img     = $('.image-box img', $wrapper);
                        if ($img.length === 1) {
                            $img.attr('src', data.md.src);
                            if (!temporary) {
                                $img.data('src', data.md.src);
                            }
                        }
                    }
                };
            }

            $('.variations .bootstrap-select select', $wrapper)
                .on('change', function() {
                    var sel  = $(this).find('[value=' + this.value + ']'),
                        cont = $(this).closest('.variations');

                    if (cont.hasClass('simple-variations')) {
                        imgSwitch(sel, false, false);
                    } else {
                        imgSwitch(sel, true, false);
                    }
                });

            if (!isTouchCapable() || ResponsiveBootstrapToolkit.current() !== 'xs') {
                $('.variations .bootstrap-select .dropdown-menu li', $wrapper)
                    .on('hover', function () {
                        var tmp_idx = parseInt($(this).attr('data-original-index')) + 1,
                            rule    = 'select option:nth-child(' + tmp_idx + ')',
                            sel     = $(this).closest('.bootstrap-select').find(rule);
                        imgSwitch(sel);
                    }, function () {
                        var tmp_idx = parseInt($(this).attr('data-original-index')) + 1,
                            rule    = 'select option:nth-child(' + tmp_idx + ')',
                            sel     = $(this).closest('.bootstrap-select').find(rule),
                            gallery = that.gallery,
                            active;

                        if (gallery !== null) {
                            active = $(sel).find('.variation.active');
                            gallery.render(that.galleryLastIdent);
                            gallery.activate(that.galleryIndex);
                        } else {
                            var $wrapper = $(sel).closest('.product-wrapper'),
                                $img     = $('.image-box img', $wrapper);
                            if ($img.length === 1) {
                                $img.attr('src', $img.data('src'));
                            }
                        }
                    });
            }

            $('.variations.simple-variations .variation', $wrapper)
                .on('click', function () {
                    imgSwitch(this, false);
                });

            if (!isTouchCapable() || ResponsiveBootstrapToolkit.current() !== 'xs') {
                $('.variations .variation', $wrapper)
                    .on('hover', function () {
                        imgSwitch(this);
                    }, function () {
                        var sel     = $(this).closest('.variation'),
                            gallery = that.gallery;

                        if (gallery !== null) {
                            gallery.render(that.galleryLastIdent);
                            gallery.activate(that.galleryIndex);
                        } else {
                            var $wrapper = $(sel).closest('.product-wrapper'),
                                $img     = $('.image-box img', $wrapper);
                            if ($img.length === 1) {
                                $img.attr('src', $img.data('src'));
                            }
                        }
                    });
            }
        },

        registerFinish: function($wrapper) {
            $('#jump-to-votes-tab', $wrapper).on('click', function () {
                let $tabID = $('#content a[href="#tab-votes"]');
                if ($tabID.length > 0) {
                    $tabID.tab('show');
                } else {
                    $tabID = $('#tab-votes');
                    $tabID.collapse('show');
                }

                $([document.documentElement, document.body]).animate({
                    scrollTop: $tabID.offset().top
                }, 200);
            });

            let $tabID = $('#product-tabs a[href="' + window.location.hash + '"]');
            if ($tabID.length) {
                $tabID.tab('show');
                $([document.documentElement, document.body]).animate({
                    scrollTop: $tabID.offset().top
                }, 200);
            }

            if (this.isSingleArticle()) {
                if ($('.switch-variations .form-group', $wrapper).length === 1) {
                    var wrapper = '#' + $($wrapper).attr('id');
                    this.variationSwitch($('.switch-variations', $wrapper), false, wrapper);
                }
            }
            else {
                var that = this;

                $('.product-cell.hover-enabled')
                    .on('click', function (event) {
                        if (isTouchCapable() && ResponsiveBootstrapToolkit.current() !== 'xs') {
                            var $this = $(this);

                            if (!$this.hasClass('active')) {
                                event.preventDefault();
                                event.stopPropagation();
                                $('.product-cell').removeClass('active');
                                $this.addClass('active');
                            }
                        }
                    })
                    .on('mouseenter', function (event) {
                        var $this = $(this),
                            wrapper = '#' + $this.attr('id');

                        if (!$this.data('varLoaded') && $('.switch-variations .form-group', $this).length === 1) {
                            that.variationSwitch($('.switch-variations', $this), false, wrapper);
                        }
                        $this.data('varLoaded', true);
                    });
            }

            this.registerProductActions($('#sidepanel_left'));
            this.registerProductActions($('#footer'));
            this.registerProductActions($('#shop-nav'));
            this.registerProductActions($wrapper);
            this.registerProductActions('#cart-form');
        },

        registerProductActions: function($wrapper) {
            var that = this;

            $('*[data-toggle="product-actions"] button', $wrapper)
                .on('click', function(event) {
                    var data = $(this.form).serializeObject();

                    if ($wrapper === '#cart-form') {
                        data.wlPos = $(this).data('wl-pos');
                        data.a = $(this).data('product-id-wl');
                    }

                    if (that.handleProductAction(this, data)) {
                        event.preventDefault();
                    }
                });
            $('a[data-toggle="product-actions"]', $wrapper)
                .on('click', function(event) {
                    var data  = $(this).data('value');
                    this.name = $(this).data('name');

                    if (that.handleProductAction(this, data)) {
                        event.preventDefault();
                    }
                });
        },

        loadModalArticle: function(url, wrapper, done, fail) {
            var that       = this,
                $wrapper   = this.getWrapper(wrapper),
                id         = wrapper.substring(1),
                $modalBody = $('.modal-body', this.modalView);

            $.ajax(url, {data: {'isAjax':1, 'quickView':1}})
                .done(function(data) {
                    var $html      = $('<div />').html(data);
                    var $headerCSS = $html.find('link[type="text/css"]');
                    var $headerJS  = $html.find('script[src][src!=""]');
                    var content    = $html.find(that.options.modal.wrapper).html();

                    $headerCSS.each(function (pos, item) {
                        var $cssLink = $('head link[href="' + item.href + '"]');
                        if ($cssLink.length === 0) {
                            $('head').append('<link rel="stylesheet" type="text/css" href="' + item.href + '" >');
                        }
                    });

                    $headerJS.each(function (pos, item) {
                        if (typeof item.src !== 'undefined' && item.src.length > 0) {
                            var $jsLink = $('head script[src="' + item.src + '"]');
                            if ($jsLink.length === 0) {
                                $('head').append('<script defer src="' + item.src + '" >');
                            }
                        }
                    });

                    $modalBody.html($('<div id="' + id + '" />').html(content));

                    var $modal  = $modalBody.closest(".modal-dialog"),
                        title   = $modal.find('.modal-body h1'),
                        $config = $('#product-configurator', $modalBody);

                    if ($config.length > 0) {
                        // Configurator in child article!? Currently not supported!
                        $config.remove();
                        $.evo.extended().startSpinner($modalBody);
                        location.href = url;
                    }
                    if (title.length > 0 && title.text().length > 0) {
                        $modal.find('.modal-title').text(title.text());
                        title.remove();
                    }

                    $('form', $modalBody).on('submit', function(event) {
                        event.preventDefault();

                        var $form = $(this);
                        var data  = $form.serializeObject();
                        if (data['VariKindArtikel']) {
                            data['a'] = data['VariKindArtikel'];
                        }

                        $.evo.basket().addToBasket($form, data);
                        that.modalView.modal('hide');
                    });

                    if (typeof done === 'function') {
                        done();
                    }
                })
                .fail(function() {
                    if (typeof fail === 'function') {
                        fail();
                    }
                })
                .always(function() {
                    $.evo.extended().stopSpinner();
                });
        },

        addToComparelist: function(data, $action) {
            var productId = parseInt(data[this.options.input.id]);
            var childId = parseInt(data[this.options.input.childId]);
            if (childId > 0) {
                productId = childId;
            }
            if (productId > 0) {
                var that = this;
                $.evo.io().call('pushToComparelist', [productId], that, function(error, data) {
                    if (error) {
                        return;
                    }

                    var response = data.response;

                    if (response) {
                        switch (response.nType) {
                            case 0: // error
                                var errorlist = '<ul><li>' + response.cHints.join('</li><li>') + '</li></ul>';
                                eModal.alert({
                                    title: response.cTitle,
                                    message: errorlist,
                                    keyboard: true,
                                    tabindex: -1,
                                    buttons: false
                                });
                                break;
                            case 1: // forwarding
                                window.location.href = response.cLocation;
                                break;
                            case 2: // added to comparelist
                                that.updateComparelist(response);
                                break;
                        }
                    }
                });

                return true;
            }

            return false;
        },

        removeFromCompareList: function(data) {
            var productId = parseInt(data[this.options.input.id]);
            if (productId > 0) {
                var that = this;
                $.evo.io().call('removeFromComparelist', [productId], that, function(error, data) {
                    if (error) {
                        return;
                    }

                    var response = data.response;

                    if (response) {
                        switch (response.nType) {
                            case 0: // error
                                var errorlist = '<ul><li>' + response.cHints.join('</li><li>') + '</li></ul>';
                                eModal.alert({
                                    title: response.cTitle,
                                    message: errorlist,
                                    keyboard: true,
                                    tabindex: -1,
                                    buttons: false
                                });
                                break;
                            case 1: // forwarding
                                window.location.href = response.cLocation;
                                break;
                            case 2: // removed from comparelist
                                that.updateComparelist(response);
                                break;
                        }
                    }
                });

                return true;
            }

            return false;
        },

        updateComparelist: function(data) {
            var $badgeUpd = $(this.options.selector.navUpdateCompare);

            var badge = $(data.navDropdown);
            $badgeUpd.html(badge);
            $(this.options.selector.navBadgeUpdateCompare).html(data.nCount);

            if (data.nCount > 0) {
                $(this.options.selector.navCompare).removeClass('d-none');
            } else {
                $(this.options.selector.navCompare).addClass('d-none');
                $('#nav-comparelist-collapse').removeClass('show');
            }
            if (data.nCount > 1) {
                $('#nav-comparelist-goto').removeClass('d-none');
            } else {
                $('#nav-comparelist-goto').addClass('d-none');
            }
            this.registerProductActions($('#shop-nav'));

            if (data.productID) {
                let $action = $('button[data-product-id-cl="' + data.productID + '"]')
                $action.removeClass("on-list");
                $action.next().removeClass("press");
                $('.comparelist [data-product-id-cl="' + data.productID + '"]').remove();
            }

            for (var ind in data.cBoxContainer) {
                var $list = $(this.options.selector.boxContainer+ind);

                if ($list.length > 0) {
                    if (data.cBoxContainer[ind].length) {
                        var $boxContent = $(data.cBoxContainer[ind]);
                        this.registerProductActions($boxContent);
                        $list.replaceWith($boxContent).removeClass('d-none');
                    } else {
                        $list.html('').addClass('d-none');
                    }
                }
            }
        },

        addToWishlist: function(data, $action) {
            let productId = parseInt(data[this.options.input.id]),
                childId = parseInt(data[this.options.input.childId]),
                qty =  parseInt(data[this.options.input.quantity]);
            if (childId > 0) {
                productId = childId;
            }
            if (isNaN(qty)) {
                qty = 1;
            }
            if (productId > 0) {
                var that = this;
                $.evo.io().call('pushToWishlist', [productId, qty, data], that, function(error, data) {
                    if (error) {
                        $action.closest('form')[0].reportValidity();
                        return;
                    }
                    if ($action.hasClass('action-tip-animation-b')) {
                        $action.addClass("on-list");
                        $action.next().addClass("press");
                        $action.next().next().removeClass("press");
                    }
                    var response = data.response;

                    if (response) {
                        switch (response.nType) {
                            case 0: // error
                                var errorlist = '<ul><li>' + response.cHints.join('</li><li>') + '</li></ul>';
                                eModal.alert({
                                    title: response.cTitle,
                                    message: errorlist,
                                    keyboard: true,
                                    tabindex: -1,
                                    buttons: false
                                });
                                break;
                            case 1: // forwarding
                                window.location.href = response.cLocation;
                                break;
                            case 2: // added to wishlist
                                that.updateWishlist(response);
                                break;
                        }
                    }
                });

                return true;
            }

            return false;
        },

        removeFromWishList: function(data) {
            var productId = parseInt(data[this.options.input.id]);
            if (productId > 0) {
                var that = this;
                $.evo.io().call('removeFromWishlist', [productId], that, function(error, data) {
                    if (error) {
                        return;
                    }

                    var response = data.response;

                    if (response) {
                        switch (response.nType) {
                            case 0: // error
                                var errorlist = '<ul><li>' + response.cHints.join('</li><li>') + '</li></ul>';
                                eModal.alert({
                                    title: response.cTitle,
                                    message: errorlist,
                                    keyboard: true,
                                    tabindex: -1,
                                    buttons: false
                                });
                                break;
                            case 1: // forwarding
                                window.location.href = response.cLocation;
                                break;
                            case 2: // removed from wishlist
                                that.updateWishlist(response);
                                break;
                        }
                    }
                });

                return true;
            }

            return false;
        },

        updateWishlist: function(data) {
            var $navContainerWish = $(this.options.selector.navContainerWish);
            var $navBadgeWish = $(this.options.selector.navBadgeWish);

            if (data.wlPosRemove) {
                let $action = $('button[data-wl-pos="' + data.wlPosRemove + '"]');
                $action.removeClass("on-list");
                $action.next().removeClass("press");
                $action.find('.wishlist-icon').addClass('far').removeClass('fas');
            }
            if (data.wlPosAdd) {
                let $action = $('button[data-product-id-wl="' + data.productID + '"]');
                $action.attr('data-wl-pos', data.wlPosAdd);
                $action.data('wl-pos', data.wlPosAdd);
                $action.closest('form').find('input[name="wlPos"]').val(data.wlPosAdd)
                $action.find('.wishlist-icon').addClass('fas').removeClass('far');
            }
            $.evo.io().call('updateWishlistDropdown', [$navContainerWish, $navBadgeWish], this, function(error, data) {
                if (error) {
                    return;
                }
                if (data.response.currentPosCount > 0) {
                    $navBadgeWish.removeClass('d-none');
                } else {
                    $navBadgeWish.addClass('d-none');
                }
                $navContainerWish.html(data.response.content);
                $navBadgeWish.html(data.response.currentPosCount);
                setClickableRow();
            });

            for (var ind in data.cBoxContainer) {
                var $list = $(this.options.selector.boxContainerWish+ind);
                if ($list.length > 0) {
                    if (data.cBoxContainer[ind].length) {
                        var $boxContent = $(data.cBoxContainer[ind]);
                        this.registerProductActions($boxContent);
                        $list.replaceWith($boxContent).removeClass('d-none');
                    } else {
                        $list.html('').addClass('d-none');
                    }
                }
            }
        },

        handleProductAction: function(action, data) {
            let $action = $(action);
            switch (action.name) {
                case this.options.action.compareList:
                    if ($action.hasClass('action-tip-animation-b')) {
                        if ($action.hasClass('on-list')) {
                            $action.removeClass("on-list");
                            $action.next().removeClass("press");
                            $action.next().next().addClass("press");
                            return this.removeFromCompareList(data);
                        } else {
                            $action.addClass("on-list");
                            $action.next().addClass("press");
                            $action.next().next().removeClass("press");
                            $(this.options.selector.navCompare).removeClass('d-none');

                            let $moveTo = isMobileByBodyClass()
                                ? $('.wish-compare-animation-mobile #burger-menu')
                                : $('.wish-compare-animation-desktop #shop-nav-compare');
                            $.evo.article().moveItemAnimation($action, $moveTo);

                            return this.addToComparelist(data, $action);
                        }
                    } else {
                        return this.addToComparelist(data, $action);
                    }
                case this.options.action.compareListRemove:
                    return this.removeFromCompareList(data);
                case this.options.action.wishList:
                    data[this.options.input.quantity] = $('#buy_form_'+data.a+' '+this.options.selector.quantity).val();
                    if ($action.hasClass('on-list')) {
                        $action.removeClass("on-list");
                        $action.next().removeClass("press");
                        $action.next().next().addClass("press");
                        data.a = data.wlPos;
                        return this.removeFromWishList(data);
                    } else {
                        $action.addClass("on-list");
                        let $moveTo = isMobileByBodyClass()
                            ? $('.wish-compare-animation-mobile #burger-menu')
                            : $('.wish-compare-animation-desktop #shop-nav-wish');
                        $.evo.article().moveItemAnimation($action, $moveTo);
                        return this.addToWishlist(data, $action);
                    }
                case this.options.action.wishListRemove:
                    return this.removeFromWishList(data);
            }

            return false;
        },

        configurator: function(init) {
            if (this.isSingleArticle()) {
                var that      = this,
                    container = $('#cfg-container'),
                    sidebar   = $('#cfg-sticky-sidebar'),
                    width,
                    form;

                if (container.length === 0) {
                    return;
                }

                $.evo.extended().startSpinner(container);

                $('#buy_form').find('*[data-selected="true"]')
                    .attr('checked', true)
                    .attr('selected', true)
                    .attr('data-selected', null);

                form = $.evo.io().getFormValues('buy_form');

                $.evo.io().call('buildConfiguration', [form], that, function (error, data) {
                    var result,
                        i,
                        j,
                        item,
                        cBeschreibung,
                        quantityWrapper,
                        grp,
                        value,
                        enableQuantity,
                        nNetto,
                        quantityInput;
                    $('.js-start-configuration').prop('disabled', !(data.response.variationsSelected && data.response.inStock));
                    $('.js-choose-variations-wrapper').toggleClass('d-none', data.response.variationsSelected);
                    $('.js-cfg-group').each(function (i, item) {
                        let iconChecked     = $(this).find('.js-group-checked'),
                            badgeInfoDanger = 'alert-info';
                        if (data.response.invalidGroups && data.response.invalidGroups.includes($(this).data('id'))) {
                            iconChecked.addClass('d-none');
                            iconChecked.next().removeClass('d-none');
                            if ($(this).find('.js-cfg-group-collapse').hasClass('visited')) {
                                badgeInfoDanger = 'alert-danger';
                            }
                            $(this).find('.js-group-badge-checked')
                                .removeClass('alert-success alert-info')
                                .addClass(badgeInfoDanger);
                            $(this).find('.js-cfg-next').prop('disabled', true);
                        } else {
                            if ($(this).hasClass('visited')) {
                                iconChecked.removeClass('d-none');
                                iconChecked.next().addClass('d-none');
                            }
                            $(this).find('.js-group-badge-checked')
                                .addClass('alert-success')
                                .removeClass('alert-danger alert-info');
                            $(this).find('.js-cfg-next').prop('disabled', false);
                        }
                    });
                    $('.js-cfg-group-error').addClass('d-none').html('');
                    $.each(data.response.errorMessages, function (i, item) {
                        $('.js-cfg-group-error[data-id="' + item.group + '"]').removeClass('d-none').html(item.message);
                    });
                    if (data.response.valid) {
                        $('.js-cfg-validate').prop('disabled', false);
                        $('#cfg-tab-summary-finish').children().removeClass('disabled');
                        $('#cfg-tab-summary-finish').removeClass('disabled');
                    } else {
                        $('.js-cfg-validate').prop('disabled', true);
                        $('#cfg-tab-summary-finish').children().addClass('disabled');
                        $('#cfg-tab-summary-finish').addClass('disabled');
                    }
                    $.evo.extended().stopSpinner();
                    if (error) {
                        $.evo.error(data);
                        return;
                    }
                    result = data.response;

                    if (!result.oKonfig_arr) {
                        $.evo.error('Missing configuration groups');
                        return;
                    }

                    // global price
                    nNetto = result.nNettoPreise;
                    that.setPrice(result.fGesamtpreis[nNetto], result.cPreisLocalized[nNetto], result.cPreisString);
                    that.setStockInformation(result.cEstimatedDelivery);

                    $('#content .summary').html(result.cTemplate);

                    $.evo.extended()
                        .trigger('priceChanged', result);
                });
            }
        },

        initConfigListeners: function () {
            let that   = this;
            $('.js-cfg-group').on('click', function () {
                let self = $(this);
                setTimeout(function() {
                    $(this).closest('.tab-content').animate({
                        scrollTop: self.offset().top
                    }, 500);
                }, 200);
            });
            $('#cfg-accordion .js-cfg-group-collapse').on('shown.bs.collapse', function () {
                if (!$(this).find('select').is(":focus")) {
                    $(this).prev()[0].scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
            $('.js-cfg-next').on('click', function () {
                $('button[data-target="' +  $(this).data('target') + '"]')
                    .prop('disabled', false)
                    .closest('.js-cfg-group').addClass('visited').tooltip('disable');
                that.configurator();
            });
            $('#cfg-tab-summary-finish').on('click', function () {
                if (!$(this).hasClass('disabled')) {
                    $('#cfg-modal-tabs').find('.nav-link').removeClass('active');
                    $('#cfg-tab-summary').children().addClass('active');
                    $(this).children().removeClass('active');
                }
            });
            $('.js-cfg-group-collapse').on('click', function () {
                $(this).addClass('visited');
            });
        },

        variationRefreshAll: function($wrapper) {
            $('.variations select', $wrapper).selectpicker('refresh');
        },

        getConfigGroupQuantity: function (groupId) {
            return $('.cfg-group[data-id="' + groupId + '"] .quantity');
        },

        getConfigGroupQuantityInput: function (groupId) {
            return $('.cfg-group[data-id="' + groupId + '"] .quantity input');
        },

        getConfigGroupImage: function (groupId) {
            return $('.cfg-group[data-id="' + groupId + '"] .group-image img');
        },

        setConfigItemImage: function (groupId, img) {
            $('.cfg-group[data-id="' + groupId + '"] .group-image img').attr('src', img).first();
        },

        setConfigItemDescription: function (groupId, itemBeschreibung) {
            var groupItems                       = $('.cfg-group[data-id="' + groupId + '"] .group-items');
            var descriptionDropdownContent       = groupItems.find('#filter-collapsible_dropdown_' + groupId + '');
            var descriptionDropdownContentHidden = groupItems.find('.d-none');
            var descriptionCheckdioContent       = groupItems.find('div[id^="filter-collapsible_checkdio"]');
            var multiselect                      = groupItems.find('select').attr("multiple");

            //  Bisher kein Content mit einer Beschreibung vorhanden, aber ein Artikel mit Beschreibung ausgewählt
            if (descriptionDropdownContentHidden.length > 0 && descriptionCheckdioContent.length === 0 && itemBeschreibung.length > 0 && multiselect !== "multiple") {
                groupItems.find('a[href="#filter-collapsible_dropdown_' + groupId + '"]').removeClass('d-none');
                descriptionDropdownContent.replaceWith('<div id="filter-collapsible_dropdown_' + groupId + '" class="collapse top10 panel-body">' + itemBeschreibung + '</div>');
                //  Bisher Content mit einer Beschreibung vorhanden, aber ein Artikel ohne Beschreibung ausgewählt
            } else if (descriptionDropdownContentHidden.length === 0 && descriptionCheckdioContent.length === 0 && itemBeschreibung.length === 0 && multiselect !== "multiple") {
                groupItems.find('a[href="#filter-collapsible_dropdown_' + groupId + '"]').addClass('d-none');
                descriptionDropdownContent.addClass('d-none');
                //  Bisher Content mit einer Beschreibung vorhanden und ein Artikel mit Beschreibung ausgewählt
            } else if (descriptionDropdownContentHidden.length === 0 && descriptionCheckdioContent.length === 0 && itemBeschreibung.length > 0 && multiselect !== "multiple") {
                descriptionDropdownContent.replaceWith('<div id="filter-collapsible_dropdown_' + groupId + '" class="collapse top10 panel-body">' + itemBeschreibung + '</div>');
            }
        },

        setPrice: function(price, fmtPrice, priceLabel, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            if (this.isSingleArticle()) {
                $('#product-offer .price', $wrapper).html(fmtPrice);
                if (priceLabel.length > 0) {
                    $('#product-offer .price_label', $wrapper).html(priceLabel);
                }
            } else {
                var $price = $('.price_wrapper', $wrapper);

                $('.price span:first-child', $price).html(fmtPrice);
                if (priceLabel.length > 0) {
                    $('.price_label', $price).html(priceLabel);
                }
            }

            $.evo.trigger('changed.article.price', { price: price });
        },

        setStockInformation: function(cEstimatedDelivery, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('.delivery-status .estimated-delivery span', $wrapper).html(cEstimatedDelivery);
        },

        setStaffelPrice: function(prices, fmtPrices, wrapper) {
            var $wrapper   = this.getWrapper(wrapper),
                $container = $('#product-offer', $wrapper);

            $.each(fmtPrices, function(index, value){
                $('.bulk-price-' + index + ' .bulk-price', $container).html(value);
            });
        },

        setVPEPrice: function(fmtVPEPrice, VPEPrices, fmtVPEPrices, wrapper) {
            var $wrapper   = this.getWrapper(wrapper),
                $container = $('#product-offer', $wrapper);

            $('.base-price .value', $container).html(fmtVPEPrice);
            $.each(fmtVPEPrices, function(index, value){
                $('.bulk-price-' + index + ' .bulk-base-price', $container).html(value);
            });
        },

        /**
         * @deprecated since 4.05 - use setArticleWeight instead
         */
        setUnitWeight: function(UnitWeight, newUnitWeight) {
            $('#article-tabs .product-attributes .weight-unit').html(newUnitWeight);
        },

        setArticleWeight: function(ArticleWeight, wrapper) {
            if (this.isSingleArticle()) {
                var $articleTabs = $('#article-tabs');

                if ($.isArray(ArticleWeight)) {
                    $('.product-attributes .weight-unit', $articleTabs).html(ArticleWeight[0][1]);
                    $('.product-attributes .weight-unit-article', $articleTabs).html(ArticleWeight[1][1]);
                } else {
                    $('.product-attributes .weight-unit', $articleTabs).html(ArticleWeight);
                }
            } else {
                var $wrapper = this.getWrapper(wrapper);

                if ($.isArray(ArticleWeight)) {
                    $('.attr-weight .value', $wrapper).html(ArticleWeight[0][1]);
                    $('.attr-weight.weight-unit-article .value', $wrapper).html(ArticleWeight[1][1]);
                } else {
                    $('.attr-weight .value', $wrapper).html(ArticleWeight);
                }
            }

        },

        setProductNumber: function(productNumber, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('#product-offer span[itemprop="sku"]', $wrapper).html(productNumber);
        },

        setArticleContent: function(id, variation, url, variations, wrapper) {
            var $wrapper  = this.getWrapper(wrapper),
                listStyle = $('#product-list-type').val();

                if (listStyle === 'undefined') {
                    listStyle = $('#ed_list.active').length > 0 ? 'list' : 'gallery';
                }

                $.evo.extended().startSpinner($wrapper);

            if (this.modalShown) {
                this.loadModalArticle(url, wrapper,
                    function() {
                        var article = new ArticleClass();
                        article.register(wrapper);
                        $.evo.extended().stopSpinner();
                    },
                    function() {
                        $.evo.extended().stopSpinner();
                        $.evo.error('Error loading ' + url);
                    }
                );
            } else if (this.isSingleArticle()) {
                $.evo.extended().loadContent(url, function (content) {
                    $.evo.extended().register();
                    $.evo.article().register(wrapper);

                    $(variations).each(function (i, item) {
                        $.evo.article().variationSetVal(item.key, item.value, wrapper);
                    });

                    if (document.location.href !== url) {
                        history.pushState({a: id, a2: variation, url: url, variations: variations}, "", url);
                    }
                    $.evo.extended().stopSpinner();
                }, function () {
                    $.evo.error('Error loading ' + url);
                    $.evo.extended().stopSpinner();
                }, false, wrapper);
            } else {
                $.evo.extended().loadContent(url + (url.indexOf('?') >= 0 ? '&' : '?') + 'isListStyle=' + listStyle, function (content) {
                    $.evo.article().register(wrapper);

                    $('[data-toggle="basket-add"]', $(wrapper)).on('submit', function(event) {
                        event.preventDefault();
                        event.stopPropagation();

                        var $form = $(this);
                        var data  = $form.serializeObject();
                        data['a'] = variation;

                        $.evo.basket().addToBasket($form, data);
                    });

                    $(variations).each(function (i, item) {
                        $.evo.article().variationSetVal(item.key, item.value, wrapper);
                    });

                    $.evo.extended().stopSpinner();
                }, function () {
                    $.evo.error('Error loading ' + url);
                    $.evo.extended().stopSpinner();
                }, false, wrapper);
            }
        },

        variationResetAll: function(wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('.variation[data-value] input:checked', $wrapper).prop('checked', false);
            $('.variations select option', $wrapper).prop('selected', false);
            $('.variations select', $wrapper).selectpicker('refresh');
        },

        variationDisableAll: function(wrapper) {
            let $wrapper = this.getWrapper(wrapper);

            $('.swatches-selected', $wrapper).text('');
            $('[data-value].variation', $wrapper).each(function(i, item) {
                $(item)
                    .removeClass('active loading')
                    .addClass('not-available');
                $.evo.article()
                    .removeStockInfo($(item));
            });
        },

        variationSetVal: function(key, value, wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('[data-key="' + key + '"]', $wrapper).val(value);
        },

        variationEnable: function(key, value, wrapper) {
            var $wrapper = this.getWrapper(wrapper),
                $item    = $('[data-value="' + value + '"].variation', $wrapper);

            $item.removeClass('not-available swatches-sold-out swatches-not-in-stock');
        },

        variationActive: function(key, value, def, wrapper) {
            var $wrapper = this.getWrapper(wrapper),
                $item    = $('[data-value="' + value + '"].variation', $wrapper);
            $item.addClass('active')
                .find('input')
                .prop('checked', true)
                .end()
                .prop('selected', true);

            $('[data-id="'+key+'"].swatches-selected')
                .text($item.attr('data-original'));
        },

        removeStockInfo: function($item) {
            if (this.isSingleArticle()) {
                var type = $item.attr('data-type'),
                    elem,
                    label,
                    wrapper;

                switch (type) {
                    case 'option':
                        label = $item.data('content');
                        wrapper = $('<div />').append(label);
                        $(wrapper)
                            .find('.badge-not-available')
                            .remove();
                        label = $(wrapper).html();
                        $item.data('content', label)
                            .attr('data-content', label);

                        break;
                    case 'radio':
                        elem = $item.find('.badge-not-available');
                        if (elem.length === 1) {
                            $(elem).remove();
                        }
                        break;
                    case 'swatch':
                        $item.tooltip('dispose');
                        break;
                }

                $item.removeAttr('data-stock');
            }
        },

        variationInfo: function(value, status, note, notExists) {
            let $item = $('[data-value="' + value + '"].variation'),
                type = $item.attr('data-type'),
                text,
                content,
                $wrapper,
                label;

            $item.attr('data-stock', _stock_info[status]);

            switch (type) {
                case 'option':
                    text     = ' (' + note + ')';
                    content  = $item.data('content');
                    $wrapper = $('<div />');

                    $wrapper.append(content);
                    $wrapper
                        .find('.badge-not-available')
                        .remove();

                    label = $('<span />')
                        .addClass('badge badge-danger badge-not-available')
                        .text(' '+note);

                    $wrapper.append(label);

                    $item.data('content', $wrapper.html())
                        .attr('data-content', $wrapper.html());

                    $item.closest('select')
                        .selectpicker('refresh');
                    break;
                case 'radio':
                    $item.find('.badge-not-available')
                        .remove();

                    label = $('<span />')
                        .addClass('badge badge-danger badge-not-available')
                        .text(' '+note);

                    $item.append(label);
                    break;
                case 'swatch':
                    $item.tooltip({
                        title: note,
                        trigger: 'hover',
                        container: 'body'
                    });
                    if (notExists) {
                        $item.addClass('swatches-not-in-stock');
                    } else {
                        $item.addClass('swatches-sold-out');
                    }
                    break;
            }
        },

        variationSwitch: function($item, animation, wrapper) {
            if ($item) {
                var formID   = $item.closest('form').attr('id'),
                    $current = this.getCurrent($item),
                    key      = $current.data('key'),
                    value    = $current.data('value'),
                    io       = $.evo.io(),
                    args     = io.getFormValues(formID),
                    $wrapper = this.getWrapper(wrapper);

                if (animation) {
                    $.evo.extended().startSpinner();
                } else {
                    $('.updatingStockInfo', $wrapper).show();
                }

                $('.tooltip.show').remove();
                args.wrapper = wrapper;

                $.evo.article()
                    .variationDispose(wrapper);

                io.call('checkVarkombiDependencies', [args, key, value], $item, function (error, data) {
                    if (animation) {
                        $.evo.extended().stopSpinner();
                    }
                    $('.updatingStockInfo', $wrapper).hide();
                    if (error) {
                        $.evo.error('checkVarkombiDependencies');
                    }
                });
            }
        },

        variationPrice: function($item, animation, wrapper) {
            var formID   = $item.closest('form').attr('id'),
                $wrapper = this.getWrapper(wrapper),
                io       = $.evo.io(),
                args     = io.getFormValues(formID);

            if (animation) {
                $.evo.extended().startSpinner();
            }

            args.wrapper = wrapper;
            io.call('checkDependencies', [args], $(this), function (error, data) {
                let $action = $('button[data-product-id-wl="' + data.response.itemID + '"]');
                if (data.response.check > 0) {
                    $action.attr('data-wl-pos', data.response.check);
                    $action.data('wl-pos', data.response.check);
                    $action.closest('form').find('input[name="wlPos"]').val(data.response.check)
                    $action.addClass('on-list');
                } else {
                    $action.removeClass('on-list');
                }

                if (animation) {
                    $.evo.extended().stopSpinner();
                }
                if (error) {
                    $.evo.error('checkDependencies');
                }
            });
        },

        variationDispose: function(wrapper) {
            var $wrapper = this.getWrapper(wrapper);

            $('[role="tooltip"]', $wrapper).remove();
        },

        moveItemAnimation: function(item, moveTo) {
            if (!item.length || !moveTo.length || $(this).hasClass('on-list')) {
                return;
            }
            setTimeout(function() {
                let itemClone = item.clone()
                    .offset({
                        top: item.offset().top,
                        left: item.offset().left
                    }).css({
                        'opacity': '0.5',
                        'position': 'absolute',
                        'z-index': '10000'
                    })
                    .appendTo($('body'))
                    .animate({
                        'top': moveTo.offset().top + 5,
                        'left': moveTo.offset().left + 5,
                    }, 700);

                itemClone.animate({
                    'width': 0,
                    'height': 0
                }, function () {
                    $(this).detach()
                });
            }, 0);
        },

        initAbnahmeIntervallError: function() {
            let $intervallNotice = $('#intervall-notice');
            if ($intervallNotice.length > 0) {
                $('#quantity').on('change', function () {
                    let $step   = $(this).attr('step'),
                        diff    = Math.abs(($(this).val() % $step) - $step),
                        epsilon = 0.00000001;
                    if (diff < epsilon || diff + epsilon > $step) {
                        $('#intervall-notice-danger').remove();
                    } else {
                        $('#quantity-grp').after('<div id="intervall-notice-danger" class="alert alert-danger mt-2">'
                            + $intervallNotice.html() + '</div>');
                    }
                });
            }
        }
    };

    $v = new ArticleClass();

    $(document).ready(function () {
        $v.onLoad();
        $v.register();
    });

    $(window).on('resize',
        viewport.changed(function(){
            $v.configurator();
        })
    );

    // PLUGIN DEFINITION
    // =================
    $.evo.article = function () {
       return $v;
    };
})(jQuery, document, window, ResponsiveBootstrapToolkit);
