{block name='productlist-layout-options'}
    {if isset($oErweiterteDarstellung->nDarstellung)
    && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung === 'Y'
    && empty($AktuelleKategorie->categoryFunctionAttributes['darstellung'])
    && $navid === 'header'}
        {buttongroup}
            {block name='productlist-layout-options-quare'}
                {link href=$oErweiterteDarstellung->cURL_arr[$smarty.const.ERWDARSTELLUNG_ANSICHT_LISTE]
                    id="ed_list"
                    class="btn btn-outline-secondary btn-option ed list{if $oErweiterteDarstellung->nDarstellung === $smarty.const.ERWDARSTELLUNG_ANSICHT_LISTE} active{/if}"
                    role="button"
                    title="{lang key='list' section='productOverview'}"
                    aria=["label"=>{lang key='list' section='productOverview'}]
                }
                    <span class="fa fa-th-list d-none d-md-inline-flex"></span><span class="fa fa-square d-inline-flex d-md-none"></span>
                {/link}
            {/block}
            {block name='productlist-layout-options-list'}
                {link href=$oErweiterteDarstellung->cURL_arr[$smarty.const.ERWDARSTELLUNG_ANSICHT_GALERIE]
                    id="ed_gallery"
                    class="btn btn-outline-secondary btn-option ed gallery{if $oErweiterteDarstellung->nDarstellung === $smarty.const.ERWDARSTELLUNG_ANSICHT_GALERIE} active{/if}"
                    role="button"
                    title="{lang key='gallery' section='productOverview'}"
                    aria=["label"=>{lang key='gallery' section='productOverview'}]
                }
                    <span class="fa fa-th-large"></span>
                {/link}
            {/block}
        {/buttongroup}
    {/if}
{/block}
