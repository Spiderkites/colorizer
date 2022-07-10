{block name='productdetails-stock'}
    {assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
    <div class="delivery-status">
    {block name='productdetails-stock-stock-info'}
        <ul class="list-unstyled">
            {if !isset($shippingTime)}
                {block name='productdetails-stock-shipping-time'}
                    <li>
                        {block name='productdetails-stock-availability'}
                            {if $Artikel->inWarenkorbLegbar === $smarty.const.INWKNICHTLEGBAR_UNVERKAEUFLICH}
                                <span class="status"><small>{lang key='productUnsaleable' section='productDetails'}</small></span>
                            {elseif !$Artikel->nErscheinendesProdukt}
                                {block name='productdetails-stock-include-stock-status'}
                                    {include file='snippets/stock_status.tpl' currentProduct=$Artikel}
                                {/block}
                            {else}
                                {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && $Artikel->fLagerbestand > 0}
                                    <span class="status status-{$Artikel->Lageranzeige->nStatus}">{$Artikel->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                {elseif $anzeige === 'ampel' && $Artikel->fLagerbestand > 0}
                                    <span class="status status-{$Artikel->Lageranzeige->nStatus}">{$Artikel->Lageranzeige->AmpelText}</span>
                                {/if}
                            {/if}
                        {/block}
                        {* rich snippet availability *}
                        {block name='productdetails-stock-rich-availability'}
                            {if $Artikel->cLagerBeachten === 'N' || $Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y'}
                                <link itemprop="availability" href="https://schema.org/InStock" />
                            {elseif $Artikel->nErscheinendesProdukt && $Artikel->Erscheinungsdatum_de !== '00.00.0000' && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}
                                <link itemprop="availability" href="https://schema.org/PreOrder" />
                            {elseif $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull === 'N' && $Artikel->fLagerbestand <= 0}
                                <link itemprop="availability" href="https://schema.org/OutOfStock" />
                            {/if}
                        {/block}
                        {if isset($Artikel->cLieferstatus) && ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'Y' ||
                        ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'L' && $Artikel->fLagerbestand == 0 && $Artikel->cLagerBeachten === 'Y') ||
                        ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'A' && ($Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y' || $Artikel->cLagerBeachten !== 'Y')))}
                            {block name='productdetails-stock-delivery-status'}
                                <div class="delivery-status">{lang key='deliveryStatus'}: {$Artikel->cLieferstatus}</div>
                            {/block}
                        {/if}
                    </li>
                {/block}
            {/if}
            {if !isset($availability)}
            {block name='productdetails-stock-estimated-delivery'}
                {if $Artikel->cEstimatedDelivery}
                    <li>
                        <div class="estimated-delivery"
                            {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                                data-toggle="popover"
                                data-placement="top"
                                data-content="{if $Firma->country !== null}{lang|sprintf:$Firma->country->getName():$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL():$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() key='shippingInformation' section='productDetails'}{/if}"
                            {/if}>
                            {if !isset($shippingTime)}{lang key='shippingTime'}:{/if}
                            <span class="a{$Artikel->Lageranzeige->nStatus}">
                                {$Artikel->cEstimatedDelivery}
                                <span class="estimated-delivery-info">({lang key='shippingInfoIcon' section='productDetails'})</span>
                            </span>
                        </div>
                    </li>
                {/if}
            {/block}
            {/if}
        </ul>
    {/block}
    </div>
{/block}
