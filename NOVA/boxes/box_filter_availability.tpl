{block name='boxes-box-filter-availability'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE
    && !($isMobile || $Einstellungen.template.productlist.filter_placement === 'modal')}
        <div id="sidebox{$oBox->getID()}" class="box box-filter-availability d-none d-lg-block">
            {button
                variant="link"
                class="btn-filter-box dropdown-toggle"
                block=true
                role="button"
                data=["toggle"=> "collapse", "target"=>"#cllps-box{$oBox->getID()}"]
            }
                <span class="text-truncate">
                    {lang key='filterAvailability'}
                </span>
            {/button}
            {collapse id="cllps-box{$oBox->getID()}"
                visible=($oBox->getItems()->isActive() || $Einstellungen.template.productlist.filter_items_always_visible === 'Y')}
                {block name='boxes-box-filter-availability-content'}
                    {include file='snippets/filter/genericFilterItem.tpl' filter=$oBox->getItems()}
                {/block}
            {/collapse}
            {block name='boxes-box-filter-availability-hr'}
                <hr class="box-filter-hr">
            {/block}
        </div>
    {/if}
{/block}
