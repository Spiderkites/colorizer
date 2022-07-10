
import { debounce, random } from './../helpers.js'

const NAME					= 'navscrollbar'
const VERSION				= '1.0.0'
const UNIQID				= random()
const DATA_KEY				= `jtl.${NAME}`
const EVENT_KEY				= `.${DATA_KEY}#${UNIQID}`
const JQUERY_NO_CONFLICT	= $.fn[NAME]

const Default = {
    classes: {
        scrollbarInner		: 'nav-scrollbar-inner',
        scrollbarItems		: 'nav-scrollbar-item',
        scrollbarArrow		: 'nav-scrollbar-arrow'
    },
    templates: {
        arrowLeft: `
			<div class="left">
				<span class="fas fa-chevron-left"></span>
			</div>
		`,
        arrowRight: `
			<div class="right">
				<span class="fas fa-chevron-right"></span>
			</div>
		`
    },
    showArrowOffset: 0,
    clickTransitionDuration: 500,
    clickScrollLength: 70, // percentage
    enableDrag: false,
}

const Event = {
    CLICK			: `click${EVENT_KEY}`,
    MOUSEDOWN		: `mousedown${EVENT_KEY}`,
    MOUSEMOVE		: `mousemove${EVENT_KEY}`,
    MOUSEUP			: `mouseup${EVENT_KEY}`,
    RESIZE			: `resize${EVENT_KEY}`,
    SCROLL			: `scroll${EVENT_KEY}`
}

let $document	= $(document)
let $window		= $(window)


export default class NavScrollbar {
    constructor(element, config = {}) {
        let self     = this;
        this.element = $(element)
        this.config  = $.extend(true, {}, Default, config)

        this._isDragging   = false
        this._start        = 0
        this._startClientX = 0
        this._distance     = 0
        this._itemWidth    = 0

        this.$scrollBarInner = this.element.find(`.${this.config.classes.scrollbarInner}`)
        this.$scrollBarItems = this.element.find(`.${this.config.classes.scrollbarItems}`)

        this.$scrollBarArrowLeft	= $(this.config.templates.arrowLeft).addClass(`${this.config.classes.scrollbarArrow} disabled`)
        this.$scrollBarArrowRight	= $(this.config.templates.arrowRight).addClass(`${this.config.classes.scrollbarArrow} disabled`)

        this.element.prepend(this.$scrollBarArrowLeft)
        this.element.append(this.$scrollBarArrowRight)

        setTimeout(function () {
            self.update();
            self._bindEvents();
        }, 100);
    }

    /* Public */

    scrollToPrev() {
        this.$scrollBarInner.animate({
            scrollLeft: this.$scrollBarInner.scrollLeft() - (this.$scrollBarInner.width() / 100 * this.config.clickScrollLength - this.$scrollBarArrowLeft.width())
        }, { duration: this.config.clickTransitionDuration })
    }

    scrollToNext() {
        this.$scrollBarInner.animate({
            scrollLeft: this.$scrollBarInner.scrollLeft() + (this.$scrollBarInner.width() / 100 * this.config.clickScrollLength - this.$scrollBarArrowLeft.width())
        }, { duration: this.config.clickTransitionDuration })
    }

    update() {
        this._updateItemWidth()

        let widthDifference = Math.round(this._itemWidth - this.$scrollBarInner.width())
        let scrolledFromLeft = this.$scrollBarInner.scrollLeft()

        if(widthDifference <= 0) {
            this.$scrollBarArrowLeft.addClass('disabled')
            this.$scrollBarArrowRight.addClass('disabled')
            return
        }

        this.$scrollBarArrowLeft[scrolledFromLeft > this.config.showArrowOffset ? 'removeClass' : 'addClass']('disabled')
        this.$scrollBarArrowRight[scrolledFromLeft + this.config.showArrowOffset < (widthDifference - 8) ? 'removeClass' : 'addClass']('disabled')
    }

    destroy() {
        this.element.removeData(DATA_KEY)
        this.element = null
        this.$scrollBarInner.off(EVENT_KEY)
        this.$scrollBarArrowLeft.off(EVENT_KEY).remove()
        this.$scrollBarArrowRight.off(EVENT_KEY).remove()
        $document.off(EVENT_KEY)
        $window.off(EVENT_KEY)
    }

    /* Private */

    _dragStart(e) {
        e.preventDefault()

        this._startClientX = e.clientX

        this._isDragging = true
        this._start = e.clientX + this.$scrollBarInner.scrollLeft()
    }

    _dragMove(e) {
        if(!this._isDragging)
            return

        this.$scrollBarInner.scrollLeft(this._start - e.clientX)
    }

    _dragEnd(e) {
        if(!this._isDragging)
            return

        this._isDragging = false

        if($.contains(this.element.get(0), e.target)) {
            e.target.removeEventListener('click', this._preventDragClick)

            if(this._startClientX - e.clientX != 0)
                e.target.addEventListener('click', this._preventDragClick)
        }

        this.$scrollBarInner.scrollLeft(this._start - e.clientX)
    }

    _preventDragClick(e) {
        e.preventDefault()
        e.stopImmediatePropagation()
    }

    _updateItemWidth() {
        this._itemWidth = 0

        $.each(this.$scrollBarItems, (i, element) => {
            this._itemWidth += Math.round(element.offsetWidth)
        })
    }

    _bindEvents() {
        this.$scrollBarInner.on(Event.SCROLL, debounce(() => this.update()))

        this.$scrollBarArrowLeft.on(Event.CLICK, () => this.scrollToPrev())
        this.$scrollBarArrowRight.on(Event.CLICK, () => this.scrollToNext())

        if(this.config.enableDrag) {
            this.$scrollBarInner.on(Event.MOUSEDOWN, (e) => this._dragStart(e))
            $document.on(Event.MOUSEMOVE, (e) => this._dragMove(e))
            $document.on(Event.MOUSEUP, (e) => this._dragEnd(e))
        }

        $window.on(Event.RESIZE, debounce(() => this.update()))
    }

    /* Static */

    static _jQueryInterface(config = {}) {
        let _arguments = arguments || null

        return this.each(function() {
            const $element	= $(this)
            let data		= $element.data(DATA_KEY)

            if(!data) {
                if(typeof config === 'object') {
                    data = new NavScrollbar(this, config)
                    $element.data(DATA_KEY, data)
                } else {
                    $.error(`cannot call methods on ${NAME} prior to initialization`)
                }
            } else {
                if(typeof data[config] === 'function') {
                    data[config].apply(data, Array.prototype.slice.call(_arguments, 1))
                } else {
                    $.error(`method ${config} does not exist.`)
                }
            }
        })
    }
}

/**
 * ------------------------------------------------------------------------
 * jQuery
 * ------------------------------------------------------------------------
 */

$.fn[NAME]             = NavScrollbar._jQueryInterface
$.fn[NAME].Constructor = NavScrollbar
$.fn[NAME].noConflict  = () => {
    $.fn[NAME] = JQUERY_NO_CONFLICT
    return NavScrollbar._jQueryInterface
}
