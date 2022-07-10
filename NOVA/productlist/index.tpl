{block name='productlist-index'}
    {block name='productlist-index-include-header'}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/header.tpl'}
        {/if}
    {/block}

    {block name='productlist-index-content'}
        <div id="result-wrapper" data-wrapper="true">
            {block name='productlist-index-include-productlist-header'}
                {include file='productlist/header.tpl'}
            {/block}
            {*Prio: -> Funktionsattribut -> Benutzereingabe -> Standarddarstellung*}
            {block name='productlist-index-include-productlist-header-grid'}
                {if (!empty($AktuelleKategorie->categoryFunctionAttributes['darstellung'])
                    && $AktuelleKategorie->categoryFunctionAttributes['darstellung'] == 1)
                    || (empty($AktuelleKategorie->categoryFunctionAttributes['darstellung'])
                        && ((!empty($oErweiterteDarstellung->nDarstellung) && $oErweiterteDarstellung->nDarstellung == 1)
                            || (empty($oErweiterteDarstellung->nDarstellung)
                                && isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht)
                                && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht == 1))
                )}
                    {block name='productlist-index-include-productlist-header-grid-list'}
                        {assign var=style value='list'}
                        {assign var=grid value='6'}
                        {assign var=gridmd value='12'}
                    {/block}
                {else}
                    {block name='productlist-index-include-productlist-header-grid-gallery'}
                        {assign var=style value='gallery'}
                        {assign var=grid value='6'}
                        {assign var=gridsm value='6'}
                        {assign var=gridmd value='4'}
                        {assign var=gridxl value='3'}
                        {if !$bExclusive || empty($boxes.left)}
                            {assign var=gridmd value='4'}
                        {/if}
                    {/block}
                {/if}
            {/block}

            {block name='productlist-index-list-type'}
                <input type="hidden" id="product-list-type" value="{$style}">
            {/block}

            {if !empty($Suchergebnisse->getError())}
                {block name='productlist-index-alert'}
                    {alert variant="danger"}{$Suchergebnisse->getError()}{/alert}
                {/block}
            {/if}
            {if isset($oBestseller_arr) && $oBestseller_arr|@count > 0}
                {block name='productlist-index-include-product-slider'}
                    {opcMountPoint id='opc_before_bestseller'}
                    {lang key='bestseller' section='global' assign='slidertitle'}
                    {include file='snippets/product_slider.tpl' id='slider-top-products' productlist=$oBestseller_arr title=$slidertitle}
                {/block}
            {/if}

            {block name='productlist-index-products'}
                {if $Suchergebnisse->getProducts()|@count > 0}
                {opcMountPoint id='opc_before_products'}
                {row class="product-list layout-{$style}" id="product-list" itemprop="mainEntity" itemscope=true itemtype="https://schema.org/ItemList"}
                    {foreach $Suchergebnisse->getProducts() as $Artikel}
                        {col cols={$grid} md="{if isset($gridmd)}{$gridmd}{/if}"
                             sm="{if isset($gridsm)}{$gridsm}{/if}" xl="{if isset($gridxl)}{$gridxl}{/if}"
                             class="product-wrapper"
                             itemprop="itemListElement" itemscope=true itemtype="https://schema.org/Product"}
                            {if $style === 'list' && (!$isMobile || $isTablet)}
                                {block name='productlist-index-include-item-list'}
                                    {include file='productlist/item_list.tpl' tplscope=$style}
                                {/block}
                            {else}
                                {block name='productlist-index-include-item-box'}
                                    {include file='productlist/item_box.tpl' tplscope=$style}
                                {/block}
                            {/if}
                        {/col}
                    {/foreach}
                {/row}
                {/if}
            {/block}

            {block name='productlist-index-include-productlist-footer'}
                {include file='productlist/footer.tpl'}
            {/block}
        </div>
    {/block}

    {block name='productlist-index-include-footer'}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/footer.tpl'}
        {/if}
    {/block}
{/block}
