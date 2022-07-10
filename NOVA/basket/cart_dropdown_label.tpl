{block name='basket-cart-dropdown-label'}
    <li class="cart-icon-dropdown nav-item dropdown {if $WarenkorbArtikelPositionenanzahl != 0}not-empty{/if}">
        {block name='basket-cart-dropdown-label-link'}
            {link class='nav-link' aria=['expanded' => 'false', 'label' => {lang key='basket'}] data=['toggle' => 'dropdown']}
                {block name='basket-cart-dropdown-label-count'}
                    <i class='fas fa-shopping-cart cart-icon-dropdown-icon'>
                        {if $WarenkorbArtikelPositionenanzahl >= 1}
                        <span class="fa-sup" title="{$WarenkorbArtikelPositionenanzahl}">
                            {$WarenkorbArtikelPositionenanzahl}
                        </span>
                        {/if}
                    </i>
                {/block}
                {block name='basket-cart-dropdown-labelprice'}
                    <span class="cart-icon-dropdown-price">{$WarensummeLocalized[0]}</span>
                {/block}
            {/link}
        {/block}
        {block name='basket-cart-dropdown-label-include-cart-dropdown'}
            {include file='basket/cart_dropdown.tpl'}
        {/block}
    </li>
{/block}
