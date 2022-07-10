{block name='snippets-filter-search'}
    {$limit = $Einstellungen.template.productlist.filter_max_options}
    {$collapseInit = false}
    {foreach $NaviFilter->searchFilterCompat->getOptions() as $searchFilter}
        {if $limit != -1 && $searchFilter@iteration > $limit && !$collapseInit}
            {block name='snippets-filter-search-more-top'}
                <div class="collapse {if $NaviFilter->searchFilterCompat->isActive()} show{/if}" id="box-collps-filter{$NaviFilter->searchFilterCompat->getNiceName()}" aria-expanded="false" role="button">
                    <ul class="nav flex-column">
                {$collapseInit = true}
            {/block}
        {/if}
        {block name='snippets-filter-search-navitem'}
            {link rel="nofollow"
                href=$searchFilter->getURL()
                class="filter-item {if $searchFilter->isActive()}active{/if}"}
                    <div class="box-link-wrapper">
                        <i class="far fa-{if $searchFilter->isActive()}check-{/if}square snippets-filter-item-icon-right"></i>
                        <span class="word-break">{$searchFilter->getName()}</span>
                        {badge variant="outline-secondary"}{$searchFilter->getCount()}{/badge}
                    </div>
            {/link}
        {/block}
    {/foreach}
    {if $limit != -1 && $NaviFilter->searchFilterCompat->getOptions()|count > $limit}
        {block name='snippets-filter-search-more-bottom'}
                </ul>
            </div>
            <div class="snippets-filter-show-all">
                {button variant="link"
                    role="button"
                    data=["toggle"=> "collapse", "target"=>"#box-collps-filter{$NaviFilter->searchFilterCompat->getNiceName()}"]}
                    {lang key='showAll'}
                {/button}
            </div>
        {/block}
    {/if}
{/block}
