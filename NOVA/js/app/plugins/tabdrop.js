const Tabdrop = function(element, options) {
	let _this = this;

	this.element = element;
	this.options = options;
	this.tabdrop = $('<li class="nav-item tab-drop d-none">' +
						'<a class="nav-link' + ((this.options.showCaret) ? ' dropdown-toggle' : '') + '" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"></a>' +
						'<div class="dropdown-menu dropdown-menu-right"></div>' +
					'</li>').appendTo(this.element);
	this.collection = [];

	this.layout = function() {
		$.each(this.tabdrop.find('.dropdown-item'), function() {
			_this._swapClasses(this).insertBefore(_this.tabdrop);
		});

		this._checkOffsetAndPush();
	};

	this._checkOffsetAndPush = function(recursion) {
		recursion = recursion || false;

		$(this.element).find('.nav-item:not(.tab-drop), .dropdown-item').each(function() {
			if(this.offsetTop > _this.options.offsetTop) {
				_this.collection.push(_this._swapClasses(this));
			}
		});

		if(this.collection.length > 0) {
			if(!recursion) {
				this.tabdrop.removeClass('d-none');
				this.tabdrop.parent().css('padding-right', this.tabdrop.width());
				this.tabdrop.find('.dropdown-menu').empty();
			}

			this.tabdrop.find('.dropdown-menu').prepend(this.collection);

			if(this.tabdrop.find('.dropdown-menu .active').length == 1) {
				this.tabdrop.find('> .nav-link').addClass('active');
			} else {
				this.tabdrop.find('> .nav-link').removeClass('active');
			}

			this.collection = [];

			this._checkOffsetAndPush(true);
		} else {
			if (!recursion) {
				this.tabdrop.addClass('d-none');
				this.tabdrop.parent().css('padding-right', 0);
			}
		}
	};

	this._swapClasses = function(element) {
		let item;

		if($(element).hasClass('nav-item')) {
			item = $(element).find('.nav-link').removeClass('nav-link').addClass('dropdown-item');
			$(element).detach();
		} else {
			item = $(element).removeClass('dropdown-item').addClass('nav-link');
			item = $('<li />').addClass('nav-item').append(item);
		}

		return item;
	};

	$(window).on('resize', $.proxy(this.layout, this));
	$(this.element).on('shown.bs.tab', $.proxy(this.layout, this));

	this.layout();
};

$.fn.tabdrop = function(option) {
	return this.each(function() {
		let data = $(this).data('tabdrop'),
			options = typeof option === 'object' && option;

		if(!data) {
			options = $.extend({}, $.fn.tabdrop.defaults, options);
			$(this).data('tabdrop', new Tabdrop(this, options));
		}

		if(typeof option == 'string')
			data[option]();
	})
};

$.fn.tabdrop.defaults = {
	offsetTop : 0,
	icon : '',
	showCaret : true
};

$.fn.tabdrop.Constructor = Tabdrop;
