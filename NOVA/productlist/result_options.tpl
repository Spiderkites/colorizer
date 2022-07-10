{block name='productlist-result-options'}
    {assign var=show_filters value=(count($NaviFilter->getAvailableContentFilters()) > 0
    && ($Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab == 0
        || $NaviFilter->getSearchResults()->getProductCount() >= $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab))
    || $NaviFilter->getFilterCount() > 0}
    <div id="result-options">
        {row}
        {block name='productlist-result-options-filter-link'}
            {col cols=12 md=4 class="filter-collapsible-control order-1 order-md-0 d-flex"}
                {if $show_filters}
                    {block name='productlist-result-options-filter-link-filter'}
                        {button id="js-filters" variant="outline-secondary"
                            class="text-nowrap-util"
                            data=["toggle" => "{if !empty($filterPlacement)}{$filterPlacement}{else}modal{/if}", "target" => "#collapseFilter"]
                            aria=["expanded" => "false",
                                "controls" => "collapseFilter"]
                            role="button"
                            block=$filterPlacement === 'collapse'}
                            <span class="fas fa-filter{if $NaviFilter->getFilterCount() > 0} text-primary{/if}"></span>
                            {if $filterPlacement === 'collapse'}{lang key='filterAndSort'}{else}{lang key='filter'}{/if}
                        {/button}
                    {/block}
                {/if}
                {if !empty($filterPlacement) && !$filterPlacement === "collapse"}
                    {block name='productlist-result-options-filter-include-layout-options'}
                        {include file='productlist/layout_options.tpl'}
                    {/block}
                {/if}
            {/col}
        {/block}
        {/row}

        {block name='productlist-result-options-filter-collapsible'}
            {if $show_filters}
                {if !empty($filterPlacement) && $filterPlacement === 'collapse'}
                    {collapse id="collapseFilter"
                        class="productlist-filter js-collapse-filter"
                        aria=["expanded" => "false"]}
                    {/collapse}
                {else}
                    <div class="modal" id="collapseFilter">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">{lang key='filterAndSort'}</h5>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body js-collapse-filter">
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
            {/if}
        {/block}
    </div>
{/block}
