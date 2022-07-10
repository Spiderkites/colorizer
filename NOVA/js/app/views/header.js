
/* imports */

import {
    debounce, isMobile, onMobile, onDesktop, hasTouch,
    isDesktop, lockScreen, unlockScreen, backdrop
} from './../helpers.js'

import './../plugins/navscrollbar.js'

/* vars */

const header					= '#jtl-nav-wrapper'
const search					= '#search'
const mainNavigation			= '#mainNavigation'
const navRightDropdowns			= `${header} .nav-right .dropdown`
const navbarNav					= `${mainNavigation} .navbar-nav`
const mobileBackLink			= '[data-menu-back]'

const $document					= $(document)
const $window					= $(window)
const $backdropDropdowns		= backdrop()
const $backdropMobileNav		= backdrop()
const $header					= $(header)
const $mainNavigation			= $(mainNavigation)
const $navRightDropdowns		= $(navRightDropdowns)
const $navbarNav				= $(navbarNav)
const $consentManager           = $('#consent-manager')

const delayDropdownFadeIn		= 400
const delayDropdownFadeOut		= 200

let mobileCurrentLevel			= 0
let dropdownInTo				= null
let dropdownOutTo				= null
let $activeDropdown				= null
let activeDropdowns				= []
let isDropdownActive			= false
let isMenuActive				= false

/* functions */

const hasNavScrollbar = () => $mainNavigation.data('jtl.navscrollbar') !== undefined

const onInitOrResize = () => {
    updateVH()

    if(isMobile()) {
        $backdropDropdowns.removeClass('zindex-dropdown').detach()

        if(hasNavScrollbar())
            $mainNavigation.navscrollbar('destroy')
    } else {
        $mainNavigation.collapse('hide')
        resetMobileNavigation()

        if(!hasNavScrollbar())
            $mainNavigation.navscrollbar()
    }
}

const showDropdown = (dropdown) => {
    $activeDropdown = $(dropdown)
    $activeDropdown.parent().addClass('show')
    $activeDropdown.next().addClass('show')
    $activeDropdown.attr('aria-expanded', true)
    isMenuActive = true

    activeDropdowns.push($activeDropdown)
}

const hideDropdown = () => {
    if($activeDropdown === null)
        return

    $activeDropdown.parent().removeClass('show')
    $activeDropdown.next().removeClass('show')
    $activeDropdown.attr('aria-expanded', false)

    activeDropdowns.splice(-1, 1)

    if(activeDropdowns.length === 0) {
        $activeDropdown = null
        isMenuActive = false
    } else {
        $activeDropdown = activeDropdowns[activeDropdowns.length - 1]
    }
}

const showMobileLevel = (level) => {
    mobileCurrentLevel = level < 0 ? 0 : mobileCurrentLevel
    $navbarNav.css('transform', `translateX(${mobileCurrentLevel * -100}%)`)
    $(`${mainNavigation} .nav-mobile-body`).scrollTop(0)
    updateMenuTitle()
}

const updateMenuTitle = () => {
    if(mobileCurrentLevel === 0) {
        $('span.nav-offcanvas-title').removeClass('d-none')
        $('a.nav-offcanvas-title').addClass('d-none')
    } else {
        $('span.nav-offcanvas-title').addClass('d-none')
        $('a.nav-offcanvas-title').removeClass('d-none')
    }
}

const resetMobileNavigation = () => {
    mobileCurrentLevel = 0
    updateMenuTitle()
    $(`${mainNavigation} .show`).removeClass('show')
    $(`${mainNavigation} .dropdown-toggle`).attr('aria-expanded', false)
    $navbarNav.removeAttr('style')
}

const updateVH = () => {
    let vh = window.innerHeight * .01
    document.documentElement.style.setProperty('--vh', `${vh}px`)
}

onInitOrResize()
updateVH()

/* global events */

$window.on('resize', debounce(onInitOrResize))
$document.on('focus blur', search, () => setTimeout(() => { if(hasNavScrollbar()) $mainNavigation.navscrollbar('update') }, 250))

$document.on('show.bs.dropdown', navRightDropdowns, (e) => {
    isDropdownActive = true
    $backdropDropdowns.insertBefore($header)
})

$document.on('shown.bs.dropdown', navRightDropdowns, () => {
    $backdropDropdowns.addClass('show zindex-dropdown')
})

$document.on('hide.bs.dropdown', navRightDropdowns, () => {
    isDropdownActive = false

    if(!isMenuActive)
        $backdropDropdowns.removeClass('show')
})

$document.on('hidden.bs.dropdown', navRightDropdowns, () => {
    if(!isMenuActive)
        $backdropDropdowns.removeClass('zindex-dropdown').detach()
})

/* mobile events */

$document.on('shown.bs.dropdown', `.search-mobile`, (e) => {
    $(e.currentTarget).find('input').focus()
})

$backdropMobileNav.on('click', onMobile(() => {
    $mainNavigation.collapse('hide')
}))

$document.on('show.bs.collapse', mainNavigation, () => {
    lockScreen()
    $backdropMobileNav.insertBefore($mainNavigation)
    $consentManager.addClass('d-none');
})

$document.on('shown.bs.collapse', mainNavigation, () => {
    $backdropMobileNav.addClass('show')
    $(`${mainNavigation} .nav-mobile-body`).scrollTop(0)
})

$document.on('hide.bs.collapse', mainNavigation, () => {
    $backdropMobileNav.removeClass('show')
    $consentManager.removeClass('d-none');
})

$document.on('hidden.bs.collapse', mainNavigation, () => {
    unlockScreen()
    $backdropMobileNav.detach()
})

$document.on('click', mobileBackLink, onMobile((e) => {
    e.preventDefault()

    showMobileLevel(--mobileCurrentLevel)
    hideDropdown()
}))

$document.on('click', `${mainNavigation} .dropdown-toggle`, onMobile((e) => {
    e.preventDefault()

    showDropdown(e.currentTarget)
    showMobileLevel(++mobileCurrentLevel)
}))

/* desktop events */

if(hasTouch()) {
    $document.on('click', `${mainNavigation} .dropdown-toggle:not(.categories-recursive-link)`, onDesktop((e) => {
        e.preventDefault()

        if($activeDropdown !== null && $activeDropdown.get(0) === e.currentTarget) {
            hideDropdown()
            $backdropDropdowns.removeClass('show').detach()
            return
        }

        if($activeDropdown !== null) {
            hideDropdown()
            $backdropDropdowns.removeClass('show').detach()
        }

        showDropdown(e.currentTarget)
        $backdropDropdowns.insertBefore($header).addClass('show zindex-dropdown')
    }))

    $backdropDropdowns.on('click', onDesktop(() => {
        if($activeDropdown !== null) {
            hideDropdown()
            $backdropDropdowns.removeClass('show').detach()
        }
    }))

    $document.on('show.bs.dropdown', navRightDropdowns, () => {
        if($activeDropdown !== null)
            hideDropdown()
    })
}

$document.on('mouseenter', `${mainNavigation} .navbar-nav > .dropdown`, onDesktop((e) => {
    if(hasTouch())
        return

    if(dropdownOutTo != undefined)
        clearTimeout(dropdownOutTo)

    dropdownInTo = setTimeout(() => {
        if($activeDropdown !== null) {
            hideDropdown()
        }
        showDropdown($(e.currentTarget).find('> .dropdown-toggle'))
        $backdropDropdowns.insertBefore($header).addClass('show zindex-dropdown')
    }, delayDropdownFadeIn)
})).on('mouseleave', `${mainNavigation} .navbar-nav > .dropdown`, onDesktop((e) => {
    if(hasTouch())
        return

    if(dropdownInTo != undefined)
        clearTimeout(dropdownInTo)

    dropdownOutTo = setTimeout(() => {
        hideDropdown()

        if(!isDropdownActive)
            $backdropDropdowns.removeClass('show').detach()
    }, delayDropdownFadeOut)
}))
