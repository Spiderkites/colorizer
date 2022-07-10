{block name='basket-cart-items'}
    {input type="submit" name="fake" class="d-none"}
    {block name='basket-cart-items-cols'}
        {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
            {$itemInfoCols=3}
            {$cols=9}
        {else}
            {$itemInfoCols=5}
            {$cols=12}
        {/if}
        {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen !== 'Y'}
            {$itemInfoCols=$itemInfoCols+2}
        {/if}
    {/block}
    {block name='basket-cart-items-order-items'}
        {block name='basket-cart-items-order-items-header'}
            {row class="cart-items-header text-accent d-none d-xl-flex"}
                {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                    {col cols=2}{/col}
                {/if}
                {col cols=$itemInfoCols}
                    <span>{lang key='product'}</span>
                {/col}
                {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                    {col cols=2}
                        <span>{lang key="pricePerUnit" section="productDetails"}</span>
                    {/col}
                {/if}
                {col cols=3 class="text-center-util"}
                    <span>{lang key="quantity" section="checkout"}</span>
                {/col}
                {col cols=2 class="text-right-util"}
                    <span>{lang key="price"}</span>
                {/col}
                {col cols=12}
                    <hr>
                {/col}
            {/row}
        {/block}
        {block name='basket-cart-items-order-items-main'}
        {foreach $smarty.session.Warenkorb->PositionenArr as $oPosition}
            {if !$oPosition->istKonfigKind()}
                {$posName=$oPosition->cName|trans|escape:'html'}
                {row class="cart-items-body type-{$oPosition->nPosTyp}"}
                    {block name='basket-cart-items-image'}
                        {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                            {col cols=3 xl=2 class="cart-items-image"}
                                {if !empty($oPosition->Artikel->cVorschaubild)}
                                    {link href=$oPosition->Artikel->cURLFull title=$posName}
                                        {image lazy=true
                                            webp=true
                                            src=$oPosition->Artikel->cVorschaubild
                                            alt=$posName
                                            fluid-grow=true
                                        }
                                    {/link}
                                {/if}
                            {/col}
                        {/if}
                    {/block}
                    {block name='basket-cart-items-items-main-content'}
                        {col cols=$cols xl=$itemInfoCols class="ml-auto-util"}
                        {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL || $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK}
                            {block name='basket-cart-items-product-link'}
                                {link class="cart-items-name" href=$oPosition->Artikel->cURLFull title=$posName}{$oPosition->cName|trans}{/link}
                            {/block}
                            {block name='basket-cart-items-product-data'}
                                <ul class="list-unstyled">
                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
                                        {block name='basket-cart-items-product-data-short-desc'}
                                            <li class="shortdescription">{$oPosition->Artikel->cKurzBeschreibung}</li>
                                        {/block}
                                    {/if}
                                    {block name='basket-cart-items-product-data-sku'}
                                        <li class="sku"><strong>{lang key='productNo'}:</strong> {$oPosition->Artikel->cArtNr}</li>
                                    {/block}
                                    {if isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
                                        {block name='basket-cart-items-product-data-mhd'}
                                            <li title="{lang key='productMHDTool'}" class="best-before">
                                                <strong>{lang key='productMHD'}:</strong> {$oPosition->Artikel->dMHD_de}
                                            </li>
                                        {/block}
                                    {/if}
                                    {if $oPosition->Artikel->cLocalizedVPE
                                        && $oPosition->Artikel->cVPE !== 'N'
                                        && $oPosition->nPosTyp != $C_WARENKORBPOS_TYP_GRATISGESCHENK
                                    }
                                        {block name='basket-cart-items-product-data-base-price'}
                                            <li class="baseprice"><strong>{lang key='basePrice'}:</strong> {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}</li>
                                        {/block}
                                    {/if}
                                    {if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
                                        {foreach $oPosition->WarenkorbPosEigenschaftArr as $Variation}
                                            {block name='basket-cart-items-product-data-variations'}
                                                <li class="variation">
                                                    <strong>{$Variation->cEigenschaftName|trans}:</strong> {$Variation->cEigenschaftWertName|trans}
                                                </li>
                                            {/block}
                                        {/foreach}
                                    {/if}
                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
                                        {block name='basket-cart-items-product-data-delivery-status'}
                                            <li class="delivery-status"><strong>{lang key='deliveryStatus'}:</strong> {$oPosition->cLieferstatus|trans}</li>
                                        {/block}
                                    {/if}
                                    {if !empty($oPosition->cHinweis)}
                                        {block name='basket-cart-items-product-data-notice'}
                                            <li class="text-info notice">{$oPosition->cHinweis}</li>
                                        {/block}
                                    {/if}

                                    {* Buttonloesung eindeutige Merkmale *}
                                    {if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
                                        {block name='basket-cart-items-product-data-manufacturers'}
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
                                            {block name='basket-cart-items-product-data-attributes'}
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
                                            {block name='basket-cart-items-product-data-attributes-attributes'}
                                                <li class="attribute">
                                                    <strong>{$oAttribute_arr->cName}</strong>:
                                                    <span class="values">
                                                        {$oAttribute_arr->cWert}
                                                    </span>
                                                </li>
                                            {/block}
                                        {/foreach}
                                    {/if}

                                    {if isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0}
                                        {block name='basket-cart-items-product-data-weight'}
                                            <li class="weight">
                                                <strong>{lang key='shippingWeight'}: </strong>
                                                <span class="value">{$oPosition->Artikel->cGewicht} {lang key='weightUnit'}</span>
                                            </li>
                                        {/block}
                                    {/if}
                                </ul>
                            {/block}
                        {else}
                            {block name='basket-cart-items-is-not-product'}
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
                            {block name='basket-cart-items-product-cofig-items'}
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
                            {block name='basket-cart-items-product-partlist-items'}
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

                        {block name='basket-cart-items-price-single'}
                            {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                                {col cols=$cols xl=2 class="cart-items-single-price"}
                                {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL && (!$oPosition->istKonfigVater() || !isset($oPosition->oKonfig_arr) || $oPosition->oKonfig_arr|count === 0)}
                                    <strong class="cart-items-price-text">
                                        {lang key="pricePerUnit" section="productDetails"}:
                                    </strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {/if}
                                {/col}
                            {/if}
                        {/block}

                        {col cols=$cols xl=3 class="cart-items-quantity"}
                        {block name='basket-cart-items-quantity'}
                            {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                                {if $oPosition->istKonfigVater()}
                                    <div class="qty-wrapper max-w-sm">
                                        {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
                                        {link class="btn btn-outline-secondary configurepos btn-block btn-sm"
                                        href="{get_static_route id='index.php'}?a={$oPosition->kArtikel}&ek={$oPosition@index}"}
                                            <i class="fa fa-cogs icon-mr-2"></i>{lang key='configure'}
                                        {/link}
                                    </div>
                                {else}
                                    <div class="qty-wrapper dropdown max-w-sm">
                                        {inputgroup id="quantity-grp{$oPosition@index}" class="form-counter choose_quantity"}
                                            {inputgroupprepend}
                                                {button variant="" class="btn-decrement"
                                                    data=["count-down"=>""]
                                                    aria=["label"=>{lang key='decreaseQuantity' section='aria'}]}
                                                    <span class="fas fa-minus"></span>
                                                {/button}
                                            {/inputgroupprepend}
                                            {input type="number"
                                                min="{if $oPosition->Artikel->fMindestbestellmenge}{$oPosition->Artikel->fMindestbestellmenge}{else}0{/if}"
                                                max=$oPosition->Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''
                                                required=($oPosition->Artikel->fAbnahmeintervall > 0)
                                                step="{if $oPosition->Artikel->cTeilbar === 'Y' && $oPosition->Artikel->fAbnahmeintervall == 0}any{elseif $oPosition->Artikel->fAbnahmeintervall > 0}{$oPosition->Artikel->fAbnahmeintervall}{else}1{/if}"
                                                id="quantity[{$oPosition@index}]" class="quantity" name="anzahl[{$oPosition@index}]"
                                                aria=["label"=>"{lang key='quantity'}"]
                                                value=$oPosition->nAnzahl
                                                data=["decimals"=>{getDecimalLength quantity=$oPosition->Artikel->fAbnahmeintervall}]
                                            }
                                            {inputgroupappend}
                                                {button variant="" class="btn-increment"
                                                    data=["count-up"=>""]
                                                    aria=["label"=>{lang key='increaseQuantity' section='aria'}]}
                                                    <span class="fas fa-plus"></span>
                                                {/button}
                                            {/inputgroupappend}
                                        {/inputgroup}
                                    </div>
                                {/if}
                            {elseif $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK}
                                {input name="anzahl[{$oPosition@index}]" type="hidden" value="1"}
                            {/if}
                        {/block}
                        {/col}
                    {/block}
                    {block name='basket-cart-items-order-items-price-net'}
                        {col cols=$cols xl=2 class="cart-items-price price-col"}
                            <strong class="cart-items-price-text">{lang key="price"}:</strong>
                            <span class="price_overall text-accent">
                                {if $oPosition->istKonfigVater()}
                                    {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {else}
                                    {$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {/if}
                            </span>
                        {/col}
                    {/block}
                    {block name='basket-cart-items-cart-submit'}
                        {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL
                        || $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK
                        }
                            {col cols=$cols xl=10 class='cart-items-delete' data=['toggle'=>'product-actions']}
                                {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y' && $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                                    {block name='basket-cart-items-cart-submit-include-wishlist-button'}
                                        {include file='snippets/wishlist_button.tpl' Artikel=$oPosition->Artikel buttonAndText=true}
                                    {/block}
                                {/if}
                                {button type="submit"
                                    variant="link"
                                    size="sm"
                                    class="cart-items-delete-button droppos"
                                    name="dropPos"
                                    value=$oPosition@index
                                    title="{lang key='delete'}"}
                                    <span class="fas fa-trash-alt"></span>{lang key='delete'}
                                {/button}
                            {/col}
                        {/if}
                    {/block}
                    {block name='basket-cart-items-items-bottom-hr'}
                        {col cols=12}
                            <hr>
                        {/col}
                    {/block}
                {/row}
            {/if}
        {/foreach}
        {/block}
    {/block}
{/block}
