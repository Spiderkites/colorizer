{block name='snippets-filter-genericFilterItem'}
    {block name='snippets-filter-genericFilterItem-nav'}
        {$limit = $Einstellungen.template.productlist.filter_max_options}
        {$collapseInit = false}
            {foreach $filter->getOptions() as $filterOption}
                {if $limit != -1 && $filterOption@iteration > $limit && !$collapseInit}
                    {block name='snippets-filter-genericFilterItem-more-top'}
                        <div class="collapse {if $filter->isActive()} show{/if}" id="box-collps-filter{$filter->getNiceName()}" aria-expanded="false" role="button">
                            {$collapseInit = true}
                    {/block}
                {/if}
                {assign var=filterIsActive value=$filterOption->isActive() || $NaviFilter->getFilterValue($filter->getClassName()) === $filterOption->getValue()}
                {block name='snippets-filter-genericFilterItem-nav-main'}
                    {link class="filter-item {if $filterIsActive === true}active{/if}"
                        href="{if $filterOption->isActive()}{$filter->getUnsetFilterURL($filterOption->getValue())}{else}{$filterOption->getURL()}{/if}"
                        rel="nofollow"}
                        <div class="box-link-wrapper">
                            {if $filter->getIcon() !== null}
                                <i class="fa {$filter->getIcon()} snippets-filter-item-icon-right"></i>
                            {else}
                                <i class="far fa-{if $filterIsActive === true}check-{/if}square snippets-filter-item-icon-right"></i>
                            {/if}
                            {if $filter->getNiceName() === 'Rating'}
                                {block name='snippets-filter-genericFilterItem-include-rating-nav'}
                                    <span class="snippets-filter-item-icon-right">{include file='productdetails/rating.tpl' stars=$filterOption->getValue()}</span>
                                {/block}
                            {/if}
                            <span class="word-break">{$filterOption->getName()}</span>
                            {badge variant="outline-secondary"}{$filterOption->getCount()}{/badge}
                        </div>
                    {/link}
                {/block}
            {/foreach}
            {if $limit != -1 && $filter->getOptions()|count > $limit}
                {block name='snippets-filter-genericFilterItem-more-bottom'}
                    </div>
                    <div class="snippets-filter-show-all">
                        {button variant="link"
                            role="button"
                            data=["toggle"=> "collapse", "target"=>"#box-collps-filter{$filter->getNiceName()}"]}
                            {lang key='showAll'}
                        {/button}
                    </div>
                {/block}
            {/if}
    {/block}
{/block}
