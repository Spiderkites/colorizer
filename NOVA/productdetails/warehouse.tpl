{* nur anzeigen, wenn >1 Warenlager aktiv und Artikel ist auf Lager/im Zulauf/Ueberverkaeufe erlaubt/beachtet kein Lager *}
{block name='productdetails-warehouse'}
    {assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
    {if $anzeige !== 'nichts'
        && isset($Artikel->oWarenlager_arr)
        && $Artikel->oWarenlager_arr|@count > 1
        && ($Artikel->cLagerBeachten !== 'Y'
            || $Artikel->cLagerKleinerNull === 'Y'
            || $Artikel->fLagerbestand > 0
            || $Artikel->fZulauf > 0)}
        {block name='productdetails-warehouse-detail-link'}
            {row no-gutters=true class="product-stock-info row"}
                {col}
                    {button class="product-stock-info-button" variant="link" data=["toggle"=>"modal", "target"=>"#warehouseAvailability"]}
                        <span class="fas fa-map-marker-alt icon-mr-2"></span>{lang key='warehouseAvailability'}
                    {/button}
                {/col}
            {/row}
        {/block}
        {block name='productdetails-warehouse-modal'}
            {modal id="warehouseAvailability"
                title="{lang key='warehouseAvailability'}"
                centered=true
                size="lg"
                class="fade"}
                {block name='productdetails-warehouse-modal-content'}
                    {block name='productdetails-warehouse-modal-content-header'}
                        {row class="warehouse-row"}
                            {col}
                                <strong>{lang key='warehouse'}</strong>
                            {/col}
                            {col class="warehouse-right"}
                                <strong>{lang key='status'}</strong>
                            {/col}
                        {/row}
                        <hr>
                    {/block}
                    {block name='productdetails-warehouse-modal-content-items'}
                        {foreach $Artikel->oWarenlager_arr as $oWarenlager}
                            {row class="warehouse-row"}
                                {col}
                                    <strong>{$oWarenlager->getName()}</strong>
                                {/col}
                                {col class="warehouse-right"}
                                    <span class="signal_image">
                                         {if $anzeige !== 'nichts'
                                         && $oWarenlager->getBackorderString($Artikel) !== ''
                                         && ($Artikel->cLagerKleinerNull === 'N'
                                            || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                                             <span class="status-1">{$oWarenlager->getBackorderString($Artikel)}</span>
                                        {elseif $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N'
                                             && $Artikel->cLagerBeachten === 'Y'
                                             && $Artikel->fLagerbestand <= 0
                                             && $Artikel->fLieferantenlagerbestand > 0
                                             && $Artikel->fLieferzeit > 0
                                             && ($Artikel->cLagerKleinerNull === 'N'
                                                 && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'I'
                                                 || $Artikel->cLagerKleinerNull === 'Y'
                                                 && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                                             <span class="status-1">{lang key='supplierStockNotice' printf=$Artikel->fLieferzeit}</span>
                                        {elseif $anzeige === 'verfuegbarkeit' || $anzeige === 'genau'}
                                            <span class="status-{$oWarenlager->oLageranzeige->nStatus}">{$oWarenlager->oLageranzeige->cLagerhinweis[$anzeige]}</span>
                                        {elseif $anzeige === 'ampel'}
                                            <span class="status-{$oWarenlager->oLageranzeige->nStatus}">{$oWarenlager->oLageranzeige->AmpelText}</span>
                                         {/if}
                                    </span>
                                {/col}
                            {/row}
                            <hr>
                        {/foreach}
                    {/block}
                {/block}
            {/modal}
        {/block}
    {/if}
{/block}
