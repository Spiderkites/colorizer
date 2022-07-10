{block name='snippets-stock-status'}
    {assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
    {if $anzeige !== 'nichts'
        && ($currentProduct->cLagerKleinerNull === 'N'
            || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')
        && $currentProduct->getBackorderString() !== ''
        && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N'}
        {block name='snippets-stock-status-in-flowing'}
            <span class="status status-1">{$currentProduct->getBackorderString()}</span>
        {/block}
    {elseif $anzeige !== 'nichts'
        && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N'
        && $currentProduct->cLagerBeachten === 'Y'
        && $currentProduct->fLagerbestand <= 0
        && $currentProduct->fLieferantenlagerbestand > 0
        && $currentProduct->fLieferzeit > 0
        && ($currentProduct->cLagerKleinerNull === 'N'
            && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'I'
            || $currentProduct->cLagerKleinerNull === 'Y'
            && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
        {block name='snippets-stock-status-supllier-stock-notice'}
            <span class="status status-1">{lang key='supplierStockNotice' printf=$currentProduct->fLieferzeit}</span>
        {/block}
    {elseif $anzeige === 'verfuegbarkeit'
        || $anzeige === 'genau'}
        {block name='snippets-stock-status-exact'}
            <span class="status status-{$currentProduct->Lageranzeige->nStatus}">
                <span class="fas fa-truck status-icon"></span>{$currentProduct->Lageranzeige->cLagerhinweis[$anzeige]}
            </span>
        {/block}
    {elseif $anzeige === 'ampel'}
        {block name='snippets-stock-status-traffic-light'}
            <span class="status status-{$currentProduct->Lageranzeige->nStatus}">
                <span class="fas fa-truck status-icon"></span>{$currentProduct->Lageranzeige->AmpelText}
            </span>
        {/block}
    {/if}
{/block}
