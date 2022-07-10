{block name='layout-header-shop-nav-wish'}
    {if !empty($wishlists) && $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
        {$wlCount = 0}
        {if isset($smarty.session.Wunschliste->CWunschlistePos_arr)}
            {$wlCount = $smarty.session.Wunschliste->CWunschlistePos_arr|count}
        {/if}
        <li id='shop-nav-wish'
            class="nav-item dropdown {if $nSeitenTyp === $smarty.const.PAGE_WUNSCHLISTE} active{/if}">
            {block name='layout-header-shop-nav-wish-link'}
                {link class='nav-link' aria=['expanded' => 'false', 'label' => {lang key='wishlist'}] data=['toggle' => 'dropdown']}
                    <i class="fas fa-heart">
                        <span id="badge-wl-count" class="fa-sup {if $wlCount === 0} d-none{/if}" title="{$wlCount}">
                            {$wlCount}
                        </span>
                    </i>
                {/link}
            {/block}
            {block name='layout-header-shop-nav-wish-dropdown'}
                <div id="nav-wishlist-collapse" class="dropdown-menu dropdown-menu-right lg-min-w-lg">
                    <div id="wishlist-dropdown-container">
                        {block name='layout-header-shop-nav-wish-include-wishlist-dropdown'}
                            {include file='snippets/wishlist_dropdown.tpl'}
                        {/block}
                    </div>
                </div>
            {/block}
        </li>
    {/if}
{/block}
