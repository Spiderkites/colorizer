
import './globals.js'

export let isMobile = () => window.innerWidth < globals.breakpoints.lg
export let isDesktop = () => !isMobile()
export let hasTouch = () => 'ontouchstart' in window

export const debounce = (fn, wait = 100) => {
    let timeout
    return (...args) => {
        clearTimeout(timeout)
        timeout = setTimeout(() => fn(...args), wait)
    }
}

export const throttle = (fn, wait = 100) => {
    let timeout
    return (...args) => {
        if(timeout)
            return

        fn(...args)
        timeout = true
        setTimeout(() => timeout = false, wait)
    }
}

export const guid = () => {
    const hex = (s, b) => {
        return s + (b >>> 4   ).toString (16) + (b & 0b1111).toString (16)
    }

    let r = crypto.getRandomValues (new Uint8Array (16))

    r[6] = r[6] >>> 4 | 0b01000000
    r[8] = r[8] >>> 3 | 0b10000000

    return	r.slice ( 0,  4).reduce (hex, '' ) +
        r.slice ( 4,  6).reduce (hex, '-') +
        r.slice ( 6,  8).reduce (hex, '-') +
        r.slice ( 8, 10).reduce (hex, '-') +
        r.slice (10, 16).reduce (hex, '-')
}

export const random = () => {
    return Math.floor((1 + Math.random()) * 0x1000).toString(16).substring(1) + Math.floor((1 + Math.random()) * 0x1000).toString(16).substring(1)
}

export const onMobile = (fn) => {
    return (...args) => {
        if(isMobile()) fn(...args)
    }
}

export const onDesktop = (fn) => {
    return (...args) => {
        if(!isMobile()) fn(...args)
    }
}

export const hasScrollbar = (element = 'html') => {
    let directions = []
    let $element = $(element)

    if($element.get(0).scrollHeight > $element.get(0).clientHeight)
        directions.push('v')

    if($element.get(0).scrollWidth > $element.get(0).clientWidth)
        directions.push('h')

    return directions.length > 0 ? directions : false
}

export const isScrollbarVisible = (element = 'html') => {
    let directions = []
    let $element = $(element)
    let scrollbars = hasScrollbar(element)

    if(scrollbars === false)
        return false

    if($.inArray('v', scrollbars) >= 0) {
        if($element.get(0) === document.documentElement) {
            if(window.innerWidth > document.documentElement.clientWidth)
                directions.push('v')
        } else {
            if($element.get(0).offsetWidth > $element.get(0).clientWidth)
                directions.push('v')
        }
    }

    if($.inArray('h', scrollbars) >= 0) {
        if($element.get(0) === document.documentElement) {
            if(window.innerHeight > document.documentElement.clientHeight)
                directions.push('h')
        } else {
            if($element.get(0).offsetHeight > $element.get(0).clientHeight)
                directions.push('h')
        }
    }

    return directions.length > 0 ? directions : false
}

export const lockScreen = () => {
    $('html').addClass('overflow-hidden')
}

export const unlockScreen = () => {
    $('html').removeClass('overflow-hidden')
}

export const backdrop = (animate = true) => {
    let $backdrop = $('<div />').addClass('modal-backdrop')

    if(animate)
        $backdrop.addClass('fade')

    return $backdrop
}
