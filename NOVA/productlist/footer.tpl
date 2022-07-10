{block name='productlist-footer'}
    {assign var=Suchergebnisse value=$NaviFilter->getSearchResults(false)}
    {block name='productlist-footer-include-productlist-page-nav'}
        {include file='snippets/productlist_page_nav.tpl' navid='footer' hrTop=true}
    {/block}
{/block}
