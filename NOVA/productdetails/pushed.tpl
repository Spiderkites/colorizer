{block name='productdetails-pushed'}
    {if $nSeitenTyp !== $smarty.const.PAGE_ARTIKEL}
        {include
            file='productdetails/pushed_success.tpl'
            Artikel=$zuletztInWarenkorbGelegterArtikel
            card=false
        }
    {/if}
{/block}
