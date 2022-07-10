{block name='productdetails-config'}
    {if isset($Artikel->oKonfig_arr) && $Artikel->oKonfig_arr|@count > 0}
        {row class="product-configuration"}
            {block name='productdetails-config-include-config-container'}
                {include file='productdetails/config_container.tpl'}
            {/block}
            {block name='productdetails-config-include-config-sidebar'}
                {include file='productdetails/config_sidebar.tpl'}
            {/block}
        {/row}
    {/if}
{/block}
