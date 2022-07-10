{block name='productdetails-price'}
    {if $smarty.session.Kundengruppe->mayViewPrices()}
        <div class="price_wrapper">
            {block name='productdetails-price-wrapper'}
            {if $Artikel->getOption('nShowOnlyOnSEORequest', 0) === 1}
                {block name='productdetails-price-out-of-stock'}
                    <span class="price_label price_out_of_stock">{lang key='productOutOfStock' section='productDetails'}</span>
                {/block}
            {elseif $Artikel->Preise->fVKNetto == 0 && $Artikel->bHasKonfig}
                {block name='productdetails-price-as-configured'}
                    <span class="price_label price_as_configured">{lang key='priceAsConfigured' section='productDetails'}</span> <span class="price"></span>
                {/block}
            {elseif $Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                {block name='productdetails-price-on-application'}
                    <span class="price_label price_on_application">{lang key='priceOnApplication'}</span>
                {/block}
            {else}
                {block name='productdetails-price-label'}
                    {if ($tplscope !== 'detail' && $Artikel->Preise->oPriceRange->isRange() && $Artikel->Preise->oPriceRange->rangeWidth() > $Einstellungen.artikeluebersicht.articleoverview_pricerange_width)
                        || ($tplscope === 'detail' && ($Artikel->nVariationsAufpreisVorhanden == 1 || $Artikel->bHasKonfig) && $Artikel->kVaterArtikel == 0)}
                        <span class="price_label pricestarting">{lang key='priceStarting'} </span>
                    {elseif $Artikel->Preise->rabatt > 0}
                        <span class="price_label nowonly">{lang key='nowOnly'} </span>
                    {/if}
                {/block}
                <div class="price {if $priceLarge|default:false}h1{else}productbox-price{/if} {if isset($Artikel->Preise->Sonderpreis_aktiv) && $Artikel->Preise->Sonderpreis_aktiv} special-price{/if}">
                    {block name='productdetails-range'}
                        <span{if $Artikel->Preise->oPriceRange->isRange() && $tplscope !== 'box'} itemprop="priceSpecification" itemscope itemtype="https://schema.org/UnitPriceSpecification"{/if}>
                        {if $tplscope !== 'detail' && $Artikel->Preise->oPriceRange->isRange()}
                            {if $Artikel->Preise->oPriceRange->rangeWidth() <= $Einstellungen.artikeluebersicht.articleoverview_pricerange_width}
                                {assign var=rangePrices value=$Artikel->Preise->oPriceRange->getLocalizedArray($NettoPreise)}
                                <span class="first-range-price">{$rangePrices[0]} - </span><span class="second-range-price">{$rangePrices[1]} {if $tplscope !== 'detail'} <span class="footnote-reference">*</span>{/if}</span>
                            {else}
                                {$Artikel->Preise->oPriceRange->getMinLocalized($NettoPreise)} <span class="footnote-reference">*</span>
                            {/if}
                        {else}
                            {if $Artikel->Preise->oPriceRange->isRange() && ($Artikel->nVariationsAufpreisVorhanden == 1 || $Artikel->bHasKonfig) && $Artikel->kVaterArtikel == 0}{$Artikel->Preise->oPriceRange->getMinLocalized($NettoPreise)}{else}{$Artikel->Preise->cVKLocalized[$NettoPreise]}{/if}
                        {/if}
                        {if $tplscope !== 'detail' && !$Artikel->Preise->oPriceRange->isRange()} <span class="footnote-reference">*</span>{/if}
                        </span>
                    {/block}
                </div>
                {block name='productdetails-price-snippets'}
                    {if $tplscope !== 'box'}
                        {if $Artikel->Preise->oPriceRange->isRange()}
                            <meta itemprop="minPrice" content="{$Artikel->Preise->oPriceRange->minBruttoPrice}">
                            <meta itemprop="maxPrice" content="{$Artikel->Preise->oPriceRange->maxBruttoPrice}">
                        {/if}
                        <meta itemprop="price" content="{if $Artikel->Preise->oPriceRange->isRange()}{$Artikel->Preise->oPriceRange->minBruttoPrice}{else}{$Artikel->Preise->fVKBrutto}{/if}">
                        <meta itemprop="priceCurrency" content="{$smarty.session.Waehrung->getName()}">
                        {if $Artikel->Preise->Sonderpreis_aktiv && $Artikel->dSonderpreisStart_en !== null && $Artikel->dSonderpreisEnde_en !== null}
                            <meta itemprop="validFrom" content="{$Artikel->dSonderpreisStart_en}">
                            <meta itemprop="validThrough" content="{$Artikel->dSonderpreisEnde_en}">
                            <meta itemprop="priceValidUntil" content="{$Artikel->dSonderpreisEnde_en}">
                        {/if}
                    {/if}
                {/block}
                {if $tplscope === 'detail'}
                    {block name='productdetails-price-detail'}
                        <div class="price-note">
                            {if $Artikel->cEinheit && ($Artikel->fMindestbestellmenge > 1 || $Artikel->fAbnahmeintervall > 1)}
                                {block name='productdetails-price-label-per-unit'}
                                    <span class="price_label per_unit"> {lang key='vpePer'} 1 {$Artikel->cEinheit}</span>
                                {/block}
                            {/if}

                            {* Grundpreis *}
                            {if !empty($Artikel->cLocalizedVPE)}
                                {block name='productdetails-price-detail-base-price'}
                                    <div class="base-price text-nowrap-util" itemprop="priceSpecification" itemscope itemtype="https://schema.org/UnitPriceSpecification">
                                        <meta itemprop="price" content="{if $Artikel->Preise->oPriceRange->isRange()}{($Artikel->Preise->oPriceRange->minBruttoPrice/$Artikel->fVPEWert)|string_format:"%.2f"}{else}{($Artikel->Preise->fVKBrutto/$Artikel->fVPEWert)|string_format:"%.2f"}{/if}">
                                        <meta itemprop="priceCurrency" content="{$smarty.session.Waehrung->getName()}">
                                        <span class="value" itemprop="referenceQuantity" itemscope itemtype="https://schema.org/QuantitativeValue">
                                            {$Artikel->cLocalizedVPE[$NettoPreise]}
                                            <meta itemprop="value" content="{$Artikel->fGrundpreisMenge}">
                                            <meta itemprop="unitText" content="{$Artikel->cVPEEinheit|regex_replace:"/[\d ]/":""}">
                                        </span>
                                    </div>
                                {/block}
                            {/if}

                            {block name='productdetails-price-detail-vat-info'}
                                <span class="vat_info">
                                    {include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}
                                </span>
                            {/block}

                            {block name='productdetails-price-special-prices-detail'}
                                {if $Artikel->Preise->Sonderpreis_aktiv && $Einstellungen.artikeldetails.artikeldetails_sonderpreisanzeige == 2}
                                    <div class="text-danger text-stroke text-nowrap-util">
                                        {lang key='oldPrice'}: {$Artikel->Preise->alterVKLocalized[$NettoPreise]}
                                    </div>
                                {elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0}
                                    {if $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 3 || $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 4}
                                        <div class="text-danger text-stroke text-nowrap-util">
                                            {lang key='oldPrice'}: {$Artikel->Preise->alterVKLocalized[$NettoPreise]}
                                        </div>
                                    {/if}
                                    {if $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 2 || $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 4}
                                        <div class="discount">{lang key='discount'}:
                                            <span class="value text-nowrap-util">{$Artikel->Preise->rabatt}%</span>
                                        </div>
                                    {/if}
                                {/if}
                            {/block}

                        {if $Einstellungen.artikeldetails.artikeldetails_uvp_anzeigen === 'Y'
                            && $Artikel->fUVP > 0
                            && $Artikel->Preise->fVKBrutto < $Artikel->fUVP}
                                {block name='productdetails-price-uvp'}
                                    <div class="suggested-price">
                                        <span>{lang key='suggestedPrice' section='productDetails'}</span>:
                                        <span class="value text-nowrap-util">{$Artikel->cUVPLocalized}</span>
                                    </div>
                                    {* Preisersparnis zur UVP anzeigen? *}
                                    {if isset($Artikel->SieSparenX) && $Artikel->SieSparenX->anzeigen == 1 && $Artikel->SieSparenX->nProzent > 0 && !$NettoPreise && $Artikel->taxData['tax'] > 0}
                                        <div class="yousave">({lang key='youSave' section='productDetails'}
                                            <span class="percent">{$Artikel->SieSparenX->nProzent}%</span>, {lang key='thatIs' section='productDetails'}
                                            <span class="value text-nowrap-util">{$Artikel->SieSparenX->cLocalizedSparbetrag}</span>)
                                        </div>
                                    {/if}
                                {/block}
                            {/if}

                            {* --- Staffelpreise? --- *}
                            {if !empty($Artikel->staffelPreis_arr)}
                                {block name='productdetails-price-detail-bulk-price'}
                                    <div class="bulk-prices">
                                        <table class="table table-sm table-hover">
                                            <thead>
                                                {block name='productdetails-price-detail-bulk-price-head'}
                                                    <tr>
                                                        <th>
                                                            {lang key='fromDifferential' section='productOverview'}
                                                        </th>
                                                        <th>{lang key='pricePerUnit' section='productDetails'}{if $Artikel->cEinheit} / {$Artikel->cEinheit}{/if}
                                                            {if isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0 && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1) && isset($Artikel->cMassMenge)}
                                                                ({$Artikel->cMassMenge} {$Artikel->cMasseinheitName})
                                                            {/if}
                                                        </th>
                                                        {if !empty($Artikel->staffelPreis_arr[0].cBasePriceLocalized)}
                                                        <th>
                                                            {lang key='basePrice'}
                                                        </th>
                                                        {/if}
                                                    </tr>
                                                {/block}
                                            </thead>
                                            <tbody>
                                                {block name='productdetails-price-detail-bulk-price-body'}
                                                    {foreach $Artikel->staffelPreis_arr as $bulkPrice}
                                                        {if $bulkPrice.nAnzahl > 0}
                                                            <tr class="bulk-price-{$bulkPrice.nAnzahl}">
                                                                <td>{$bulkPrice.nAnzahl}</td>
                                                                <td>
                                                                    <span class="bulk-price">{$bulkPrice.cPreisLocalized[$NettoPreise]}</span><span class="footnote-reference">*</span>
                                                                </td>
                                                                {if !empty($bulkPrice.cBasePriceLocalized)}
                                                                    <td class="bulk-base-price">
                                                                        {$bulkPrice.cBasePriceLocalized[$NettoPreise]}
                                                                    </td>
                                                                {/if}
                                                            </tr>
                                                        {/if}
                                                    {/foreach}
                                                {/block}
                                            </tbody>
                                        </table>
                                    </div>{* /bulk-price *}
                                {/block}
                            {/if}
                        </div>{* /price-note *}
                    {/block}
                {else}{* scope productlist *}
                    {block name='productdetails-price-price-note'}
                    <div class="price-note">
                        {* Grundpreis *}
                        {if !empty($Artikel->cLocalizedVPE) && !$Artikel->Preise->oPriceRange->isRange()}
                            {block name='productdetails-price-list-base-price'}
                                <div class="base_price" itemprop="priceSpecification" itemscope itemtype="https://schema.org/UnitPriceSpecification">
                                    <meta itemprop="price" content="{($Artikel->Preise->fVKBrutto/$Artikel->fVPEWert)|string_format:"%.2f"}">
                                    <meta itemprop="priceCurrency" content="{$smarty.session.Waehrung->getName()}">
                                    <span class="value" itemprop="referenceQuantity" itemscope itemtype="https://schema.org/QuantitativeValue">
                                        {$Artikel->cLocalizedVPE[$NettoPreise]}
                                        <meta itemprop="value" content="{$Artikel->fGrundpreisMenge}">
                                        <meta itemprop="unitText" content="{$Artikel->cVPEEinheit|regex_replace:"/[\d ]/":""}">
                                    </span>
                                </div>
                            {/block}
                        {/if}
                        {block name='productdetails-price-special-prices'}
                            {if $Artikel->Preise->Sonderpreis_aktiv && isset($Einstellungen.artikeluebersicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_sonderpreisanzeige == 2}
                                <div class="instead-of old-price">
                                    <small class="text-muted-util">
                                        {lang key='oldPrice'}:
                                        <del class="value">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                                    </small>
                                </div>
                            {elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0 && isset($Einstellungen.artikeluebersicht)}
                                {if $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 3 || $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 4}
                                    <div class="old-price">
                                        <small class="text-muted-util">
                                            {lang key='oldPrice'}:
                                            <del class="value text-nowrap-util">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                                        </small>
                                    </div>
                                {/if}
                                {if $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 2 || isset($Einstellungen.artikeluebersicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 4}
                                    <div class="discount">
                                        <small class="text-muted-util">
                                            {lang key='discount'}:
                                            <span class="value text-nowrap-util">{$Artikel->Preise->rabatt}%</span>
                                        </small>
                                    </div>
                                {/if}
                            {/if}
                        {/block}
                    </div>
                    {/block}
                {/if}
            {/if}
            {/block}
        </div>
    {else}
        {block name='price-invisible'}
            <span class="price_label price_invisible">{lang key='priceHidden'}</span>
        {/block}
    {/if}
{/block}
