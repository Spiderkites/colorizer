{block name='productdetails-index'}
    {block name='productdetails-index-include-header'}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/header.tpl'}
        {/if}
    {/block}
    {block name='productdetails-index-content'}
        {if isset($bAjaxRequest) && $bAjaxRequest && isset($listStyle) && ($listStyle === 'list' || $listStyle === 'gallery')}
            {if $listStyle === 'list'}
                {assign var=tplscope value='list'}
                {block name='productdetails-index-include-item-list'}
                    {include file='productlist/item_list.tpl'}
                {/block}
            {elseif $listStyle === 'gallery'}
                {assign var=tplscope value='gallery'}
                {assign var=class value='thumbnail'}
                {block name='productdetails-index-include'}
                    {include file='productlist/item_box.tpl'}
                {/block}
            {/if}
        {else}
            {block name='productdetails-index-result-wrapper'}
                <div id="result-wrapper" data-wrapper="true" itemprop="mainEntity" itemscope itemtype="https://schema.org/Product">
                    <meta itemprop="url" content="{$Artikel->cURLFull}">
                    {block name='productdetails-index-include-extension'}
                        {include file='snippets/extension.tpl'}
                    {/block}
                    {block name='productdetails-index-include-details'}
                        {include file='productdetails/details.tpl'}
                    {/block}
                </div>
            {/block}
        {/if}
    {/block}

    {block name='productdetails-include-footer'}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/footer.tpl'}
        {/if}
    {/block}
{/block}
