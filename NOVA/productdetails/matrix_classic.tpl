{block name='productdetails-matrix-classic'}
    {assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
    {block name='productdetails-matrix-classic-sold-out'}
        {capture name='outofstock' assign='outofstockInfo'}<span class="delivery-status"><small class="status-0">{lang key='soldout'}</small></span>{/capture}
    {/block}
    {block name='productdetails-matrix-classic-table'}
    <div class="table-responsive">
        <table class="table table-striped table-hover variation-matrix">
            {* ****** 2-dimensional ****** *}
            {if $Artikel->VariationenOhneFreifeld|@count === 2}
                {block name='productdetails-matrix-classic-2-dimensional'}
                    <thead>
                    <tr>
                        <td>&nbsp;</td>
                        {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWertHead}
                            <td>
                                {if $Artikel->oVariBoxMatrixBild_arr|@count > 0
                                    && (($Artikel->nIstVater == 1
                                    && $Artikel->oVariBoxMatrixBild_arr[0]->nRichtung == 0)
                                    || $Artikel->nIstVater == 0)}
                                    {foreach $Artikel->oVariBoxMatrixBild_arr as $oVariBoxMatrixBild}
                                        {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                            {image src=$oVariBoxMatrixBild->cBild fluid=true lazy=true alt=$oVariationWertHead->cName}<br>
                                        {/if}
                                    {/foreach}
                                {/if}
                                <strong>{$oVariationWertHead->cName}</strong>
                            </td>
                        {/foreach}
                    </tr>
                    </thead>
                    <tbody>
                    {if isset($Artikel->VariationenOhneFreifeld[1]->Werte)}
                        {foreach $Artikel->VariationenOhneFreifeld[1]->Werte as $oVariationWert1}
                            {assign var=kEigenschaftWert1 value=$oVariationWert1->kEigenschaftWert}
                            <tr>
                                <td>
                                    {if $Artikel->oVariBoxMatrixBild_arr|@count > 0
                                        && (($Artikel->nIstVater == 1
                                                && $Artikel->oVariBoxMatrixBild_arr[0]->nRichtung == 1)
                                            || $Artikel->nIstVater == 0)}
                                        {foreach $Artikel->oVariBoxMatrixBild_arr as $oVariBoxMatrixBild}
                                            {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWert1->kEigenschaftWert}
                                                {image src=$oVariBoxMatrixBild->cBild fluid=true lazy=true alt=$oVariationWert1->cName}<br>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                    <strong>{$oVariationWert1->cName}</strong>
                                </td>
                                {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWert0}
                                    {assign var=bAusblenden value=false}
                                    {assign var=cVariBox value=$oVariationWert0->kEigenschaft|cat:':'|cat:$oVariationWert0->kEigenschaftWert|cat:'_'|cat:$oVariationWert1->kEigenschaft|cat:':'|cat:$oVariationWert1->kEigenschaftWert}
                                    {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                                        {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
                                    {elseif $Artikel->nIstVater}
                                        {assign var=bAusblenden value=true}
                                    {/if}
                                    {if !$bAusblenden}
                                        <td>
                                            {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N'
                                                && isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                <small>
                                                    {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                </small>
                                            {elseif isset($child->nNichtLieferbar) && $child->nNichtLieferbar == 1}
                                                {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                    <small>
                                                        {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                    </small>
                                                {else}
                                                    {if !empty($child)}
                                                        {block name='productdetails-matrix-classic-include-stock-status-2-dimesional-1'}
                                                            {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                        {/block}
                                                    {else}
                                                        {$outofstockInfo}
                                                    {/if}
                                                {/if}
                                            {elseif (isset($child->bHasKonfig)
                                                && $child->bHasKonfig == true)
                                                || (isset($child->nVariationAnzahl)
                                                    && isset($child->nVariationOhneFreifeldAnzahl)
                                                    && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                                <div>
                                                    {link href=$child->cSeo title="{lang key='configure'} {$oVariationWert0->cName}-{$oVariationWert1->cName}" class="btn btn-primary configurepos"}
                                                        <i class="fa fa-cogs"></i>
                                                        <span>{lang key='configure'}</span>
                                                    {/link}
                                                </div>
                                                {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                    <div>
                                                        <small>
                                                            {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                        </small>
                                                    </div>
                                                {/if}
                                                <div class="delivery-status">
                                                    <small>
                                                        {if !isset($child->nErscheinendesProdukt) || !$child->nErscheinendesProdukt}
                                                            {block name='productdetails-matrix-classic-include-stock-status-2-dimesional-2'}
                                                                {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                            {/block}
                                                        {else}
                                                            {if $anzeige === 'verfuegbarkeit'
                                                                || $anzeige === 'genau'
                                                                && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0)
                                                                    || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                                <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                            {elseif $anzeige === 'ampel'
                                                                && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0)
                                                                    || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                                <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                            {/if}
                                                        {/if}
                                                    </small>
                                                </div>
                                            {else}
                                                {inputgroup class="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError)}has-error{/if}"}
                                                    {input placeholder="0"
                                                        name="variBoxAnzahl[{$oVariationWert1->kEigenschaft}:{$oVariationWert1->kEigenschaftWert}_{$oVariationWert0->kEigenschaft}:{$oVariationWert0->kEigenschaftWert}]"
                                                        type="text"
                                                        aria=["label"=>"{lang key='quantity'} {$oVariationWert0->cName}-{$oVariationWert1->cName}"]
                                                        value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}"
                                                        class="text-right-util"}
                                                    {if $Artikel->nIstVater == 1}
                                                        {if isset($child->Preise->cVKLocalized[$NettoPreise]) && $child->Preise->cVKLocalized[$NettoPreise] > 0}
                                                            {inputgroupaddon append=true}
                                                                {inputgrouptext}
                                                                    &times; {$child->Preise->cVKLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                                                {/inputgrouptext}
                                                            {/inputgroupaddon}
                                                        {elseif isset($child->Preise->cVKLocalized[$NettoPreise])
                                                            && $child->Preise->cVKLocalized[$NettoPreise]}
                                                            {assign var=cVariBox value=$oVariationWert1->kEigenschaft|cat:':'|cat:$oVariationWert1->kEigenschaftWert|cat:'_'|cat:$oVariationWert0->kEigenschaft|cat:':'|cat:$oVariationWert0->kEigenschaftWert}
                                                            {inputgroupaddon append=true}
                                                                {inputgrouptext}
                                                                    &times; {$child->Preise->cVKLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                                                {/inputgrouptext}
                                                            {/inputgroupaddon}
                                                        {/if}
                                                    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1
                                                        && ($oVariationWert0->fAufpreisNetto != 0 || $oVariationWert1->fAufpreisNetto != 0)}
                                                        {if !isset($oVariationWert1->fAufpreis[1])}
                                                            {assign var=ovw1 value=0}
                                                        {else}
                                                            {assign var=ovw1 value=$oVariationWert1->fAufpreis[1]}
                                                        {/if}
                                                        {if !isset($oVariationWert0->fAufpreis[1])}
                                                            {assign var=ovw0 value=0}
                                                        {else}
                                                            {assign var=ovw0 value=$oVariationWert0->fAufpreis[1]}
                                                        {/if}

                                                        {math equation='x+y' x=$ovw0 y=$ovw1 assign='fAufpreis'}
                                                        {inputgroupaddon append=true}
                                                            {inputgrouptext}
                                                                {gibPreisStringLocalizedSmarty bAufpreise=true fAufpreisNetto=$fAufpreis fVKNetto=$Artikel->Preise->fVKNetto kSteuerklasse=$Artikel->kSteuerklasse nNettoPreise=$NettoPreise fVPEWert=$Artikel->fVPEWert cVPEEinheit=$Artikel->cVPEEinheit FunktionsAttribute=$Artikel->FunktionsAttribute}&nbsp;<span class="footnote-reference">*</span>
                                                            {/inputgrouptext}
                                                        {/inputgroupaddon}
                                                    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2
                                                        && ($oVariationWert0->fAufpreisNetto != 0 || $oVariationWert1->fAufpreisNetto != 0)}
                                                        {if !isset($oVariationWert1->fAufpreis[1])}
                                                            {assign var=ovw1 value=0}
                                                        {else}
                                                            {assign var=ovw1 value=$oVariationWert1->fAufpreis[1]}
                                                        {/if}
                                                        {if !isset($oVariationWert0->fAufpreis[1])}
                                                            {assign var=ovw0 value=0}
                                                        {else}
                                                            {assign var=ovw0 value=$oVariationWert0->fAufpreis[1]}
                                                        {/if}

                                                        {math equation='x+y' x=$ovw0 y=$ovw1 assign='fAufpreis'}
                                                        {inputgroupaddon append=true}
                                                            {inputgrouptext}
                                                                &times; {gibPreisStringLocalizedSmarty bAufpreise=false fAufpreisNetto=$fAufpreis fVKNetto=$Artikel->Preise->fVKNetto kSteuerklasse=$Artikel->kSteuerklasse nNettoPreise=$NettoPreise fVPEWert=$Artikel->fVPEWert cVPEEinheit=$Artikel->cVPEEinheit FunktionsAttribute=$Artikel->FunktionsAttribute}&nbsp;<span class="footnote-reference">*</span>
                                                            {/inputgrouptext}
                                                        {/inputgroupaddon}
                                                    {/if}
                                                {/inputgroup}
                                                {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                    <div>
                                                        <small>
                                                            {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                        </small>
                                                    </div>
                                                {/if}
                                                <div class="delivery-status">
                                                    <small>
                                                        {if $Artikel->nIstVater == 1}
                                                            {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                                {block name='productdetails-matrix-classic-include-stock-status-2-dimesional-3'}
                                                                    {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                                {/block}
                                                            {else}
                                                                {if $anzeige === 'verfuegbarkeit'
                                                                    || $anzeige === 'genau'
                                                                    && ((isset($child->fLagerbestand)
                                                                            && $child->fLagerbestand > 0)
                                                                        || (isset($child->cLagerKleinerNull)
                                                                            && $child->cLagerKleinerNull === 'Y'))}
                                                                    <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                                {elseif $anzeige === 'ampel'
                                                                    && ((isset($child->fLagerbestand)
                                                                            && $child->fLagerbestand > 0)
                                                                        || (isset($child->cLagerKleinerNull)
                                                                            && $child->cLagerKleinerNull === 'Y'))}
                                                                    <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                                {/if}
                                                            {/if}
                                                        {/if}
                                                    </small>
                                                </div>
                                            {/if}
                                        </td>
                                    {else}
                                        <td class="not-available">&nbsp;</td>
                                    {/if}
                                {/foreach}
                            </tr>
                        {/foreach}
                    {/if}
                    </tbody>
                {/block}
            {else}{* ****** 1-dimensional ****** *}
                {block name='productdetails-matrix-classic-1-dimensional'}
                {if $Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_anzeigeformat === 'Q'
                    && $Artikel->VariationenOhneFreifeld[0]->Werte|count <= 10}
                    {block name='productdetails-matrix-classic-1-dimensional-quer'}
                        {* QUERFORMAT *}
                        <thead>
                        <tr>
                            {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWertHead}
                                {if $Einstellungen.global.artikeldetails_variationswertlager != 3
                                    || (!isset($oVariationWertHead->nNichtLieferbar)
                                        || $oVariationWertHead->nNichtLieferbar != 1)}
                                    {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                                    <td class="text-center-util">
                                        {if $Artikel->oVariBoxMatrixBild_arr|@count > 0}
                                            {foreach $Artikel->oVariBoxMatrixBild_arr as $oVariBoxMatrixBild}
                                                {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                                    {image src=$oVariBoxMatrixBild->cBild fluid=true lazy=true alt=$oVariationWertHead->cName}<br>
                                                {/if}
                                            {/foreach}
                                        {/if}
                                        <strong>{$oVariationWertHead->cName}</strong>
                                    </td>
                                {/if}
                            {/foreach}
                        </tr>
                        <thead>
                        <tbody>
                        <tr>
                            {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWertHead}
                                {if $Einstellungen.global.artikeldetails_variationswertlager != 3
                                    || !isset($oVariationWertHead->nNichtLieferbar)
                                    || $oVariationWertHead->nNichtLieferbar != 1}
                                    {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                                    {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                                        {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
                                    {/if}
                                    <td class="text-center-util">
                                        {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N'
                                            && isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                            <small>
                                                {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        {elseif isset($oVariationWertHead->nNichtLieferbar)
                                            && $oVariationWertHead->nNichtLieferbar == 1}
                                            {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                <small>
                                                    {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                </small>
                                            {else}
                                                {if !empty($child)}
                                                    {block name='productdetails-matrix-classic-include-stock-status-1-dimesional-quer-1'}
                                                        {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                    {/block}
                                                {else}
                                                    {$outofstockInfo}
                                                {/if}
                                            {/if}
                                        {elseif (isset($child->bHasKonfig)
                                            && $child->bHasKonfig == true)
                                            || (isset($child->nVariationAnzahl)
                                                && isset($child->nVariationOhneFreifeldAnzahl)
                                                && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                            {link href=$child->cSeo title="{lang key='configure'} {$oVariationWertHead->cName}" class="btn btn-primary configurepos"}
                                                <i class="fa fa-cogs"></i>
                                                <span>{lang key='configure'}</span>
                                            {/link}
                                            {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                <small>
                                                    {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                </small>
                                            {/if}
                                            <div class="delivery-status">
                                                <small>
                                                    {if !$child->nErscheinendesProdukt}
                                                        {block name='productdetails-matrix-classic-include-stock-status-1-dimesional-quer-2'}
                                                            {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                        {/block}
                                                    {else}
                                                        {if $anzeige === 'verfuegbarkeit'
                                                            || $anzeige === 'genau'
                                                            && ($child->fLagerbestand > 0
                                                                || $child->cLagerKleinerNull === 'Y')}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                        {elseif $anzeige === 'ampel'
                                                            && ($child->fLagerbestand > 0
                                                                || $child->cLagerKleinerNull === 'Y')}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                        {/if}
                                                    {/if}
                                                </small>
                                            </div>
                                        {else}
                                            {inputgroup class="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError}has-error{/if}"}
                                                {input class="text-right-util{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError} bg-danger{/if}"
                                                    placeholder="0"
                                                    name="variBoxAnzahl[_{$oVariationWertHead->kEigenschaft}:{$oVariationWertHead->kEigenschaftWert}]"
                                                    aria=["label"=>"{lang key='quantity'} {$oVariationWertHead->cName}"]
                                                    type="text"
                                                    value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}"}
                                                {if $Artikel->nVariationAnzahl == 1 && ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
                                                    {assign var=kEigenschaftWert value=$oVariationWertHead->kEigenschaftWert}
                                                    {inputgroupaddon append=true}
                                                        {inputgrouptext}&times; {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]) && !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}){/if}</small>{/inputgrouptext}
                                                    {/inputgroupaddon}
                                                {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationWertHead->fAufpreisNetto != 0}
                                                    {inputgroupaddon append=true}
                                                        {inputgrouptext}{$oVariationWertHead->cAufpreisLocalized[$NettoPreise]}{if !empty($oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise]})</small>{/if}{/inputgrouptext}
                                                    {/inputgroupaddon}
                                                {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationWertHead->fAufpreisNetto != 0}
                                                    {inputgroupaddon append=true}
                                                        {inputgrouptext}&times; {$oVariationWertHead->cPreisInklAufpreis[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}{/inputgrouptext}
                                                    {/inputgroupaddon}
                                                {/if}
                                            {/inputgroup}
                                            {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                <div>
                                                    <small>
                                                        {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                    </small>
                                                </div>
                                            {/if}
                                            <div class="delivery-status">
                                                <small>
                                                    {if $Artikel->nIstVater == 1}
                                                        {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                            {block name='productdetails-matrix-classic-include-stock-status-1-dimesional-quer-3'}
                                                                {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                            {/block}
                                                        {else}
                                                            {if $anzeige === 'verfuegbarkeit'
                                                                || $anzeige === 'genau'
                                                                && ($child->fLagerbestand > 0
                                                                    || $child->cLagerKleinerNull === 'Y')}
                                                                <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                            {elseif $anzeige === 'ampel'
                                                                && ((isset($child->fLagerbestand)
                                                                        && $child->fLagerbestand > 0)
                                                                    || (isset($child->cLagerKleinerNull)
                                                                        && $child->cLagerKleinerNull === 'Y'))}
                                                                <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                            {/if}
                                                        {/if}
                                                    {/if}
                                                </small>
                                            </div>
                                        {/if}
                                    </td>
                                {/if}
                            {/foreach}
                        </tr>
                        </tbody>
                    {/block}
                {else}
                    {block name='productdetails-matrix-classic-1-dimensional-hoch'}
                        {* HOCHFORMAT *}
                        <tbody>
                        {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWertHead}
                            {if $Einstellungen.global.artikeldetails_variationswertlager != 3
                                || (!isset($oVariationWertHead->nNichtLieferbar)
                                    || $oVariationWertHead->nNichtLieferbar != 1)}
                                {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                                {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                                    {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
                                {/if}
                                <tr>
                                    <td class="text-center-util">
                                        {if $Artikel->oVariBoxMatrixBild_arr|@count > 0}
                                            {foreach $Artikel->oVariBoxMatrixBild_arr as $oVariBoxMatrixBild}
                                                {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                                    {image src=$oVariBoxMatrixBild->cBild fluid=true lazy=true alt=$oVariationWertHead->cName}<br>
                                                {/if}
                                            {/foreach}
                                        {/if}
                                        <strong> {$oVariationWertHead->cName}</strong>
                                    </td>
                                    <td class="form-inline">
                                        {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N'
                                            && isset($child->nErscheinendesProdukt)
                                            && $child->nErscheinendesProdukt == 1}
                                            <small>
                                                {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        {elseif isset($oVariationWertHead->nNichtLieferbar) && $oVariationWertHead->nNichtLieferbar == 1}
                                            {if !empty($child)}
                                                {block name='productdetails-matrix-classic-include-stock-status-1-dimesional-hoch-1'}
                                                    {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                {/block}
                                            {else}
                                                {$outofstockInfo}
                                            {/if}
                                        {elseif (isset($child->bHasKonfig)
                                                && $child->bHasKonfig == true)
                                            || (isset($child->nVariationAnzahl)
                                                && isset($child->nVariationOhneFreifeldAnzahl)
                                                && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                            {link href=$child->cSeo title="{lang key='configure'} {$oVariationWertHead->cName}" class="btn btn-primary configurepos"}
                                                <i class="fa fa-cogs"></i>
                                                <span>{lang key='configure'}</span>
                                            {/link}
                                            {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                <div>
                                                    <small>
                                                        {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                    </small>
                                                </div>
                                            {/if}
                                            <div class="delivery-status">
                                                <small>
                                                    {if !$child->nErscheinendesProdukt}
                                                        {block name='productdetails-matrix-classic-include-stock-status-1-dimesional-hoch-2'}
                                                            {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                        {/block}
                                                    {else}
                                                        {if $anzeige === 'verfuegbarkeit'
                                                            || $anzeige === 'genau'
                                                            && ($child->fLagerbestand > 0
                                                                || $child->cLagerKleinerNull === 'Y')}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                        {elseif $anzeige === 'ampel'
                                                            && ((isset($child->fLagerbestand)
                                                                    && $child->fLagerbestand > 0)
                                                                || (isset($child->cLagerKleinerNull)
                                                                    && $child->cLagerKleinerNull === 'Y'))}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                        {/if}
                                                    {/if}
                                                </small>
                                            </div>
                                        {else}
                                            {inputgroup class="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError}has-error{/if}"}
                                                {input
                                                    class="text-right-util" placeholder="0"
                                                    name="variBoxAnzahl[_{$oVariationWertHead->kEigenschaft}:{$oVariationWertHead->kEigenschaftWert}]"
                                                    aria=["label"=>"{lang key='quantity'} {$oVariationWertHead->cName}"]
                                                    type="text"
                                                    value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}"}
                                                {if $Artikel->nVariationAnzahl == 1 && ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
                                                    {assign var=kEigenschaftWert value=$oVariationWertHead->kEigenschaftWert}
                                                    {inputgroupaddon append=true}
                                                        {inputgrouptext}
                                                            &times; {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]) && !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                                        {/inputgrouptext}
                                                    {/inputgroupaddon}
                                                {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationWertHead->fAufpreisNetto!=0}
                                                    {inputgroupaddon append=true}
                                                        {inputgrouptext}
                                                            {$oVariationWertHead->cAufpreisLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise]})</small>{/if}
                                                        {/inputgrouptext}
                                                    {/inputgroupaddon}
                                                {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationWertHead->fAufpreisNetto!=0}
                                                    {inputgroupaddon append=true}
                                                        {inputgrouptext}
                                                            &times; {$oVariationWertHead->cPreisInklAufpreis[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                                        {/inputgrouptext}
                                                    {/inputgroupaddon}
                                                {/if}
                                            {/inputgroup}
                                            {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                                <div>
                                                    <small>
                                                        {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                    </small>
                                                </div>
                                            {/if}
                                            <div class="delivery-status">
                                                <small>
                                                    {if $Artikel->nIstVater == 1}
                                                        {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                            {block name='productdetails-matrix-classic-include-stock-status-1-dimesional-hoch-3'}
                                                                {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                            {/block}
                                                        {else}
                                                            {if $anzeige === 'verfuegbarkeit'
                                                                || $anzeige === 'genau'
                                                                && ((isset($child->fLagerbestand)
                                                                        && $child->fLagerbestand > 0)
                                                                    || (isset($child->cLagerKleinerNull)
                                                                        && $child->cLagerKleinerNull === 'Y'))}
                                                                <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                            {elseif $anzeige === 'ampel'
                                                                && ((isset($child->fLagerbestand)
                                                                        && $child->fLagerbestand > 0)
                                                                    || (isset($child->cLagerKleinerNull)
                                                                        && $child->cLagerKleinerNull === 'Y'))}
                                                                <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                            {/if}
                                                        {/if}
                                                    {/if}
                                                </small>
                                            </div>
                                        {/if}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                        </tbody>
                    {/block}
                {/if}
                {/block}
            {/if}
        </table>
    </div>
    {/block}
    {block name='productdetails-matrix-classic-submit'}
        {input type="hidden" name="variBox" value="1"}
        {row class="product-matrix-submit"}
            {col cols=12 md=4 lg=3}
                {button name="inWarenkorb"
                    type="submit"
                    value="{lang key='addToCart'}"
                    variant="primary"
                    block=true}
                    <span class="btn-basket-check">
                        <span>
                            {lang key='addToCart'}
                        </span> <i class="fas fa-shopping-cart"></i>
                    </span>
                {/button}
            {/col}
        {/row}
    {/block}
{/block}
