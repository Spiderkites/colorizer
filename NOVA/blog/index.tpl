{block name='blog-index'}
    {block name='blog-index-include-header'}
        {include file='layout/header.tpl'}
    {/block}

    {block name='blog-index-content'}
        {if JTL\Shop::$AktuelleSeite === 'NEWSDETAIL'}
            {block name='blog-index-include-details'}
                {include file='blog/details.tpl'}
            {/block}
        {else}
            {block name='blog-index-overview'}
                {include file='blog/overview.tpl'}
            {/block}
        {/if}
    {/block}

    {block name='blog-index-include-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
