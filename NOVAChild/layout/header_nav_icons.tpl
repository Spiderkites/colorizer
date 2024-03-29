{block name='layout-header-nav-icons'}
    {block name='layout-header-nav-icons-include-header-nav-search'}
        {include file='layout/header_nav_search.tpl'}
    {/block}
    {block name='layout-header-nav-icons-include-header-shop-nav-account'}
        {include file='layout/header_shop_nav_account.tpl'}
    {/block}
    {if !($isMobile)}
        {block name='layout-header-nav-icons-include-header-shop-nav-compare'}
            {include file='layout/header_shop_nav_compare.tpl'}
        {/block}
        {block name='layout-header-nav-icons-include-header-shop-nav-wish'}
            {include file='layout/header_shop_nav_wish.tpl'}
        {/block}
    {/if}
    {block name='layout-header-nav-icons-include-cart-dropdown-label'}
        {include file='basket/cart_dropdown_label.tpl'}
    {/block}
    {block name='layout-header-top-bar-user-settings-include-language-dropdown'}
        {include file='snippets/language_dropdown.tpl'}
    {/block}
{/block}
