{block name='boxes-box-filter-search-special'}
    {assign var=ssf value=$NaviFilter->getSearchSpecialFilter()}
    {if $bBoxenFilterNach
        && $ssf->getVisibility() !== \JTL\Filter\Visibility::SHOW_NEVER
        && $ssf->getVisibility() !== \JTL\Filter\Visibility::SHOW_CONTENT
        && (!empty($Suchergebnisse->getSearchSpecialFilterOptions()) || $ssf->isInitialized())
        && !($isMobile || $Einstellungen.template.productlist.filter_placement === 'modal')}
        {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
            <div id="sidebox{$oBox->getID()}" class="box box-filter-special d-none d-lg-block">
                {button
                    variant="link"
                    class="btn-filter-box dropdown-toggle"
                    block=true
                    role="button"
                    data=["toggle"=> "collapse", "target"=>"#cllps-box{$oBox->getID()}"]
                }
                    <span class="text-truncate">
                        {$ssf->getFrontendName()}
                    </span>
                {/button}
                {collapse id="cllps-box{$oBox->getID()}"
                    visible=$ssf->isActive() || $Einstellungen.template.productlist.filter_items_always_visible === 'Y'}
                    {block name='boxes-box-filter-search-special-content'}
                        {include file='snippets/filter/genericFilterItem.tpl' filter=$ssf}
                    {/block}
                {/collapse}
                {block name='boxes-box-filter-search-special-hr'}
                    <hr class="box-filter-hr">
                {/block}
            </div>
        {/if}
    {/if}
{/block}
