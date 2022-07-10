{block name='checkout-inc-order-items'}
    {input type="submit" name="fake" class="d-none"}
    {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
        {$itemInfoCols=5}
        {$cols=9}
    {elseif $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'N'}
        {$itemInfoCols=6}
        {$cols=12}
    {/if}
    {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen !== 'Y'}
        {$itemInfoCols=$itemInfoCols+2}
    {/if}

    {block name='checkout-inc-order-items-order-items'}
        {block name='checkout-inc-order-items-order-items-header'}
            {row class="checkout-items-header text-accent d-none d-lg-flex"}
                {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                    {col cols=2}{/col}
                {/if}
                {col cols=$itemInfoCols}{lang key='product'}{/col}
                {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                    {col cols=2}{lang key="pricePerUnit" section="productDetails"}{/col}
                {/if}
                {col cols=1 class="text-center-util"}{lang key="quantity" section="checkout"}{/col}
                {col cols=2 class="text-right-util"}{lang key="price"}{/col}
            {/row}
            <hr class="checkout-items-header-hr d-none d-lg-flex">
        {/block}
        {block name='checkout-inc-order-items-order-items-main'}
        {foreach $smarty.session.Warenkorb->PositionenArr as $oPosition}
            {if !$oPosition->istKonfigKind()}
                {row class="type-{$oPosition->nPosTyp} checkout-items-item"}
                    {block name='checkout-inc-order-items-image'}
                        {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                            {col cols=3 lg=2 class="checkout-items-item-image-wrapper"}
                                {if !empty($oPosition->Artikel->cVorschaubild)}
                                    {link href=$oPosition->Artikel->cURLFull title=$oPosition->cName|trans|escape:'html'}
                                        {include file='snippets/image.tpl' item=$oPosition->Artikel square=false srcSize='sm'}
                                    {/link}
                                {/if}
                            {/col}
                        {/if}
                    {/block}
                    {block name='checkout-inc-order-items-items-main-content'}
                        {col cols=$cols lg=$itemInfoCols class="checkout-items-item-main"}
                            {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL || $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK}
                                {block name='checkout-inc-order-items-product-data-link'}
                                    <p>{link href=$oPosition->Artikel->cURLFull title=$oPosition->cName|trans|escape:'html'}{$oPosition->cName|trans}{/link}</p>
                                {/block}
                                {block name='checkout-inc-order-items-product-data'}
                                    <ul class="list-unstyled text-muted-util small">
                                        {block name='checkout-inc-order-items-product-data-sku'}
                                            <li class="sku"><strong>{lang key='productNo'}:</strong> {$oPosition->Artikel->cArtNr}</li>
                                        {/block}
                                        {if isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
                                            {block name='checkout-inc-order-items-product-data-mhd'}
                                                <li title="{lang key='productMHDTool'}" class="best-before">
                                                    <strong>{lang key='productMHD'}:</strong> {$oPosition->Artikel->dMHD_de}
                                                </li>
                                            {/block}
                                        {/if}
                                        {if $oPosition->Artikel->cLocalizedVPE
                                            && $oPosition->Artikel->cVPE !== 'N'
                                            && $oPosition->nPosTyp != $C_WARENKORBPOS_TYP_GRATISGESCHENK
                                        }
                                            {block name='checkout-inc-order-items-product-data-base-price'}
                                                <li class="baseprice"><strong>{lang key='basePrice'}:</strong> {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}</li>
                                            {/block}
                                        {/if}
                                        {if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
                                            {foreach $oPosition->WarenkorbPosEigenschaftArr as $Variation}
                                                {block name='checkout-inc-order-items-product-data-variation'}
                                                    <li class="variation">
                                                        <strong>{$Variation->cEigenschaftName|trans}:</strong> {$Variation->cEigenschaftWertName|trans}
                                                    </li>
                                                {/block}
                                            {/foreach}
                                        {/if}
                                        {if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
                                            {block name='checkout-inc-order-items-product-data-delivery-status'}
                                                <li class="delivery-status"><strong>{lang key='deliveryStatus'}:</strong> {$oPosition->cLieferstatus|trans}</li>
                                            {/block}
                                        {/if}
                                        {if !empty($oPosition->cHinweis)}
                                            {block name='checkout-inc-order-items-product-data-note'}
                                                <li class="text-info notice">{$oPosition->cHinweis}</li>
                                            {/block}
                                        {/if}

                                        {* Buttonloesung eindeutige Merkmale *}
                                        {if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
                                            {block name='checkout-inc-order-items-product-data-manufacturer'}
                                                 <li class="manufacturer">
                                                    <strong>{lang key='manufacturer' section='productDetails'}</strong>:
                                                    <span class="values">
                                                       {$oPosition->Artikel->cHersteller}
                                                    </span>
                                                 </li>
                                            {/block}
                                        {/if}

                                        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
                                            {foreach $oPosition->Artikel->oMerkmale_arr as $oMerkmale_arr}
                                                {block name='checkout-inc-order-items-product-data-attribute'}
                                                    <li class="characteristic">
                                                        <strong>{$oMerkmale_arr->cName}</strong>:
                                                        <span class="values">
                                                            {foreach $oMerkmale_arr->oMerkmalWert_arr as $oWert}
                                                                {if !$oWert@first}, {/if}
                                                                {$oWert->cWert}
                                                            {/foreach}
                                                        </span>
                                                    </li>
                                                {/block}
                                            {/foreach}
                                        {/if}

                                        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
                                            {foreach $oPosition->Artikel->Attribute as $oAttribute_arr}
                                                {block name='checkout-inc-order-items-product-data-attribute-attribute'}
                                                    <li class="attribute">
                                                        <strong>{$oAttribute_arr->cName}</strong>:
                                                        <span class="values">
                                                            {$oAttribute_arr->cWert}
                                                        </span>
                                                    </li>
                                                {/block}
                                            {/foreach}
                                        {/if}

                                        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
                                            {block name='checkout-inc-order-items-product-data-short-desc'}
                                                <li class="shortdescription">{$oPosition->Artikel->cKurzBeschreibung}</li>
                                            {/block}
                                        {/if}

                                        {if isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0}
                                            {block name='checkout-inc-order-items-product-data-weight'}
                                                <li class="weight">
                                                    <strong>{lang key='shippingWeight'}: </strong>
                                                    <span class="value">{$oPosition->Artikel->cGewicht} {lang key='weightUnit'}</span>
                                                </li>
                                            {/block}
                                        {/if}
                                    </ul>
                                {/block}
                            {else}
                                {block name='checkout-inc-order-items-is-not-product'}
                                    {$oPosition->cName|trans}{if isset($oPosition->discountForArticle)}{$oPosition->discountForArticle|trans}{/if}
                                    {if isset($oPosition->cArticleNameAffix)}
                                        {if is_array($oPosition->cArticleNameAffix)}
                                            <ul class="small text-muted-util">
                                                {foreach $oPosition->cArticleNameAffix as $cArticleNameAffix}
                                                    <li>{$cArticleNameAffix|trans}</li>
                                                {/foreach}
                                            </ul>
                                        {else}
                                            <ul class="small text-muted-util">
                                                <li>{$oPosition->cArticleNameAffix|trans}</li>
                                            </ul>
                                        {/if}
                                    {/if}
                                    {if !empty($oPosition->cHinweis)}
                                        <small class="text-info notice">{$oPosition->cHinweis}</small>
                                    {/if}
                                {/block}
                            {/if}

                            {if $oPosition->istKonfigVater()}
                                {block name='checkout-inc-order-items-product-cofig-items'}
                                    <ul class="config-items text-muted-util small">
                                        {$labeled=false}
                                        {foreach $smarty.session.Warenkorb->PositionenArr as $KonfigPos}
                                            {block name='product-config-item'}
                                                {if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
                                                    && !$KonfigPos->isIgnoreMultiplier()}
                                                    <li>
                                                        <span class="qty">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
                                                        {$KonfigPos->cName|trans} &raquo;
                                                        <span class="price_value">
                                                            {$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                                            {lang key='pricePerUnit' section='checkout'}
                                                        </span>
                                                    </li>
                                                {elseif $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
                                                    && $KonfigPos->isIgnoreMultiplier()}
                                                    {if !$labeled}
                                                        <strong>{lang key='one-off' section='checkout'}</strong>
                                                        {$labeled=true}
                                                    {/if}
                                                    <li>
                                                        <span class="qty">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
                                                        {$KonfigPos->cName|trans} &raquo;
                                                        <span class="price_value">
                                                            {$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                                            {lang key='pricePerUnit' section='checkout'}
                                                        </span>
                                                    </li>
                                                {/if}
                                            {/block}
                                        {/foreach}
                                    </ul>
                                {/block}
                            {/if}
                            {if !empty($oPosition->Artikel->kStueckliste) && !empty($oPosition->Artikel->oStueckliste_arr)}
                                {block name='checkout-inc-order-items-product-partlist-items'}
                                    <ul class="partlist-items text-muted-util small">
                                        {foreach $oPosition->Artikel->oStueckliste_arr as $partListItem}
                                            <li>
                                                <span class="qty">{$partListItem->fAnzahl_stueckliste}x</span>
                                                {$partListItem->cName|trans}
                                            </li>
                                        {/foreach}
                                    </ul>
                                {/block}
                            {/if}
                        {/col}

                        {block name='checkout-inc-order-items-price-single'}
                            {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                                {col cols=$cols lg=2 class="checkout-items-item-price-single text-nowrap-util"}
                                    {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                                        {if (!$oPosition->istKonfigVater() || !isset($oPosition->oKonfig_arr) || $oPosition->oKonfig_arr|count === 0)}
                                            <span class="checkout-items-item-title">{lang key="pricePerUnit" section="productDetails"}:</span>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                        {/if}
                                    {/if}
                                {/col}
                            {/if}
                        {/block}
                        {block name='checkout-inc-order-items-quantity'}
                            {col cols=$cols lg=1 class="checkout-items-item-quantity text-nowrap-util"}
                                <span class="checkout-items-item-title">{lang key="quantity" section="checkout"}:</span> {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
                            {/col}
                        {/block}
                    {/block}

                    {block name='checkout-inc-order-items-order-items-price-net'}
                        {col cols=$cols lg=2 class="price-col text-nowrap-util text-accent text-lg-right"}
                            <strong class="price_overall">
                                {if $oPosition->istKonfigVater()}
                                    {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {else}
                                    {$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {/if}
                            </strong>
                        {/col}
                    {/block}
                    {block name='checkout-inc-order-items-items-bottom-hr'}
                        {col cols=12}<hr>{/col}
                    {/block}
                {/row}
            {/if}
        {/foreach}
        {/block}
    {/block}
    {block name='checkout-inc-order-items-order-items-total'}
        {row class="checkout-items-total-wrapper"}
            {col xl=5 md=6 class='checkout-items-total'}
                {block name='checkout-inc-order-items-price-tax'}
                    {if $NettoPreise}
                        {block name='checkout-inc-order-items-price-net'}
                            {row class="total-net"}
                                {col }
                                    <span class="price_label"><strong>{lang key='totalSum'} ({lang key='net'}):</strong></span>
                                {/col}
                                {col class="col-auto price-col"}
                                    <strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong>
                                {/col}
                            {/row}
                        {/block}
                    {/if}

                    {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
                        {block name='checkout-inc-order-items-tax'}
                            {foreach $Steuerpositionen as $Steuerposition}
                                {row class="tax"}
                                    {col}
                                        <span class="tax_label">{$Steuerposition->cName}:</span>
                                    {/col}
                                    {col class="col-auto price-col"}
                                        <span class="tax_label">{$Steuerposition->cPreisLocalized}</span>
                                    {/col}
                                {/row}
                            {/foreach}
                        {/block}
                    {/if}

                    {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
                        {block name='checkout-inc-order-items-credit'}
                             {row class="customer-credit"}
                                 {col}
                                    {lang key='useCredit' section='account data'}
                                 {/col}
                                 {col class="col-auto"}
                                     {$smarty.session.Bestellung->GutscheinLocalized}
                                 {/col}
                             {/row}
                        {/block}
                    {/if}
                    {block name='checkout-inc-order-items-price-sticky'}
                        <hr>
                        {row class="checkout-items-total-total"}
                            {col}
                                <span class="price_label"><strong>{lang key='totalSum'}:</strong></span>
                            {/col}
                            {col class="col-auto price-col"}
                                <strong class="price total-sum">{$WarensummeLocalized[0]}</strong>
                            {/col}
                        {/row}
                    {/block}
                {/block}
                {block name='checkout-inc-order-items-shipping'}
                    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                        {if isset($FavourableShipping)}
                            {if $NettoPreise}
                                {$shippingCosts = "`$FavourableShipping->cPriceLocalized[$NettoPreise]` {lang key='plus' section='basket'} {lang key='vat' section='productDetails'}"}
                            {else}
                                {$shippingCosts = $FavourableShipping->cPriceLocalized[$NettoPreise]}
                            {/if}
                            {row class="shipping-costs text-right-util"}
                               {col cols=12}
                                    <small>{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL():$shippingCosts:$FavourableShipping->country->getName() key='shippingInformationSpecific' section='basket'}</small>
                                {/col}
                            {/row}
                        {elseif empty($FavourableShipping) && empty($smarty.session.Versandart)}
                            {row class="shipping-costs text-right-util"}
                                {col cols=12}
                                    <small>{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() key='shippingInformation' section='basket'}</small>
                                {/col}
                            {/row}
                        {/if}
                    {/if}
                {/block}
                {if !empty($smarty.session.Warenkorb->OrderAttributes)}
                    {block name='checkout-inc-order-items-finance'}
                        {foreach $smarty.session.Warenkorb->OrderAttributes as $attribute}
                            {if $attribute->cName === 'Finanzierungskosten'}
                                <hr>
                                {row class="checkout-items-total-finance-item type-{$smarty.const.C_WARENKORBPOS_TYP_ZINSAUFSCHLAG}"}
                                    {block name='checkout-inc-order-items-finance-costs'}
                                        {col}
                                            {lang key='financeCosts' section='order'}
                                        {/col}
                                    {/block}
                                    {block name='checkout-inc-order-items-finance-costs-value'}
                                        {col class="col-auto price-col"}
                                            <strong class="price_overall">
                                                {$attribute->cValue}
                                            </strong>
                                        {/col}
                                    {/block}
                                {/row}
                            {/if}
                        {/foreach}
                    {/block}
                {/if}
            {/col}
        {/row}
    {/block}
{/block}
