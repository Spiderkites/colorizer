{block name='boxes-box-filter-search'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE
        && !($isMobile || $Einstellungen.template.productlist.filter_placement === 'modal')}
        <div id="sidebox{$oBox->getID()}" class="box box-search-category d-none d-lg-block">
            {button
                variant="link"
                class="btn-filter-box dropdown-toggle"
                block=true
                role="button"
                data=["toggle"=> "collapse", "target"=>"#cllps-box{$oBox->getID()}"]
            }
                <span class="text-truncate">
                    {lang key='searchFilter'}
                </span>
            {/button}
            {collapse id="cllps-box{$oBox->getID()}"
                visible=$NaviFilter->searchFilterCompat->isActive() || $Einstellungen.template.productlist.filter_items_always_visible === 'Y'}
                {block name='boxes-box-filter-search-content'}
                    {include file='snippets/filter/search.tpl'}
                {/block}
            {/collapse}
            {block name='boxes-box-filter-search-hr'}
                <hr class="box-filter-hr">
            {/block}
        </div>
    {/if}
{/block}
