{block name='productdetails-popups'}
    {assign var=kArtikel value=$Artikel->kArtikel}
    {if $Artikel->kArtikelVariKombi > 0}
        {assign var=kArtikel value=$Artikel->kArtikelVariKombi}
    {/if}
    {if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
        {block name='productdetails-popups-include-question-on-item'}
            {modal id="question-popup-{$kArtikel}" title={lang key='productQuestion' section='productDetails'}}
                {include file='productdetails/question_on_item.tpl' position='popup'}
            {/modal}
        {/block}
    {/if}

    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
        {if !isset($kArtikel)}
            {assign var=kArtikel value=$Artikel->kArtikel}
            {if $Artikel->kArtikelVariKombi > 0}
                {assign var=kArtikel value=$Artikel->kArtikelVariKombi}
            {/if}
        {/if}
        {block name='productdetails-popups-include-pushed'}
            <div id="popupa{$kArtikel}" class="product-popup">
                {include file='productdetails/pushed.tpl' oArtikel=$Artikel fAnzahl=$bWarenkorbAnzahl}
            </div>
        {/block}
    {/if}
    {block name='productdetails-popups-script'}
        {inline_script}<script>
            $(function() {
                {if isset($fehlendeAngaben_benachrichtigung) && count($fehlendeAngaben_benachrichtigung) > 0 && ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3)}
                    show_popup('n{$kArtikel}', '{lang key='requestNotification'}');
                {/if}

                {if isset($fehlendeAngaben_fragezumprodukt) && $fehlendeAngaben_fragezumprodukt|@count > 0 && $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
                    $('#question-popup-{$kArtikel}').modal('show');
                {/if}
            });

            function show_popup(item, title) {
                var html = $('#popup' + item).html();
                if (typeof title === 'undefined' || title.length === 0) {
                    title = $(html).find('h3').text();
                }
                eModal.alert({
                    message: html,
                    title: title
                });
            }
        </script>{/inline_script}
    {/block}
{/block}
