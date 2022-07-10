{block name='boxes-box-filter-manufacturer'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE
        && !($isMobile || $Einstellungen.template.productlist.filter_placement === 'modal')}
        <div id="sidebox{$oBox->getID()}" class="box box-filter-manufacturer d-none d-lg-block">
            {button
                variant="link"
                class="btn-filter-box dropdown-toggle"
                block=true
                role="button"
                data=["toggle"=> "collapse", "target"=>"#cllps-box{$oBox->getID()}"]
            }
                <span class="text-truncate">
                    {lang key='manufacturers'}
                </span>
            {/button}
            {collapse id="cllps-box{$oBox->getID()}"
                visible=$oBox->getItems()->isActive() || $Einstellungen.template.productlist.filter_items_always_visible === 'Y'}
                {block name='boxes-box-filter-manufacturer-include-manufacturer'}
                    {include file='snippets/filter/manufacturer.tpl' filter=$oBox->getItems()}
                {/block}
            {/collapse}
            {block name='boxes-box-filter-manufacturer-hr'}
                <hr class="box-filter-hr">
            {/block}
        </div>
    {/if}
{/block}
