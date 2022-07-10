(function () {
    'use strict';

    if (!$.evo) {
        $.evo = {};
    }

    var EvoClass = function() {};

    EvoClass.prototype = {
        options: {
            captcha: {},
            scrollSearch: '.smoothscroll-top-search'
        },

        constructor: EvoClass,

        generateSlickSlider: function() {
            let self = this;
            self.initSlick($('.evo-box-slider:not(.slick-initialized)'), 'box-slider');
            self.initSlick($('.evo-slider-half:not(.slick-initialized)'), 'slider-half');
            self.initSlick($('.evo-slider:not(.slick-initialized)'), 'product-slider');
            self.initSlick($('.news-slider:not(.slick-initialized)'), 'news-slider');

            $('.slick-lazy').on('mouseenter', function (e) {
                let mainNode = $(this);
                mainNode.removeClass('slick-lazy');
                if (!mainNode.hasClass('slick-initialized')) {
                    mainNode.find('.product-wrapper').removeClass('mx-auto ml-auto-util mr-auto');
                    self.initSlick(mainNode, mainNode.data('slick-type'));
                }
            });

            document.querySelectorAll('.slick-lazy').forEach(function(slickItem) {
                let startX;
                let supportsPassive = false;
                try {
                    let opts = Object.defineProperty({}, 'passive', {
                        get: function() {
                            supportsPassive = true;
                        }
                    });
                    window.addEventListener("testPassive", null, opts);
                    window.removeEventListener("testPassive", null, opts);
                } catch (e) {}

                slickItem.addEventListener('touchstart', function (e) {
                    startX = e.changedTouches[0].pageX;

                },supportsPassive ? { passive: true } : false);
                slickItem.addEventListener('touchmove', function (e) {
                    let mainNode = $(this);
                    if (!mainNode.hasClass('slick-initialized')
                        && Math.abs(startX - e.changedTouches[0].pageX) > 80
                    ) {
                        mainNode.removeClass('slick-lazy');
                        mainNode.find('.product-wrapper').removeClass('mx-auto ml-auto-util mr-auto');
                        self.initSlick(mainNode, mainNode.data('slick-type'));
                        let slickOptions = mainNode.slick('getSlick');
                        if(slickOptions.slideCount > mainNode.slick('slickGetOption', 'slidesToShow')) {
                            let goTo;
                            $.each(slickOptions.originalSettings.responsive, function (key, value) {
                                if (value.breakpoint === slickOptions.activeBreakpoint
                                    && value.settings.slidesToShow !== undefined
                                ) {
                                    goTo = value.settings.slidesToShow;
                                }
                            });
                            if (goTo === undefined) {
                                goTo = slickOptions.originalSettings.slidesToScroll
                            }
                            mainNode.slick('slickGoTo', goTo || 2);
                        }
                    }
                }, supportsPassive ? { passive: true } : false);
            });
        },

        initSlick: function (node, sliderType) {
            let sliderOptions = {
                'box-slider' : {
                    arrows:         false,
                    lazyLoad:       'ondemand',
                    slidesToShow:   1,
                    slidesToScroll: 1,
                    mobileFirst:    true,
                    responsive: [
                        {
                            breakpoint: 992,
                            settings: {
                                arrows: true,
                            }
                        }
                    ]
                },
                'slider-half' : {
                    arrows:       false,
                    lazyLoad:     'ondemand',
                    mobileFirst:    true,
                    slidesToShow: 2,
                    slidesToScroll: 2,
                    responsive:   [
                        {
                            breakpoint: 992,
                            settings: {
                                arrows: true,
                            }
                        },
                        {
                            breakpoint: 1300,
                            settings: {
                                slidesToShow: 3,
                                slidesToScroll: 3,
                                arrows: true,
                            }
                        }
                    ]
                },
                'slider-three' : {
                    arrows:       false,
                    lazyLoad:     'ondemand',
                    mobileFirst:    true,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    responsive:   [
                        {
                            breakpoint: 768,
                            settings: {
                                slidesToShow: 2,
                                slidesToScroll: 2,
                            }
                        },
                        {
                            breakpoint: 992,
                            settings: {
                                arrows: true,
                            }
                        },
                        {
                            breakpoint: 1300,
                            settings: {
                                arrows: true,
                                slidesToShow: 3,
                                slidesToScroll: 3,
                            }
                        }
                    ]
                },
                'product-slider' : {
                    rows:           0,
                    arrows:         false,
                    lazyLoad:       'ondemand',
                    slidesToShow:   2,
                    slidesToScroll: 2,
                    mobileFirst:    true,
                    responsive:     [
                        {
                            breakpoint: 768,
                            settings: {
                                slidesToShow: 3,
                                slidesToScroll: 3
                            }
                        },
                        {
                            breakpoint: 992,
                            settings: {
                                slidesToShow:5,
                                arrows: true,
                                slidesToScroll: 5
                            }
                        },
                        {
                            breakpoint: 1300,
                            settings: {
                                slidesToShow:7,
                                arrows: true,
                                slidesToScroll: 7
                            }
                        }
                    ]
                },
                'news-slider' : {
                    rows:           0,
                    slidesToShow:   1,
                    slidesToScroll: 1,
                    arrows:         false,
                    infinite:       false,
                    lazyLoad:       'ondemand',
                    mobileFirst:    true,
                    responsive:     [
                        {
                            breakpoint: 768,
                            settings: {
                                slidesToShow: 2,
                                slidesToScroll: 2,
                            }
                        },
                        {
                            breakpoint: 992,
                            settings: {
                                slidesToShow:3,
                                slidesToScroll: 3,
                                arrows: true
                            }
                        },
                        {
                            breakpoint: 1300,
                            settings: {
                                slidesToShow:5,
                                slidesToScroll: 5,
                                arrows: true
                            }
                        }
                    ]
                },
                'freegift' : {
                    slidesToShow:   3,
                    slidesToScroll: 3,
                    arrows:   false,
                    infinite: false,
                    responsive: [
                        {
                            breakpoint: 768,
                            settings: {
                                slidesToShow: 2,
                                slidesToScroll: 2,
                            }
                        },
                        {
                            breakpoint: 992,
                            settings: {
                                arrows: true
                            }
                        }
                    ]
                },
                'gallery' : {
                    lazyLoad: 'ondemand',
                    infinite: true,
                    dots:     false,
                    arrows:   true,
                    speed: 500,
                    fade: true,
                    cssEase: 'linear',
                    asNavFor: '#gallery_preview',
                    responsive:     [
                        {
                            breakpoint: 992,
                            settings: {
                                dots: true
                            }
                        }
                    ]
                },
                'gallery_preview' : {
                    lazyLoad:       'ondemand',
                    slidesToShow:   5,
                    slidesToScroll: 1,
                    asNavFor:       '#gallery',
                    dots:           false,
                    arrows:         true,
                    focusOnSelect:  true,
                    responsive:     [
                        {
                            breakpoint: 768,
                            settings:   {
                                slidesToShow: 4,
                                slidesToScroll: 1,
                            }
                        },
                        {
                            breakpoint: 576,
                            settings: {
                                slidesToShow: 3,
                                slidesToScroll: 1,
                            }
                        }
                    ]
                }
            };
            if ($('#content').hasClass('col-lg-9')) {
                sliderOptions['news-slider']['slidesToShow'] = 2;
            }
            if (sliderType === 'gallery_preview') {
                sliderType = 'gallery';
                node = $('#gallery');
            }
            if (sliderType === 'gallery') {
                $('.js-gallery-images').removeClass('d-none');
                $('.slick-inital-arrow').remove();
                $('.initial-slick-dots').remove();
                $('#gallery_preview').slick(sliderOptions['gallery_preview']);
            }

            return node.slick(sliderOptions[sliderType]);
        },

        scrollStuff: function() {
            var breakpoint = 0,
                pos,
                sidePanel = $('#sidepanel_left');

            if(sidePanel.length) {
                breakpoint = sidePanel.position().top + sidePanel.hiddenDimension('height');
            }

            pos = breakpoint - $(this).scrollTop();

            if ($(this).scrollTop() > 200 && !$('#to-top').hasClass('active')) {
                $('#to-top').addClass('active');
            } else if($(this).scrollTop() < 200 && $('#to-top').hasClass('active')) {
                $('#to-top').removeClass('active');
            }

            if ($(window).width() > 768) {
                var $document = $(document),
                    $element = $('.navbar-fixed-top'),
                    className = 'nav-closed';

                $document.scroll(function() {
                    $element.toggleClass(className, $document.scrollTop() >= 150);
                });

            }
        },

        productTabsPriceFlow: function() {
            var dateFormat = 'DD.MM.YYYY';
            if ($('html').attr('lang') !== 'de') {
                dateFormat = 'MM/DD/YYYY';
            }
            var chartOptions = {
                responsive:       true,
                scaleBeginAtZero: false,
                aspectRatio:3,
                tooltips: {
                    callbacks: {
                        label: function (tooltipItem, data) {
                            var label = window.chartDataTooltip;
                            label += Math.round(tooltipItem.yLabel * 100) / 100;
                            label += ' '+window.chartDataCurrency;
                            return label;
                        }
                    }
                },
                scales: {
                    xAxes: [{
                        type: 'time',
                        time: {
                            parser: 'DD.MM.YYYY',
                            // round: 'day'
                            tooltipFormat: dateFormat
                        },
                        display: false
                    }],
                }
            };
            if ($('#tab-link-priceFlow').length) {
                // using tabs
                $('#tab-link-priceFlow').on('shown.bs.tab', function () {
                    if (typeof window.priceHistoryChart !== 'undefined' && window.priceHistoryChart === null) {
                        window.priceHistoryChart = new Chart(window.ctx, {
                            type: 'line',
                            data: window.chartData,
                            options: chartOptions
                        });
                    }
                });
                $('#tab-content-product-tabs').on('afterChange', function (event, slick) {
                    if (typeof window.priceHistoryChart !== 'undefined' && window.priceHistoryChart === null) {
                        window.priceHistoryChart = new Chart(window.ctx, {
                            type: 'line',
                            data: window.chartData,
                            options: chartOptions
                        });
                    }
                });
            } else {
                // using cards
                $('#tab-priceFlow').on('shown.bs.collapse', function () {
                    if (typeof window.priceHistoryChart !== 'undefined' && window.priceHistoryChart === null) {
                        window.priceHistoryChart = new Chart(window.ctx, {
                            type: 'line',
                            data: window.chartData,
                            options: chartOptions
                        });
                    }
                });
            }
        },

        tooltips: function() {
            $('[data-toggle="tooltip"]').tooltip();
        },

        bootlint: function() {
            (function(){
                var p = window.alert;
                var s = document.createElement("script");
                window.alert = function() {
                    console.info(arguments);
                };
                s.onload = function() {
                    bootlint.showLintReportForCurrentDocument([]);
                    window.alert = p;
                };
                s.src = "https://maxcdn.bootstrapcdn.com/bootlint/latest/bootlint.min.js";
                document.body.appendChild(s);
            })();
        },

        showNotify: function(options) {
            eModal.alert({
                size: 'xl',
                buttons: false,
                title: options.title,
                message: options.text,
                keyboard: true,
                tabindex: -1})
                .then(
                 function() {
                    $.evo.generateSlickSlider();
                }
            );
        },

        popupDep: function() {
            $('#main-wrapper').on('click', '.popup-dep', function(e) {
                var id    = '#popup' + $(this).attr('id'),
                    title = $(this).attr('title'),
                    html  = $(id).html();
                eModal.alert({
                    message: html,
                    title: title,
                    keyboard: true,
                    buttons: false,
                    tabindex: -1})
                    .then(
                        function () {
                            //the modal just copies all the html.. so we got duplicate IDs which confuses recaptcha
                            var recaptcha = $('.tmp-modal-content .g-recaptcha');
                            if (recaptcha.length === 1) {
                                var siteKey = recaptcha.data('sitekey'),
                                    newRecaptcha = $('<div />');
                                if (typeof  siteKey !== 'undefined') {
                                    //create empty recapcha div, give it a unique id and delete the old one
                                    newRecaptcha.attr('id', 'popup-recaptcha').addClass('g-recaptcha form-group');
                                    recaptcha.replaceWith(newRecaptcha);
                                    grecaptcha.render('popup-recaptcha', {
                                        'sitekey' : siteKey,
                                        'callback' : 'captcha_filled'

                                    });
                                }
                            }
                            addValidationListener();
                            $('.g-recaptcha-response').attr('required', true);
                        }
                    );
                return false;
            });
        },

        popover: function() {
            /*
             * <a data-toggle="popover" data-ref="#popover-content123">Click me</a>
             * <div id="popover-content123" class="popover">content here</div>
             */
            $('[data-toggle="popover"]').popover({
                html: true,
                sanitize: false,
                content: function() {
                    var ref = $(this).attr('data-ref');
                    return $(ref).html();
                }
            });
        },

        smoothScrollToAnchor: function(href, pushToHistory) {
            var anchorRegex = /^#[\w\-]+$/;
            if (!anchorRegex.test(href)) {
                return false;
            }

            var target, targetOffset;
            target = $('#' + href.slice(1));

            if (target.length > 0) {
                // scroll below the static megamenu
                var nav         = $('#jtl-nav-wrapper.sticky-top');
                var fixedOffset = nav.length > 0 ? nav.outerHeight() : 0;

                targetOffset = target.offset().top - fixedOffset - parseInt(target.css('margin-top'));
                $('html, body').animate({scrollTop: targetOffset});

                if (pushToHistory) {
                    history.pushState({}, document.title, location.pathname + href);
                }

                return true;
            }

            return false;
        },

        smoothScroll: function() {
            var supportHistory = (history && history.pushState) ? true : false;
            var that = this;

            this.smoothScrollToAnchor(location.hash, false);
            $(document).delegate('a[href^="#"]', 'click', function(e) {
                var elem = e.target;
                if (!e.isDefaultPrevented()) {
                    // only runs if no other click event is fired
                    if (that.smoothScrollToAnchor(elem.getAttribute('href'), supportHistory)) {
                        e.preventDefault();
                    }
                }
            });
        },

        initScrollSearchEvent: function() {
            this.destroyScrollSearchEvent();
            let lastScroll       = 0,
                $scrollTopSearch = $(this.options.scrollSearch);
            if ($scrollTopSearch.length) {
                $(document).on('scroll.search', function () {
                    let newScroll = $(this).scrollTop();
                    if (newScroll < lastScroll) {
                        if ($(window).scrollTop() > 100) {
                            $scrollTopSearch.removeClass('d-none');
                        } else {
                            $scrollTopSearch.addClass('d-none');
                        }
                    } else {
                        $scrollTopSearch.addClass('d-none');
                    }
                    lastScroll = newScroll;
                });
            }
        },

        destroyScrollSearchEvent: function() {
            $(this.options.scrollSearch).addClass('d-none');
            $(document).off('scroll.search');
        },

        initScrollEvents: function() {
            this.initScrollSearchEvent();

            //scroll top button
            let toTopbuttonVisible     = false,
                $toTopbutton           = $('.smoothscroll-top'),
                toTopbuttonActiveClass = 'show';

            function scrolltoTop() {
                $(window).scrollTop(0);
            }

            function handleVisibilityTopButton() {
                let currentPosition = $(window).scrollTop();
                if (currentPosition > 800) {
                    if (!toTopbuttonVisible) {
                        $toTopbutton.addClass(toTopbuttonActiveClass);
                        toTopbuttonVisible = true;
                    }
                } else if (toTopbuttonVisible) {
                    toTopbuttonVisible = false;
                    $toTopbutton.removeClass(toTopbuttonActiveClass)
                }
            }

            if ($toTopbutton.length) {
                $(window).on('scroll', handleVisibilityTopButton);
                $toTopbutton.on('click', scrolltoTop);
                handleVisibilityTopButton();
            }
        },

        addCartBtnAnimation: function() {
            var animating = false;

            initCustomization();

            function initCustomization() {
                var addToCartBtn = $('#add-to-cart button[type="submit"]'),
                    form         = $('#buy_form');
                //detect click on the add-to-cart button
                form.on('submit', function(e) {
                    if(!animating ) {
                        //animate if not already animating
                        animating =  true;

                        addToCartBtn.addClass('is-added').find('path').eq(0).animate({
                            //draw the check icon
                            'stroke-dashoffset':0
                        }, 300, function(){
                            setTimeout(function(){
                                addToCartBtn.removeClass('is-added').find('span.btn-basket-check').on('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(){
                                    //wait for the end of the transition to reset the check icon
                                    addToCartBtn.find('path').eq(0).css('stroke-dashoffset', '19.79');
                                    animating =  false;
                                });

                                if( $('.no-csstransitions').length > 0 ) {
                                    // check if browser doesn't support css transitions
                                    addToCartBtn.find('path').eq(0).css('stroke-dashoffset', '19.79');
                                    animating =  false;
                                }
                            }, 600);
                        });
                    }
                });
            }

        },

        checkout: function() {
            // show only the first submit button (i.g. the button from payment plugin)
            var $submits = $('#checkout-shipping-payment')
                .closest('form')
                .find('button[type="submit"]');
            $submits.addClass('d-none');
            $submits.first().removeClass('d-none');

            $('input[name="Versandart"]', '#checkout-shipping-payment').on('change', function() {
                var id    = parseInt($(this).val());
                var $form = $(this).closest('form');

                if (isNaN(id)) {
                    return;
                }

                $form.find('fieldset, button[type="submit"]')
                    .attr('disabled', true);

                var url = $('#jtl-io-path').data('path') + '/bestellvorgang.php?kVersandart=' + id;
                $.evo.loadContent(url, function() {
                    $.evo.checkout();
                }, null, true);
            });

            $('#country').on('change', function (e) {
                var val = $(this).find(':selected').val();

                $.evo.io().call('checkDeliveryCountry', [val], {}, function (error, data) {
                    var $shippingSwitch = $('#checkout_register_shipping_address');

                    if (data.response) {
                        $shippingSwitch.removeAttr('disabled');
                        $shippingSwitch.parent().removeClass('d-none');
                    } else {
                        $shippingSwitch.attr('disabled', true);
                        $shippingSwitch.parent().addClass('d-none');
                        if ($shippingSwitch.prop('checked')) {
                            $shippingSwitch.prop('checked', false);
                            $('#select_shipping_address').collapse('show');
                        }
                    }
                });
            });
        },

        loadContent: function(url, callback, error, animation, wrapper) {
            var that        = this;
            var $wrapper    = (typeof wrapper === 'undefined' || wrapper.length === 0) ? $('#result-wrapper') : $(wrapper);
            var ajaxOptions = {data: 'isAjax'};
            if (animation) {
                $wrapper.addClass('loading');
            }

            that.trigger('load.evo.content', { url: url });

            $.ajax(url, ajaxOptions).done(function(html) {
                var $data = $(html);
                if (animation) {
                    $data.addClass('loading');
                }
                $wrapper.replaceWith($data);
                $wrapper = $data;
                if (typeof callback === 'function') {
                    callback();
                }
            })
            .fail(function() {
                if (typeof error === 'function') {
                    error();
                }
            })
            .always(function() {
                $wrapper.removeClass('loading');
                that.trigger('contentLoaded'); // compatibility
                that.trigger('loaded.evo.content', { url: url });
            });
        },

        startSpinner: function (target) {
            target = target || $('body');
            if ($('.jtl-spinner').length === 0) {
                target.append('<div class="jtl-spinner"><i class="fa fa-spinner fa-pulse"></i></div>');
            }
        },

        stopSpinner: function () {
            $('.jtl-spinner').remove();
        },

        trigger: function(event, args) {
            $(document).trigger('evo:' + event, args);
            return this;
        },

        error: function() {
            if (console && console.error) {
                console.error(arguments);
            }
        },

        addInactivityCheck: function(wrapper, timeoutMS = 500, stopEnter = false) {
            var timeoutID,
                that = this,
                currentBox;

            setup();

            function setup() {
                $(wrapper + ' .form-counter input, ' + wrapper + ' .choose_quantity input').on('change',resetTimer);
                $(wrapper + ' .form-counter .btn-decrement, ' + wrapper + ' .form-counter .btn-increment')
                    .on('click keydown',resetTimer)
                    .on('touchstart',resetTimer,{passive: true});
                if (stopEnter) {
                    $(wrapper + ' input.quantity').on('keypress', function (e) {
                        if (e.key === 'Enter') {
                            return false;
                        } else {
                            resetTimer(e);
                        }
                    });
                }
            }

            function startTimer() {
                timeoutID = window.setTimeout(goInactive, timeoutMS);
            }

            function resetTimer(e) {
                if (wrapper === '#wl-items-form') {
                    currentBox = $(e.target).closest('.productbox-inner');
                }
                if (timeoutID == undefined) {
                    startTimer();
                }
                window.clearTimeout(timeoutID);

                startTimer();
            }

            function goInactive() {
                if (wrapper === '#cart-form') {
                    $(wrapper).submit();
                } else if (wrapper === '#wl-items-form') {
                    that.updateWishlistItem(currentBox);
                }
            }
        },

        updateWishlistItem: function($wrapper) {
            let formID   = 'wl-items-form';
            $.evo.extended().startSpinner($wrapper);
            $.evo.io().call(
                'updateWishlistItem',
                [
                    $('#' + formID + ' input[name="kWunschliste"]').val(),
                    $.evo.io().getFormValues(formID)
                ],
                $(this) , function(error, data) {
                    $.evo.extended().stopSpinner();
                    $wrapper.removeClass('loading');
                });
        },

        fixStickyElements: function() {
            var sticky    = '.cart-summary';
            var navHeight = $('#jtl-nav-wrapper').outerHeight(true);
            navHeight = navHeight === undefined ? 0 : parseInt(navHeight + 40);
            $(sticky).css('top', navHeight);
        },

        setWishlistVisibilitySwitches: function() {
            $('.wl-visibility-switch').on('change', function () {
                $.evo.io().call(
                    'setWishlistVisibility',
                    [$(this).data('wl-id'), $(this).is(":checked"), $('.jtl_token').val()],
                    $(this),
                    function(error, data) {
                    if (error) {
                        return;
                    }
                    var $wlPrivate    = $('span[data-switch-label-state="private-' + data.response.wlID + '"]'),
                        $wlPublic     = $('span[data-switch-label-state="public-' + data.response.wlID + '"]'),
                        $wlURLWrapper = $('#wishlist-url-wrapper'),
                        $wlURL        = $('#wishlist-url');
                    if (data.response.state) {
                        $wlPrivate.addClass('d-none');
                        $wlPublic.removeClass('d-none');
                        $wlURLWrapper.removeClass('d-none');
                        $wlURL.val($wlURL.data('static-route') + data.response.url)
                    } else {
                        $wlPrivate.removeClass('d-none');
                        $wlPublic.addClass('d-none');
                        $wlURLWrapper.addClass('d-none');
                    }
                });
            });
        },

        initEModals: function () {
            $('.author-modal').on('click', function (e) {
                e.preventDefault();
                let modalID = $(this).data('target');
                eModal.alert({
                    title: $(modalID).attr('title'),
                    message: $(modalID).html(),
                    buttons: false
                });
            });
        },

        initPriceSlider: function ($wrapper, redirect) {
            let priceRange      = $wrapper.find('[data-id="js-price-range"]').val(),
                priceRangeID    = $wrapper.find('[data-id="js-price-range-id"]').val(),
                priceRangeMin   = 0,
                priceRangeMax   = $wrapper.find('[data-id="js-price-range-max"]').val(),
                currentPriceMin = priceRangeMin,
                currentPriceMax = priceRangeMax,
                $priceRangeFrom = $("#" + priceRangeID + "-from"),
                $priceRangeTo = $("#" + priceRangeID + "-to"),
                $priceSlider = document.getElementById(priceRangeID);

            if (priceRange) {
                let priceRangeMinMax = priceRange.split('_');
                currentPriceMin = priceRangeMinMax[0];
                currentPriceMax = priceRangeMinMax[1];
                $priceRangeFrom.val(currentPriceMin);
                $priceRangeTo.val(currentPriceMax);
            }
            noUiSlider.create($priceSlider, {
                start: [parseInt(currentPriceMin), parseInt(currentPriceMax)],
                connect: true,
                range: {
                    'min': parseInt(priceRangeMin),
                    'max': parseInt(priceRangeMax)
                },
                step: 1,
                format: {
                    to: function (value) {
                        return parseInt(value);
                    },
                    from: function (value) {
                        return parseInt(value);
                    }
                }
            });
            $priceSlider.noUiSlider.on('change', function (values, handle) {
                setTimeout(function(){
                    $.evo.redirectToNewPriceRange(values[0] + '_' + values[1], redirect, $wrapper);
                },0);
            });
            $priceSlider.noUiSlider.on('update', function (values, handle) {
                $priceRangeFrom.val(values[0]);
                $priceRangeTo.val(values[1]);
            });
            $('.price-range-input').on('change', function () {
                let prFrom = parseInt($priceRangeFrom.val()),
                    prTo = parseInt($priceRangeTo.val());
                $.evo.redirectToNewPriceRange(
                    (prFrom > 0 ? prFrom : priceRangeMin) + '_' + (prTo > 0 ? prTo : priceRangeMax),
                    redirect,
                    $wrapper
                );
            });
        },

        initFilters: function (href) {
            let $wrapper = $('.js-collapse-filter');
            $.evo.extended().startSpinner($wrapper);

            $.ajax(href, {data: {'useMobileFilters':1}})
                .done(function(data) {
                    $wrapper.html(data);
                    $.evo.initPriceSlider($wrapper, false);
                    $.evo.initItemSearch('filter');
                })
                .always(function() {
                    $.evo.extended().stopSpinner();
                });
        },

        initFilterEvents: function() {
            let initiallized = false;
            $('#js-filters').on('click', function() {
                if (!initiallized) {
                    $.evo.initFilters(window.location.href);
                    initiallized = true;
                }
            });
        },

        redirectToNewPriceRange: function (priceRange, redirect, $wrapper) {
            let currentURL  = window.location.href;
            if (!redirect) {
                currentURL  = $wrapper.find('[data-id="js-price-range-url"]').val();
            }
            let redirectURL = $.evo.updateURLParameter(
                currentURL,
                'pf',
                priceRange
            );
            if (redirect) {
                window.location.href = redirectURL;
            } else {
                $.evo.initFilters(redirectURL);
            }
        },

        updateURLParameter: function (url, param, paramVal) {
            let newAdditionalURL = '',
                tempArray        = url.split('?'),
                baseURL          = tempArray[0],
                additionalURL    = tempArray[1],
                temp             = '';
            if (additionalURL) {
                tempArray = additionalURL.split('&');
                for (let i=0; i<tempArray.length; i++){
                    if(tempArray[i].split('=')[0] != param){
                        newAdditionalURL += temp + tempArray[i];
                        temp = '&';
                    }
                }
            }

            return baseURL + '?' + newAdditionalURL + temp + param + '=' + paramVal;
        },

        updateReviewHelpful: function(item) {
            let formData = $.evo.io().getFormValues('reviews-list');
            formData[item.prop('name')] = '';
            formData['reviewID'] = item.data('review-id');

            $.evo.io().call(
                'updateReviewHelpful',
                [formData],
                $(this) , function(error, data) {
                    if (error) {
                        return;
                    }
                    let review = data.response.review;

                    $('[data-review-id="' + review.kBewertung + '"]').removeClass('on-list');
                    item.addClass('on-list');
                    $('[data-review-count-id="hilfreich_' + review.kBewertung + '"]').html(review.nHilfreich);
                    $('[data-review-count-id="nichthilfreich_' + review.kBewertung + '"]').html(review.nNichtHilfreich);
                });
        },

        initReviewHelpful: function() {
            $('.js-helpful').on('click', function (e) {
                e.preventDefault();
                $.evo.extended().updateReviewHelpful($(this));
            });
        },

        initWishlist: function() {
            let wlFormID = '#wl-items-form';
            if ($(wlFormID).length) {
                $.evo.extended().addInactivityCheck(wlFormID, 300, true);
                $('.js-update-wl').on('change', function () {
                    $.evo.extended().updateWishlistItem($(this).closest('.productbox-inner'));
                });
                $(window).on('resize', function () {
                    setWishlistItemheights();
                });
                setWishlistItemheights();
            }
            function setWishlistItemheights() {
                $('.product-list').children().each(function() {
                    $(this).css('height', window.innerWidth > globals.breakpoints.xl ? $(this).height() : 'unset');
                });
            }
        },

        initPaginationEvents: function() {
            $('.pagination-wrapper select').on('change', function () {
                this.form.submit();
            });
        },

        initItemSearch: function(context) {
            let searchWrapper  = '.' + context + '-search-wrapper',
                searchInput    = '.' + context + '-search',
                itemValue      = '.' + context + '-item-value',
                item           = '.' + context + '-item',
                clear          = '.form-clear',
                inputSelected  = 'input-group-selected',
                $searchWrapper = $(searchWrapper);

            if ($searchWrapper.length === 0) {
                return;
            }
            $searchWrapper.each((i, itemWrapper) => {
                $(itemWrapper).find(searchInput).on('input', function () {
                    filterSearch($(itemWrapper));
                }).on('keydown', e => {
                    if (e.key === 'Escape') {
                        e.stopPropagation();
                    }
                });
            });
            $(searchWrapper + ' ' + clear).on('click', function() {
                $(this).prev().val('');
                $(this).addClass('d-none');
                filterSearch($(this).closest(searchWrapper));
            });
            $(searchInput).on('focusin', function() {
                $(this).closest(searchWrapper).addClass(inputSelected);
            }).on('focusout', function() {
                $(this).closest(searchWrapper).removeClass(inputSelected);
            });

            function filterSearch (itemWrapper) {
                let searchTerm = itemWrapper.find(searchInput).val().toLowerCase();
                itemWrapper.find(itemValue).each((i, itemTMP) => {
                    itemTMP = $(itemTMP);
                    let text = itemTMP.text().toLowerCase();
                    if (text.indexOf(searchTerm) === -1) {
                        itemTMP.closest(item).hide();
                    } else {
                        itemTMP.closest(item).show();
                    }
                    if (searchTerm.length === 0) {
                        itemWrapper.find(clear).addClass('d-none');
                    } else {
                        itemWrapper.find(clear).removeClass('d-none');
                    }
                });
            }
        },

        /**
         * $.evo.extended() is deprecated, please use $.evo instead
         */
        extended: function() {
            return $.evo;
        },

        register: function() {
            this.productTabsPriceFlow();
            this.generateSlickSlider();
            setTimeout(() => {
                $('.nav-tabs').tabdrop();
            }, 200);
            this.tooltips();
            this.popupDep();
            this.popover();
            this.addCartBtnAnimation();
            this.checkout();
            if ($('body').data('page') == 3) {
                this.addInactivityCheck('#cart-form');
            }
            this.fixStickyElements();
            this.setWishlistVisibilitySwitches();
            this.initEModals();
            $.evo.article().initConfigListeners();
            this.initScrollEvents();
            this.initReviewHelpful();
            this.initWishlist();
            this.initPaginationEvents();
            this.initFilterEvents();
            this.initItemSearch('filter');
        }
    };

    $(document).ready(function () {
        $.evo.register();
    });

    // PLUGIN DEFINITION
    // =================
    $.evo = new EvoClass();
})(jQuery);

function g_recaptcha_callback() {
    $.evo.renderCaptcha();
}
