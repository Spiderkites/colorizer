{block name='page-shipping'}
    {if isset($Einstellungen.global.global_versandermittlung_anzeigen)
        && $Einstellungen.global.global_versandermittlung_anzeigen === 'Y'}
        {opcMountPoint id='opc_before_shipping' inContainer=false}
        {if !isset($smarty.get.shipping_calculator)
            || (isset($smarty.get.shipping_calculator) && $smarty.get.shipping_calculator !== "0")}
            {container fluid=$Link->getIsFluid() class="page-shipping {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                {if isset($smarty.session.Warenkorb->PositionenArr) && $smarty.session.Warenkorb->PositionenArr|@count > 0}
                    {block name='page-shipping-form'}
                        {form method="post"
                            action="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}{else}{get_static_route id='index.php'}{/if}{if $bExclusive}?exclusive_content=1{/if}"
                            class="jtl-validate shipping-calculator-form"
                            id="shipping-calculator-form"
                            slide=true}
                            {input type="hidden" name="s" value=$Link->getID()}
                            {block name='page-shipping-include-shipping-calculator'}
                                {include file='snippets/shipping_calculator.tpl' checkout=false}
                            {/block}
                        {/form}
                    {/block}
                {else}
                    {block name='page-shipping-note'}
                        {lang key='estimateShippingCostsNote' section='global'}
                    {/block}
                {/if}
            {/container}
        {/if}
        {opcMountPoint id='opc_after_shipping' inContainer=false}
    {/if}
{/block}
