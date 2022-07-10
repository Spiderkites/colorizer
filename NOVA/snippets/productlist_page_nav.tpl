{block name='snippets-productlist-page-nav'}
    {if $Suchergebnisse->getProductCount() > 0}
        {opcMountPoint id='opc_before_page_nav_'|cat:$navid}

        {if $hrTop|default:false === true}
            {block name='snippets-productlist-page-nav-hr-top'}
                <hr class="productlist-page-nav-top">
            {/block}
        {/if}
        {row no-gutters=true class="{if $navid === 'header'}productlist-page-nav-header-m{/if} productlist-page-nav"}
            {if count($NaviFilter->getSearchResults()->getProducts()) > 0  && $navid === 'header'}
                {block name='snippets-productlist-page-nav-result-options-sort'}
                    {col cols=12 xl="auto" class="displayoptions"}
                        {block name='snippets-productlist-page-nav-include-result-options'}
                            {if count($Suchergebnisse->getProducts()) > 0}
                                {opcMountPoint id='opc_before_result_options'}
                            {/if}
                            {$filterPlacement=''}
                            {if $isMobile && !$isTablet}
                                {$filterPlacement="collapse"}
                            {elseif $isTablet || $Einstellungen.template.productlist.filter_placement === 'modal'}
                                {$filterPlacement="modal"}
                            {/if}
                            <div id="improve_search" class="result-option-wrapper {if $filterPlacement !== 'collapse'}d-inline-block btn-group{/if} {if $filterPlacement === ''}d-lg-none{/if}">
                                {include file='productlist/result_options.tpl'
                                    itemCount=$Suchergebnisse->getProductCount()
                                    filterPlacement=$filterPlacement}
                            </div>
                        {/block}
                        {if !$isMobile || $isTablet}
                            {block name='snippets-productlist-page-nav-actions'}
                                {block name='snippets-productlist-page-nav-actions-sort'}
                                    {if count($Suchergebnisse->getSortingOptions()) > 0}
                                    {dropdown class="filter-type-FilterItemSort btn-group" variant="outline-secondary" text="{lang key='sorting' section='productOverview'}"}
                                        {foreach $Suchergebnisse->getSortingOptions() as $option}
                                            {dropdownitem rel="nofollow" href=$option->getURL() class="page-nav-filter-item" active=$option->isActive()}
                                                {$option->getName()}
                                            {/dropdownitem}
                                        {/foreach}
                                    {/dropdown}
                                    {/if}
                                {/block}
                                {block name='snippets-productlist-page-nav-actions-items'}
                                    {if count($Suchergebnisse->getLimitOptions()) > 0}
                                    {dropdown class="filter-type-FilterItemLimits btn-group" variant="outline-secondary" text="{lang key='productsPerPage' section='productOverview'}"}
                                        {foreach $Suchergebnisse->getLimitOptions() as $option}
                                            {dropdownitem rel="nofollow" href=$option->getURL() class="page-nav-filter-item" active=$option->isActive()}
                                                {$option->getName()}
                                            {/dropdownitem}
                                        {/foreach}
                                    {/dropdown}
                                    {/if}
                                {/block}
                                {if !$isMobile}
                                    {block name='snippets-productlist-page-nav-include-layout-options'}
                                        {include file='productlist/layout_options.tpl'}
                                    {/block}
                                {/if}
                            {/block}
                        {/if}
                    {/col}
                {/block}
            {/if}
            {block name='snippets-productlist-page-nav-current-page-count'}
                {col cols="auto" class="productlist-item-info {if $Suchergebnisse->getPages()->getMaxPage() > 1}productlist-item-border{/if}"}
                    {lang key="products"} {$Suchergebnisse->getOffsetStart()} - {$Suchergebnisse->getOffsetEnd()} {lang key='of' section='productOverview'} {$Suchergebnisse->getProductCount()}
                {/col}
            {/block}
            {if $Suchergebnisse->getPages()->getMaxPage() > 1 && !($isMobile && $navid === 'header')}
                {block name='snippets-productlist-page-nav-page-nav'}
                    {col cols=12 md="auto" class="productlist-pagination"}
                        <nav class="navbar-pagination" aria-label="Productlist Navigation">
                            <ul class="pagination">
                                {block name='snippets-productlist-page-nav-first-page'}
                                    <li class="page-item{if $Suchergebnisse->getPages()->getCurrentPage() == 1} disabled{/if}">
                                        {link class="page-link js-pagination-ajax" href=$filterPagination->getPrev()->getURL() aria=['label' => {lang key='previous' section='productOverview'}]}<i class="fas fa-long-arrow-alt-left"></i>{/link}
                                    </li>
                                {/block}
                                <li class="page-item dropdown">
                                    {block name='snippets-productlist-page-nav-button'}
                                        <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span class="pagination-site">{lang key='page'}</span> {$Suchergebnisse->getPages()->getCurrentPage()}
                                        </button>
                                    {/block}
                                    <div class="dropdown-menu shadow-none">
                                        {block name='snippets-productlist-page-nav-pages'}
                                            {foreach $filterPagination->getPages() as $page}
                                                <div class="dropdown-item page-item{if $page->isActive()} active{/if}">
                                                    {link class="page-link js-pagination-ajax" href=$page->getURL()}<span class="pagination-site">{lang key='page'}</span> {$page->getPageNumber()}{/link}
                                                </div>
                                            {/foreach}
                                        {/block}
                                    </div>
                                </li>
                                {block name='snippets-productlist-page-nav-last-page'}
                                    <li class="page-item{if $Suchergebnisse->getPages()->getCurrentPage() == $Suchergebnisse->getPages()->getMaxPage()} disabled{/if}">
                                        {link class="page-link js-pagination-ajax" href=$filterPagination->getNext()->getURL() aria=['label' => {lang key='next' section='productOverview'}]}<i class="fas fa-long-arrow-alt-right"></i>{/link}
                                    </li>
                                {/block}
                            </ul>
                        </nav>
                    {/col}
                {/block}
            {/if}
        {/row}
        {block name='snippets-productlist-page-nav-hr-bottom'}
            <hr class="productlist-page-nav-bottom">
        {/block}
    {/if}
{/block}
