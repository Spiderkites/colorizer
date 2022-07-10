{block name='snippets-shipping-tax-info'}
    {block name='snippets-shipping-tax-info-content'}
        {block name='snippets-shipping-tax-info-tax-data'}
            {strip}
            {if !empty($taxdata.text)}
                {$taxdata.text}
            {else}
                {if $Einstellungen.global.global_ust_auszeichnung === 'auto'}
                    {if $taxdata.net}
                        {lang key='excl' section='productDetails'}
                    {else}
                        {lang key='incl' section='productDetails'}
                    {/if}
                    &nbsp;{$taxdata.tax}% {lang key='vat' section='productDetails'}
                {elseif $Einstellungen.global.global_ust_auszeichnung === 'autoNoVat'}
                    {if $taxdata.net}
                        {lang key='excl' section='productDetails'}
                    {else}
                        {lang key='incl' section='productDetails'}
                    {/if}
                    &nbsp;{lang key='vat' section='productDetails'}
                {elseif $Einstellungen.global.global_ust_auszeichnung === 'endpreis'}
                    {lang key='finalprice' section='productDetails'}
                {/if}
            {/if}
            {/strip}
        {/block}
        {if $Einstellungen.global.global_versandhinweis === 'zzgl'}
            {block name='snippets-shipping-tax-info-zzgl'}
                {block name='snippets-shipping-tax-info-zzgl-comma'}
                ,
                {/block}
                {if $Einstellungen.global.global_versandfrei_anzeigen === 'Y' && $taxdata.shippingFreeCountries}
                    {block name='snippets-shipping-tax-info-zzgl-show-shipping-free'}
                        {if $Einstellungen.global.global_versandkostenfrei_darstellung === 'D'}
                            {block name='snippets-shipping-tax-info-zzgl-show-shipping-free-D'}
                                {$countries = "{foreach $taxdata.countries as $cISO => $country}<abbr title='{$country}'>{$cISO}</abbr>{if !$country@last}&nbsp;{/if}{/foreach}"}
                                {lang key='noShippingcostsTo'} {lang key='noShippingCostsAtExtended' section='basket' printf=$countries}
                                {link href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}?shipping_calculator=0{/if}" rel="nofollow" class="shipment popup"}
                                    {lang key='shipping' section='basket'}{/link}
                            {/block}
                        {elseif isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                            {block name='snippets-shipping-tax-info-zzgl-show-shipping-free-free-link'}
                                {link href="{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}?shipping_calculator=0"
                                    rel="nofollow"
                                    class="shipment popup"
                                    data-toggle="tooltip"
                                    data-placement="left"
                                    title="{$taxdata.shippingFreeCountries}, {lang key='else'} {lang key='plus' section='basket'} {lang key='shipping' section='basket'}"
                                }
                                    {lang key='noShippingcostsTo'}
                                {/link}
                            {/block}
                        {/if}
                    {/block}
                {elseif isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                    {block name='snippets-shipping-tax-info-zzgl-special-page'}
                        {lang key='plus' section='basket'}
                        {link href="{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}?shipping_calculator=0"
                            rel="nofollow"
                            class="shipment popup"}
                            {lang key='shipping' section='basket'}
                        {/link}
                    {/block}
                {/if}
            {/block}
        {elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
            {block name='snippets-shipping-tax-info-inkl'}
                , {lang key='incl' section='productDetails'} {link href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}{/if}" rel="nofollow" class="shipment"}{lang key='shipping' section='basket'}{/link}
            {/block}
        {/if}
    {/block}

    {block name='snippets-shipping-tax-info-shipping-class'}
        {if !empty($taxdata.shippingClass) && $taxdata.shippingClass !== 'standard' && $Einstellungen.global.global_versandklasse_anzeigen === 'Y'}
            ({$taxdata.shippingClass})
        {/if}
    {/block}
{/block}
