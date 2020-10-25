{extends file="{$parent_template_path}/productlist/item_box.tpl"}
{block name="productlist-delivery-status"}
    <div class="delivery-status">
        {assign var=anzeige value=$Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandsanzeige}
        {if $Artikel->nErscheinendesProdukt}
            <div class="availablefrom">
                <small>{lang key="productAvailable" section="global"}: {$Artikel->Erscheinungsdatum_de}</small>
            </div>
            {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar === 1}
                <div class="attr attr-preorder"><small class="value">{lang key="preorderPossible" section="global"}</small></div>
            {/if}
        {elseif $anzeige !== 'nichts' &&
            $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen !== 'N' &&
            $Artikel->cLagerBeachten === 'Y' && ($Artikel->cLagerKleinerNull === 'N' ||
            $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen === 'U') &&
            $Artikel->fLagerbestand <= 0 && $Artikel->fZulauf > 0 && isset($Artikel->dZulaufDatum_de)}
            {assign var=cZulauf value=$Artikel->fZulauf|cat:':::'|cat:$Artikel->dZulaufDatum_de}
            <div class="signal_image status-0"><small>{$Artikel->Lageranzeige->cLagerhinweis['genau']}</small></div>
        {elseif $anzeige !== 'nichts' &&
            $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen !== 'N' &&
            $Artikel->cLagerBeachten === 'Y' && $Artikel->fLagerbestand <= 0 &&
            $Artikel->fLieferantenlagerbestand > 0 && $Artikel->fLieferzeit > 0 &&
            ($Artikel->cLagerKleinerNull === 'N' ||
            $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen === 'U')}
            <div class="signal_image status-1"><small>{lang key="supplierStockNotice" section="global" printf=$Artikel->fLieferzeit}</small></div>
        {elseif $anzeige === 'verfuegbarkeit' || $anzeige === 'genau'}
            <div class="signal_image status-{$Artikel->Lageranzeige->nStatus}"><small>{$Artikel->Lageranzeige->cLagerhinweis[$anzeige]}</small></div>
        {elseif $anzeige === 'ampel'}
            <div class="signal_image status-{$Artikel->Lageranzeige->nStatus}"><small>{$Artikel->Lageranzeige->AmpelText}</small></div>
        {/if}
        {if $Artikel->cEstimatedDelivery}
            <div class="estimated_delivery hidden-xs">
                <small>{lang key="shippingTime" section="global"}: {$Artikel->cEstimatedDelivery}</small>
            </div>
        {/if}
    </div>
{/block}
       