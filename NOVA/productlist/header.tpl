{block name='productlist-header'}
    {if !isset($oNavigationsinfo)
        || (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory())}
        {opcMountPoint id='opc_before_heading'}
        {block name='productlist-header-heading'}
            <div class="h1">{$Suchergebnisse->getSearchTermWrite()}</div>
        {/block}
    {/if}

    {if $Suchergebnisse->getSearchUnsuccessful() == true}
        {opcMountPoint id='opc_before_no_results'}
        {block name='productlist-header-alert'}
            {alert variant="info"}{lang key='noResults' section='productOverview'}{/alert}
        {/block}
        {block name='productlist-header-form-search'}
            {form id="suche2" action=$ShopURL method="get" slide=true}
                <fieldset>
                    {formgroup label-for="searchkey" label="{lang key='searchText'}"}
                            {input type="text" name="suchausdruck" value="{if $Suchergebnisse->getSearchTerm()}{$Suchergebnisse->getSearchTerm()|escape:'htmlall'}{/if}" id="searchkey"}
                    {/formgroup}
                    {button variant="primary" type="submit" value="1"}{lang key='searchAgain' section='productOverview'}{/button}
                </fieldset>
            {/form}
        {/block}
    {/if}

    {block name='productlist-header-include-extension'}
        {include file='snippets/extension.tpl'}
    {/block}

    {block name='productlist-header-description'}
        {$showTitle = true}
        {$showImage = true}
        {$navData = null}
        {if $oNavigationsinfo->getCategory() !== null}
            {$showTitle = in_array($Einstellungen['navigationsfilter']['kategorie_bild_anzeigen'], ['Y', 'BT'])}
            {$showImage = in_array($Einstellungen['navigationsfilter']['kategorie_bild_anzeigen'], ['B', 'BT'])}
            {$navData = $oNavigationsinfo->getCategory()}
        {elseif $oNavigationsinfo->getManufacturer() !== null}
            {$showImage = in_array($Einstellungen['navigationsfilter']['hersteller_bild_anzeigen'], ['B', 'BT'])}
            {$showTitle = in_array($Einstellungen['navigationsfilter']['hersteller_bild_anzeigen'], ['Y', 'BT'])}
            {$navData = $oNavigationsinfo->getManufacturer()}
        {elseif $oNavigationsinfo->getCharacteristicValue() !== null}
            {$showImage = in_array($Einstellungen['navigationsfilter']['merkmalwert_bild_anzeigen'], ['B', 'BT'])}
            {$showTitle = in_array($Einstellungen['navigationsfilter']['merkmalwert_bild_anzeigen'], ['Y', 'BT'])}
            {$navData = $oNavigationsinfo->getCharacteristicValue()}
        {/if}

        {if $oNavigationsinfo->getImageURL() !== $smarty.const.BILD_KEIN_KATEGORIEBILD_VORHANDEN
            && $oNavigationsinfo->getImageURL() !== 'gfx/keinBild_kl.gif'
            && $oNavigationsinfo->getImageURL() !== $imageBaseURL|cat:$smarty.const.BILD_KEIN_KATEGORIEBILD_VORHANDEN
            && $showImage}
                {include file='snippets/image.tpl'
                class='productlist-header-description-image'
                item=$navData
                square=false
                alt="{if $oNavigationsinfo->getCategory() !== null && !empty($navData->getImageAlt())}{$navData->getImageAlt()}{else}{$navData->cBeschreibung|strip_tags|truncate:50}{/if}"}
        {/if}
        {if $oNavigationsinfo->getName() && $showTitle}
            <div class="title">
                {opcMountPoint id='opc_before_heading'}
                {block name='productlist-header-description-heading'}
                    <h1 class="h2">{$oNavigationsinfo->getName()}</h1>
                {/block}
            </div>
        {/if}

        {if $Einstellungen.navigationsfilter.kategorie_beschreibung_anzeigen === 'Y'
            && $oNavigationsinfo->getCategory() !== null
            && $oNavigationsinfo->getCategory()->cBeschreibung|strlen > 0}
            {block name='productlist-header-description-category'}
                <div class="desc">
                    <p>{$oNavigationsinfo->getCategory()->cBeschreibung}</p>
                </div>
            {/block}
        {/if}
        {if $Einstellungen.navigationsfilter.hersteller_beschreibung_anzeigen === 'Y'
            && $oNavigationsinfo->getManufacturer() !== null
            && $oNavigationsinfo->getManufacturer()->cBeschreibung|strlen > 0}
            {block name='productlist-header-description-manufacturers'}
                <div class="desc">
                    <p>{$oNavigationsinfo->getManufacturer()->cBeschreibung}</p>
                </div>
            {/block}
        {/if}
        {if $Einstellungen.navigationsfilter.merkmalwert_beschreibung_anzeigen === 'Y'
            && $oNavigationsinfo->getCharacteristicValue() !== null
            && $oNavigationsinfo->getCharacteristicValue()->cBeschreibung|strlen > 0}
            {block name='productlist-header-description-attributes'}
                <div class="desc">
                    <p>{$oNavigationsinfo->getCharacteristicValue()->cBeschreibung}</p>
                </div>
            {/block}
        {/if}
    {/block}

    {block name='productlist-header-subcategories'}
        {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'N' && $oUnterKategorien_arr|@count > 0}
            {opcMountPoint id='opc_before_subcategories'}
            {row class="row-eq-height content-cats-small"}
                {foreach $oUnterKategorien_arr as $subCategory}
                    {col cols=12 md=4 lg=3}
                        <div class="sub-categories">
                            {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'Y'}
                                {block name='productlist-header-subcategories-image'}
                                    {link href=$subCategory->getURL()}
                                        {$imgAlt = $subCategory->getAttribute('img_alt')}
                                        <div class="subcategories-image d-none d-md-flex">
                                            {image fluid=true lazy=true webp=true
                                                src=$subCategory->getImage(\JTL\Media\Image::SIZE_SM)
                                                alt="{if empty($imgAlt->cWert)}{$subCategory->getName()}{else}{$imgAlt->cWert}{/if}"}
                                        </div>
                                    {/link}
                                {/block}
                            {/if}
                            <div>
                                {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'B'}
                                    {block name='productlist-header-subcategories-link'}
                                        <div class="caption">
                                            {link href=$subCategory->getURL()}
                                                {$subCategory->getName()}
                                            {/link}
                                        </div>
                                    {/block}
                                {/if}
                                {if $Einstellungen.navigationsfilter.unterkategorien_beschreibung_anzeigen === 'Y'
                                        && !empty($subCategory->getDescription())}
                                    {block name='productlist-header-subcategories-description'}
                                        <p class="item_desc small text-muted-util d-none d-md-block">
                                            {$subCategory->getDescription()|strip_tags|truncate:68}
                                        </p>
                                    {/block}
                                {/if}
                                {if $Einstellungen.navigationsfilter.unterkategorien_lvl2_anzeigen === 'Y'}
                                    {if $subCategory->hasChildren()}
                                        {block name='productlist-header-subcategories-list'}
                                            <hr class="d-none d-md-block">
                                            <ul class="d-none d-md-block">
                                                {foreach $subCategory->getChildren() as $subChild}
                                                    <li>
                                                        {link href=$subChild->getURL() title=$subChild->getName()}{$subChild->getName()}{/link}
                                                    </li>
                                                {/foreach}
                                            </ul>
                                        {/block}
                                    {/if}
                                {/if}
                            </div>
                        </div>
                    {/col}
                {/foreach}
            {/row}
        {/if}
    {/block}

    {block name='productlist-header-include-selection-wizard'}
        {include file='selectionwizard/index.tpl' container=false}
    {/block}

    {if $Suchergebnisse->getProducts()|@count <= 0 && isset($KategorieInhalt)}
        {if isset($KategorieInhalt->TopArtikel->elemente) && $KategorieInhalt->TopArtikel->elemente|@count > 0}
            {block name='productlist-header-include-product-slider-top'}
                {opcMountPoint id='opc_before_category_top'}
                {lang key='topOffer' assign='slidertitle'}
                {include file='snippets/product_slider.tpl' id='slider-top-products'
                        productlist=$KategorieInhalt->TopArtikel->elemente title=$slidertitle}
            {/block}
        {/if}

        {if isset($KategorieInhalt->BestsellerArtikel->elemente) && $KategorieInhalt->BestsellerArtikel->elemente|@count > 0}
            {block name='productlist-header-include-product-slider-bestseller'}
                {opcMountPoint id='opc_before_category_bestseller'}
                {lang key='bestsellers'  assign='slidertitle'}
                {include file='snippets/product_slider.tpl' id='slider-bestseller-products'
                        productlist=$KategorieInhalt->BestsellerArtikel->elemente title=$slidertitle}
            {/block}
        {/if}
    {/if}

    {block name='productlist-header-include-productlist-page-nav'}
        {include file='snippets/productlist_page_nav.tpl' navid='header'}
    {/block}

    {block name='productlist-header-include-active-filter'}
        {if $NaviFilter->getFilterCount() > 0}
            {$alertList->displayAlertByKey('noFilterResults')}
        {/if}
        {include file='snippets/filter/active_filter.tpl'}
    {/block}
{/block}
