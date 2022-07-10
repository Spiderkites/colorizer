{block name='productdetails-details'}
    {*{has_boxes position='left' assign='hasLeftBox'}*}
    {$hasLeftBox = false}
    {container class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
        {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
            {block name='productdetails-details-include-pushed-success'}
                {include file='productdetails/pushed_success.tpl' card=true}
            {/block}
        {else}
            {block name='productdetails-details-alert-product-note'}
                {$alertList->displayAlertByKey('productNote')}
            {/block}
        {/if}
    {/container}
    {block name='productdetails-details-form'}
        {opcMountPoint id='opc_before_buy_form' inContainer=false}
        {container class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {form id="buy_form" action=$Artikel->cURLFull class="jtl-validate"}
                {row id="product-offer" class="product-detail"}
                    {block name='productdetails-details-include-image'}
                        {col cols=12 lg=6 class="product-gallery"}
                            {opcMountPoint id='opc_before_gallery'}
                            {include file='productdetails/image.tpl'}
                            {opcMountPoint id='opc_after_gallery'}
                        {/col}
                    {/block}
                    {col cols=12 lg=6 class="product-info"}
                        {block name='productdetails-details-info'}
                        <div class="product-info-inner">
                            <div class="product-headline">
                                {block name='productdetails-details-info-product-title'}
                                    {opcMountPoint id='opc_before_headline'}
                                    <h1 class="product-title h2" itemprop="name">{$Artikel->cName}</h1>
                                {/block}
                            </div>
                            {block name='productdetails-details-info-essential-wrapper'}
                            {if ($Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0) || isset($Artikel->cArtNr)}
                                {if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
                                    {block name='productdetails-details-info-rating-wrapper'}
                                        <div class="rating-wrapper" itemprop="aggregateRating" itemscope="true" itemtype="https://schema.org/AggregateRating">
                                            <meta itemprop="ratingValue" content="{$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}"/>
                                            <meta itemprop="bestRating" content="5"/>
                                            <meta itemprop="worstRating" content="1"/>
                                            <meta itemprop="reviewCount" content="{$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}"/>
                                            {block name='productdetails-details-include-rating'}
                                                {link href="{$Artikel->cURLFull}#tab-votes"
                                                    id="jump-to-votes-tab"
                                                    aria=["label"=>{lang key='Votes'}]
                                                }
                                                    {include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
                                                    ({$Artikel->Bewertungen->oBewertungGesamt->nAnzahl} {lang key='rating'})
                                                {/link}
                                            {/block}
                                        </div>
                                    {/block}
                                {/if}
                                {block name='productdetails-details-info-essential'}
                                    <ul class="info-essential list-unstyled">
                                        {block name='productdetails-details-info-item-id'}
                                            {if isset($Artikel->cArtNr)}
                                                <li class="product-sku">
                                                    <strong>
                                                        {lang key='sortProductno'}:
                                                    </strong>
                                                    <span itemprop="sku">{$Artikel->cArtNr}</span>
                                                </li>
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-mhd'}
                                            {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                                                <li class="product-mhd">
                                                    <strong title="{lang key='productMHDTool'}">
                                                        {lang key='productMHD'}:
                                                    </strong>
                                                    <span itemprop="best-before">{$Artikel->dMHD_de}</span>
                                                </li>
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-gtin'}
                                            {if !empty($Artikel->cBarcode)
                                            && ($Einstellungen.artikeldetails.gtin_display === 'details'
                                            || $Einstellungen.artikeldetails.gtin_display === 'always')}
                                                <li class="product-ean">
                                                    <strong>{lang key='ean'}:</strong>
                                                    <span itemprop="{if $Artikel->cBarcode|count_characters === 8}gtin8{else}gtin13{/if}">{$Artikel->cBarcode}</span>
                                                </li>
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-isbn'}
                                            {if !empty($Artikel->cISBN)
                                            && ($Einstellungen.artikeldetails.isbn_display === 'D'
                                            || $Einstellungen.artikeldetails.isbn_display === 'DL')}
                                                <li class="product-isbn">
                                                    <strong>{lang key='isbn'}:</strong>
                                                    <span itemprop="gtin13">{$Artikel->cISBN}</span>
                                                </li>
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-category-wrapper'}
                                            {assign var=cidx value=($Brotnavi|@count)-2}
                                            {if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y' && isset($Brotnavi[$cidx])}
                                                {block name='productdetails-details-info-category'}
                                                    <li class="product-category word-break">
                                                        <strong>{lang key='category'}: </strong>
                                                        <a href="{$Brotnavi[$cidx]->getURLFull()}" itemprop="category">{$Brotnavi[$cidx]->getName()}</a>
                                                    </li>
                                                {/block}
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-manufacturer-wrapper'}
                                            {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
                                                {block name='productdetails-details-product-info-manufacturer'}
                                                    <li  class="product-manufacturer" itemprop="brand" itemscope="true" itemtype="https://schema.org/Organization">
                                                        <strong>{lang key='manufacturers'}:</strong>
                                                        {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                                                            <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}"
                                                                {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B'}
                                                                    data-toggle="tooltip"
                                                                    data-placement="left"
                                                                    title="{$Artikel->cHersteller}"
                                                                {/if}
                                                               itemprop="url">
                                                        {/if}
                                                            {if ($Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B'
                                                                || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'BT')
                                                                && !empty($Artikel->cHerstellerBildURLKlein)}
                                                                {image lazy=true
                                                                    webp=true
                                                                    src=$Artikel->cHerstellerBildURLKlein
                                                                    alt=$Artikel->cHersteller|escape:'html'
                                                                }
                                                                <meta itemprop="image" content="{$Artikel->cHerstellerBildURLKlein}">
                                                            {/if}
                                                            {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'}
                                                                <span itemprop="name">{$Artikel->cHersteller}</span>
                                                            {/if}
                                                        {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                                                            </a>
                                                        {/if}
                                                    </li>
                                                {/block}
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-hazard-info'}
                                            {if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr)
                                            && ($Einstellungen.artikeldetails.adr_hazard_display === 'D'
                                            || $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
                                                <li class="product-hazard">
                                                    <strong>{lang key='adrHazardSign'}:</strong>
                                                    <table class="adr-table">
                                                        <tr>
                                                            <td>{$Artikel->cGefahrnr}</td>
                                                        </tr>
                                                        <tr>
                                                            <td>{$Artikel->cUNNummer}</td>
                                                        </tr>
                                                    </table>
                                                </li>
                                            {/if}
                                        {/block}
                                    </ul>
                                {/block}
                            {/if}
                            {/block}

                            {block name='productdetails-details-info-description-wrapper'}
                            {if $Einstellungen.artikeldetails.artikeldetails_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
                                {block name='productdetails-details-info-description'}
                                    {opcMountPoint id='opc_before_short_desc'}
                                    <div class="shortdesc" itemprop="description">
                                        {$Artikel->cKurzBeschreibung}
                                    </div>
                                {/block}
                            {/if}
                            {opcMountPoint id='opc_after_short_desc'}
                            {/block}

                            <div class="product-offer"{if !($Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N')} itemprop="offers" itemscope itemtype="https://schema.org/Offer"{/if}>
                                {block name='productdetails-details-info-hidden'}
                                    {if !($Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N')}
                                        <meta itemprop="url" content="{$Artikel->cURLFull}">
                                        <link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                                    {/if}
                                    {input type="hidden" name="inWarenkorb" value="1"}
                                    {if $Artikel->kArtikelVariKombi > 0}
                                        {input type="hidden" name="aK" value=$Artikel->kArtikelVariKombi}
                                    {/if}
                                    {if isset($Artikel->kVariKindArtikel)}
                                        {input type="hidden" name="VariKindArtikel" value=$Artikel->kVariKindArtikel}
                                    {/if}
                                    {if isset($smarty.get.ek)}
                                        {input type="hidden" name="ek" value=$smarty.get.ek|intval}
                                    {/if}
                                    {input type="hidden" name="AktuellerkArtikel" class="current_article" name="a" value=$Artikel->kArtikel}
                                    {input type="hidden" name="wke" value="1"}
                                    {input type="hidden" name="show" value="1"}
                                    {input type="hidden" name="kKundengruppe" value=$smarty.session.Kundengruppe->getID()}
                                    {input type="hidden" name="kSprache" value=$smarty.session.kSprache}
                                {/block}
                                {block name='productdetails-details-include-variation'}
                                    <!-- VARIATIONEN -->
                                    {include file='productdetails/variation.tpl' simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}
                                {/block}

                                {row}
                                    {block name='productdetails-details-include-price'}
                                        {if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX]))}
                                            {col}
                                                {include file='productdetails/price.tpl' Artikel=$Artikel tplscope='detail' priceLarge=true}
                                            {/col}
                                        {/if}
                                    {/block}
                                    {block name='productdetails-details-stock'}
                                        {col cols=12}
                                            {row no-gutters=true class="stock-information {if !isset($availability) && !isset($shippingTime)}stock-information-p{/if}"}
                                                {col}
                                                    {block name='productdetails-details-include-stock'}
                                                        {include file='productdetails/stock.tpl'}
                                                    {/block}
                                                {/col}
                                                {col class="question-on-item col-auto"}
                                                    {block name='productdetails-details-question-on-item'}
                                                        {if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
                                                            <button type="button" id="z{$Artikel->kArtikel}"
                                                                    class="btn btn-link question"
                                                                    title="{lang key='productQuestion' section='productDetails'}"
                                                                    data-toggle="modal"
                                                                    data-target="#question-popup-{$Artikel->kArtikel}">
                                                                <span class="fa fa-question-circle"></span>
                                                                <span class="hidden-xs hidden-sm">{lang key='productQuestion' section='productDetails'}</span>
                                                            </button>
                                                        {/if}
                                                    {/block}
                                                {/col}
                                            {/row}
                                            {block name='snippets-stock-note-include-warehouse'}
                                                {include file='productdetails/warehouse.tpl'}
                                            {/block}
                                        {/col}
                                    {/block}
                                {/row}
                                {*UPLOADS product-specific files, e.g. for customization*}
                                {block name='productdetails-details-include-uploads'}
                                    {include file="snippets/uploads.tpl" tplscope='product'}
                                {/block}
                                {*WARENKORB anzeigen wenn keine variationen mehr auf lager sind?!*}
                                {if $Artikel->bHasKonfig}
                                    {block name='productdetails-details-config-button'}
                                        {row}
                                            {if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0}
                                                {block name='productdetails-details-config-button-info'}
                                                    {col cols=12 class="js-choose-variations-wrapper"}
                                                        {alert variation="info" class="choose-variations"}
                                                            {lang key='chooseVariations' section='messages'}
                                                        {/alert}
                                                    {/col}
                                                {/block}
                                            {/if}
                                            {block name='productdetails-details-config-button-button'}
                                                {col cols=12 sm=6}
                                                    {button type="button"
                                                        class="start-configuration js-start-configuration"
                                                        value="{lang key='configure'}"
                                                        block=true
                                                        data=["toggle"=>"modal", "target"=>"#cfg-container"]
                                                        disabled=(isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0)
                                                    }
                                                        <span>{lang key='configure'}</span> <i class="fas fa-cogs"></i>
                                                    {/button}
                                                {/col}
                                            {/block}
                                        {/row}
                                    {/block}
                                    {block name='productdetails-details-include-config-container'}
                                        {row id="product-configurator"}
                                            {include file='productdetails/config_container.tpl'}
                                        {/row}
                                    {/block}
                                {else}
                                    {block name='productdetails-details-include-basket'}
                                        {include file='productdetails/basket.tpl'}
                                    {/block}
                                {/if}
                            </div>
                        </div>{* /product-info-inner *}
                        {/block}{* productdetails-info *}
                        {opcMountPoint id='opc_after_product_info'}
                    {/col}
                {/row}
                {block name='productdetails-details-include-matrix'}
                    {include file='productdetails/matrix.tpl'}
                {/block}
            {/form}
        {/container}
    {/block}

    {block name='productdetails-details-content-not-quickview'}
        {block name='productdetails-details-include-tabs'}
            {include file='productdetails/tabs.tpl'}
        {/block}

        {*SLIDERS*}
        {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0
        || isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0
        || isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0
        || isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0
        || isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
            {container fluid=true class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0}
                    {block name='productdetails-details-include-product-slider-partslist'}
                        <div class="partslist">
                            {lang key='listOfItems' section='global' assign='slidertitle'}
                            {include file='snippets/product_slider.tpl' id='slider-partslist' productlist=$Artikel->oStueckliste_arr title=$slidertitle showPartsList=true}
                        </div>
                    {/block}
                {/if}

                {if isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0}
                    {block name='productdetails-details-include-bundle'}
                        <div class="bundle">
                            {include file='productdetails/bundle.tpl' ProductKey=$Artikel->kArtikel Products=$Artikel->oProduktBundle_arr ProduktBundle=$Artikel->oProduktBundlePrice ProductMain=$Artikel->oProduktBundleMain}
                        </div>
                    {/block}
                {/if}
                {if isset($Xselling->Standard) || isset($Xselling->Kauf) || isset($oAehnlicheArtikel_arr)}
                    <div class="recommendations d-print-none">
                        {block name='productdetails-details-recommendations'}
                            {if isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0}
                                {foreach $Xselling->Standard->XSellGruppen as $Gruppe}
                                    {include file='snippets/product_slider.tpl' class='x-supplies' id='slider-xsell-group-'|cat:$Gruppe@iteration productlist=$Gruppe->Artikel title=$Gruppe->Name}
                                {/foreach}
                            {/if}

                            {if isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0}
                                {lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails' assign='slidertitle'}
                                {include file='snippets/product_slider.tpl' class='x-sell' id='slider-xsell' productlist=$Xselling->Kauf->Artikel title=$slidertitle}
                            {/if}

                            {if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                                {lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
                                {include file='snippets/product_slider.tpl' class='x-related' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
                            {/if}
                        {/block}
                    </div>
                {/if}
            {/container}
        {/if}
        {block name='productdetails-details-include-popups'}
            <div id="article_popups">
                {include file='productdetails/popups.tpl'}
            </div>
        {/block}
    {/block}
{/block}
