{block name='comparelist-index'}
    {block name='comparelist-index-include-header'}
        {include file='layout/header.tpl'}
    {/block}

    {assign var='descriptionLength' value=200}

    {block name='comparelist-index-content'}
        {block name='comparelist-index-heading'}
            {opcMountPoint id='opc_before_heading' inContainer=false}
            {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                <h1 class="h2">{lang key='compare' section='global'}</h1>
                {if !$isAjax}
                    <hr class="hr-no-top">
                {/if}
            {/container}
        {/block}
        {block name='comparelist-index-include-extension'}
            {include file='snippets/extension.tpl'}
        {/block}

        {if $oVergleichsliste->oArtikel_arr|@count > 0}
            {block name='comparelist-index-filter'}
                {opcMountPoint id='opc_before_filter' inContainer=false}
                {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                    <div id="filter-checkboxes">
                        {block name='comparelist-index-filter-buttons'}
                            {row}
                                {col}
                                    {buttongroup}
                                        {button
                                            variant="outline-secondary"
                                            role="button"
                                            data=["toggle"=> "collapse", "target"=>"#collapse-checkboxes"]
                                        }
                                            {lang key='filter'}
                                        {/button}
                                        {button variant="outline-secondary" id="check-all"}
                                            {lang key='showAll'}
                                        {/button}
                                        {button variant="outline-secondary" id="check-none"}
                                            {lang key='showNone'}
                                        {/button}
                                    {/buttongroup}
                                {/col}
                            {/row}
                        {/block}
                        {block name='comparelist-index-filter-items'}
                            {collapse id="collapse-checkboxes" visible=false class="comparelist-checkboxes"}
                                {row}
                                    {foreach $prioRows as $row}
                                        {if $row['key'] !== 'Merkmale' && $row['key'] !== 'Variationen'}
                                            {col cols=6 md=4 lg=3 xl=2 class="comparelist-checkbox-wrapper"}
                                                {checkbox checked=true data=['id' => $row['key']] class='comparelist-checkbox'}
                                                    <div class="text-truncate">{$row['name']}</div>
                                                {/checkbox}
                                            {/col}
                                        {/if}
                                        {if $row['key'] === 'Merkmale'}
                                            {foreach $oMerkmale_arr as $oMerkmale}
                                                {col cols=6 md=4 lg=3 xl=2 class="comparelist-checkbox-wrapper"}
                                                    {checkbox checked=true data=['id' => "attr-{$oMerkmale->cName}"] class='comparelist-checkbox'}
                                                        <div class="text-truncate">{$oMerkmale->cName}</div>
                                                    {/checkbox}
                                                {/col}
                                            {/foreach}
                                        {/if}
                                        {if $row['key'] === 'Variationen'}
                                            {foreach $oVariationen_arr as $oVariationen}
                                                {col cols=6 md=4 lg=3 xl=2 class="comparelist-checkbox-wrapper"}
                                                    {checkbox checked=true data=['id' => "vari-{$oVariationen->cName}"] class='comparelist-checkbox'}
                                                        <div class="text-truncate">{$oVariationen->cName}</div>
                                                    {/checkbox}
                                                {/col}
                                            {/foreach}
                                        {/if}
                                    {/foreach}
                                {/row}
                            {/collapse}
                        {/block}
                    </div>
                {/container}
            {/block}
            {block name='comparelist-index-products'}
                {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                    {block name='comparelist-index-products-header-label'}
                        {button size="sm" variant="outline-secondary" id="switch-label"}
                            <span class="comparelist-label d-none">{lang key='showLabels' section='comparelist'}</span>
                            <span class="comparelist-label">{lang key='hideLabels' section='comparelist'}</span>
                        {/button}
                    {/block}
                    {block name='comparelist-index-products-header-delete-all'}
                        {button class="comparelist-delete-all"
                            href="{get_static_route id='vergleichsliste.php'}?delete=all"
                            size="sm"
                            variant="outline-secondary"
                            id="delete-all"}
                            {lang key='comparelistDeleteAll' section='comparelist'}
                        {/button}
                    {/block}
                    <div class="comparelist table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                            {block name='comparelist-index-products-header'}
                                <tr>
                                    <th class="sticky-top comparelist-label">&nbsp;</th>
                                    {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                                        <th class="comparelist-item sticky-top min-w" data-product-id-cl="{$oArtikel->kArtikel}">
                                            <div class="stretched">
                                                <div>
                                                    {block name='comparelist-index-products-header-delete'}
                                                        <div class="delete-link-times">
                                                            {link href=$oArtikel->cURLDEL
                                                                class="text-decoration-none-util"
                                                                title="{lang key='removeFromCompareList' section='comparelist'}"
                                                                aria=["label"=>"{lang key='removeFromCompareList' section='comparelist'}"]
                                                                data=["toggle"=>"tooltip"]}
                                                                <i class="fas fa-times"></i>
                                                            {/link}
                                                        </div>
                                                    {/block}
                                                    {block name='comparelist-index-products-header-image'}
                                                        {link href=$oArtikel->cURLFull}
                                                            {include file='snippets/image.tpl' item=$oArtikel srcSize='xs' square=false class='comparelist-item-image' sizes='200px'}
                                                        {/link}
                                                    {/block}
                                                </div>
                                                {block name='comparelist-index-products-header-title'}
                                                    <span>
                                                        {link href=$oArtikel->cURLFull}{$oArtikel->cName}{/link}
                                                    </span>
                                                {/block}
                                                {block name='comparelist-index-include-rating'}
                                                    {include file='productdetails/rating.tpl' stars=$oArtikel->fDurchschnittsBewertung link=$oArtikel->cURLFull}
                                                {/block}
                                                {block name='comparelist-index-products-header-availability'}
                                                    {if $oArtikel->getOption('nShowOnlyOnSEORequest', 0) === 1}
                                                        <p>{lang key='productOutOfStock' section='productDetails'}</p>
                                                    {elseif $oArtikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                                                        <p>{lang key='priceOnApplication' section='global'}</p>
                                                    {else}
                                                        {block name='comparelist-index-include-price'}
                                                            {include file='productdetails/price.tpl' Artikel=$oArtikel tplscope='detail'}
                                                        {/block}
                                                    {/if}
                                                {/block}
                                            </div>
                                        </th>
                                    {/foreach}
                                </tr>
                            {/block}
                            </thead>
                            {block name='comparelist-index-products-rows'}
                            {foreach $prioRows as $row}
                                {if $row['key'] !== 'Merkmale' && $row['key'] !== 'Variationen'}
                                    <tr class="comparelist-row" data-id="row-{$row['key']}">
                                    {block name='comparelist-index-products-row-name'}
                                        <td class="comparelist-label">
                                            {$row['name']|truncate:20}
                                        </td>
                                    {/block}
                                    {block name='comparelist-index-products'}
                                        {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                                            {if $row['key'] === 'verfuegbarkeit'}
                                                <td data-product-id-cl="{$oArtikel->kArtikel}">
                                                    {block name='comparelist-index-products-row-abailability'}
                                                        {block name='comparelist-index-products-includes-stock-availability'}
                                                            {include file='productdetails/stock.tpl' Artikel=$oArtikel availability=true}
                                                        {/block}
                                                        {if $oArtikel->nErscheinendesProdukt}
                                                            <div>
                                                                {lang key='productAvailableFrom' section='global'}: <strong>{$oArtikel->Erscheinungsdatum_de}</strong>
                                                                {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $oArtikel->inWarenkorbLegbar == 1}
                                                                    ({lang key='preorderPossible' section='global'})
                                                                {/if}
                                                            </div>
                                                        {/if}
                                                    {/block}
                                                </td>
                                            {elseif $row['key'] === 'lieferzeit'}
                                                <td data-product-id-cl="{$oArtikel->kArtikel}">
                                                    {block name='comparelist-index-products-includes-stock-shipping-time'}
                                                        {include file='productdetails/stock.tpl' Artikel=$oArtikel shippingTime=true}
                                                    {/block}
                                                </td>
                                            {elseif $oArtikel->$row['key'] !== ''}
                                                <td style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesse}px" data-product-id-cl="{$oArtikel->kArtikel}">
                                                    {if $row['key'] === 'fArtikelgewicht' || $row['key'] === 'fGewicht'}
                                                        {block name='comparelist-index-products-row-weight'}
                                                            {$oArtikel->$row['key']} {lang key='weightUnit' section='comparelist'}
                                                        {/block}
                                                    {elseif $row['key'] === 'cBeschreibung' || $row['key'] === 'cKurzBeschreibung'}
                                                        {block name='comparelist-index-products-row-description'}
                                                            {if $oArtikel->$row['key']|strlen < $descriptionLength}
                                                                {$oArtikel->$row['key']}
                                                            {else}
                                                                <div>
                                                                    <span>
                                                                        {$oArtikel->$row['key']|substr:0:$descriptionLength}
                                                                    </span>
                                                                    {collapse tag='span' id="read-more-{$oArtikel->kArtikel}-"|cat:$row['key']}
                                                                        {$oArtikel->$row['key']|substr:$descriptionLength}
                                                                    {/collapse}
                                                                </div>
                                                                {block name='comparelist-index-products-row-description-more'}
                                                                    {button class='comparelist-item-more' variant='link' data=['toggle' => 'collapse', 'target' => "#read-more-{$oArtikel->kArtikel}-"|cat:$row['key']]}
                                                                        {lang key='more'}
                                                                    {/button}
                                                                {/block}
                                                            {/if}
                                                        {/block}
                                                    {else}
                                                        {block name='comparelist-index-products-row-default'}
                                                            {$oArtikel->$row['key']}
                                                        {/block}
                                                    {/if}
                                                </td>
                                            {else}
                                                {block name='comparelist-index-products-row-none'}
                                                    <td data-product-id-cl="{$oArtikel->kArtikel}">--</td>
                                                {/block}
                                            {/if}
                                        {/foreach}
                                    {/block}
                                    </tr>
                                {elseif $row['key'] === 'Merkmale'}
                                    {block name='comparelist-index-characteristics'}
                                        {foreach $oMerkmale_arr as $oMerkmale}
                                            <tr class="comparelist-row" data-id="row-attr-{$oMerkmale->cName}">
                                                <td class="comparelist-label">
                                                    {$oMerkmale->cName|truncate:20}
                                                </td>
                                                {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                                                    <td style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesse}px" data-product-id-cl="{$oArtikel->kArtikel}">
                                                        {if count($oArtikel->oMerkmale_arr) > 0}
                                                            {foreach $oArtikel->oMerkmale_arr as $oMerkmaleArtikel}
                                                                {if $oMerkmale->cName == $oMerkmaleArtikel->cName}
                                                                    {foreach $oMerkmaleArtikel->oMerkmalWert_arr as $oMerkmalWert}
                                                                        {$oMerkmalWert->cWert}{if !$oMerkmalWert@last}, {/if}
                                                                    {/foreach}
                                                                {/if}
                                                            {/foreach}
                                                        {else}
                                                            --
                                                        {/if}
                                                    </td>
                                                {/foreach}
                                            </tr>
                                        {/foreach}
                                    {/block}
                                {elseif $row['key'] === 'Variationen'}
                                    {block name='comparelist-index-variations'}
                                        {foreach $oVariationen_arr as $oVariationen}
                                            <tr class="comparelist-row" data-id="row-vari-{$oVariationen->cName}">
                                                {block name='comparelist-index-variation-name'}
                                                    <td class="comparelist-label">
                                                        {$oVariationen->cName|truncate:20}
                                                    </td>
                                                {/block}
                                                {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                                                    <td data-product-id-cl="{$oArtikel->kArtikel}">
                                                        {if isset($oArtikel->oVariationenNurKind_arr) && $oArtikel->oVariationenNurKind_arr|@count > 0}
                                                            {foreach $oArtikel->oVariationenNurKind_arr as $oVariationenArtikel}
                                                                {if $oVariationen->cName == $oVariationenArtikel->cName}
                                                                    {foreach $oVariationenArtikel->Werte as $oVariationsWerte}
                                                                        {$oVariationsWerte->cName}
                                                                        {if $oArtikel->nVariationOhneFreifeldAnzahl == 1 && ($oArtikel->kVaterArtikel > 0 || $oArtikel->nIstVater == 1)}
                                                                            {assign var=kEigenschaftWert value=$oVariationsWerte->kEigenschaftWert}
                                                                            ({$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}{if !empty($oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}, {$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
                                                                        {/if}
                                                                    {/foreach}
                                                                {/if}
                                                            {/foreach}
                                                        {elseif $oArtikel->Variationen|@count > 0}
                                                            {foreach $oArtikel->Variationen as $oVariationenArtikel}
                                                                {if $oVariationen->cName == $oVariationenArtikel->cName}
                                                                    {foreach $oVariationenArtikel->Werte as $oVariationsWerte}
                                                                        {$oVariationsWerte->cName}
                                                                        {if $Einstellungen_Vergleichsliste.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationsWerte->fAufpreisNetto != 0}
                                                                            ({$oVariationsWerte->cAufpreisLocalized[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise]}{/if})
                                                                        {elseif $Einstellungen_Vergleichsliste.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationsWerte->fAufpreisNetto != 0}
                                                                            ({$oVariationsWerte->cPreisInklAufpreis[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
                                                                        {/if}
                                                                        {if !$oVariationsWerte@last},{/if}
                                                                    {/foreach}
                                                                {/if}
                                                            {/foreach}
                                                        {else}
                                                            &nbsp;
                                                        {/if}
                                                    </td>
                                                {/foreach}
                                            </tr>
                                        {/foreach}
                                    {/block}
                                {/if}
                            {/foreach}
                            {/block}
                        </table>
                    </div>
                {/container}
            {/block}
        {else}
            {block name='comparelist-index-empty'}
                {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                    {lang key='compareListNoItems'}
                {/container}
            {/block}
        {/if}

        {if isset($bAjaxRequest) && $bAjaxRequest}
            {block name='comparelist-index-script-remove'}
                {inline_script}<script>
                    $('.modal a.remove').click(function(e) {
                        var kArtikel = $(e.currentTarget).data('id');
                        $('section.box-compare li[data-id="' + kArtikel + '"]').remove();
                        eModal.ajax({
                            size: 'lg',
                            url: e.currentTarget.href,
                            title: '{lang key='compare' section='global'}',
                            keyboard: true,
                            tabindex: -1
                        });

                        return false;
                    });
                    new function(){
                        var clCount = {if isset($oVergleichsliste->oArtikel_arr)}{$oVergleichsliste->oArtikel_arr|count}{else}0{/if};
                        $('.navbar-nav .compare-list-menu .badge em').html(clCount);
                        if (clCount > 1) {
                            $('section.box-compare .panel-body').removeClass('hidden');
                        } else {
                            $('.navbar-nav .compare-list-menu .link_to_comparelist').removeAttr('href').removeClass('popup');
                            eModal.close();
                        }
                    }();
                </script>{/inline_script}
            {/block}
        {/if}
        {block name='comparelist-index-script-check'}
            {inline_script}<script>
                $(document).ready(function () {
                    $('.comparelist-checkbox').on('change', function () {
                        $('[data-id="row-' + $(this).data('id') + '"]').toggleClass('d-none');
                    });
                    $('#check-all').on('click', function () {
                        $('.comparelist-checkbox').prop('checked', true);
                        $('.comparelist-row').removeClass('d-none');
                    });
                    $('#check-none').on('click', function () {
                        $('.comparelist-checkbox').prop('checked', false);
                        $('.comparelist-row').addClass('d-none');
                    });
                    $('#switch-label').on('click', function () {
                        $('.comparelist-label').toggleClass('d-none');
                    });
                });
            </script>{/inline_script}
        {/block}
    {/block}

    {block name='comparelist-index-include-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
