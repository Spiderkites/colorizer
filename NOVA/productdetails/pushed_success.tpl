{block name='productdetails-pushed-success'}
    <div id="pushed-success" {if $card}role="alert" class="card alert alert-dismissable"{/if}>
        {if isset($zuletztInWarenkorbGelegterArtikel)}
            {assign var=pushedArtikel value=$zuletztInWarenkorbGelegterArtikel}
        {else}
            {assign var=pushedArtikel value=$Artikel}
        {/if}
        {assign var=showXSellingCart value=isset($Xselling->Kauf) && count($Xselling->Kauf->Artikel) > 0}
        {if $card}
            {block name='productdetails-pushed-success-cart-note-heading'}
                <div class="card-header alert-success">
                    {if isset($cartNote)}
                        {$cartNote}
                    {/if}
                </div>
            {/block}
            <div class="card-body">
        {/if}

        {row}
            {block name='productdetails-pushed-success-product-cell'}
                {col cols=12 md="{if $showXSellingCart}6{else}12{/if}"}
                    {block name='productdetails-pushed-success-product-cell-content'}
                        <div class="productbox-inner{if isset($class)} {$class}{/if}">
                            {row}
                                {col cols=12}
                                    {block name='productdetails-pushed-success-product-cell-subheading'}
                                        <div class="productbox-title subheadline">{$pushedArtikel->cName}</div>
                                    {/block}
                                {/col}
                                {col cols=12 md=4 class="pushed-success-image-wrapper"}
                                    {block name='productdetails-pushed-success-product-cell-image'}
                                        {include file='snippets/image.tpl'
                                            item=$pushedArtikel
                                            square=false
                                            class='image'
                                            srcSize='sm'}
                                    {/block}
                                {/col}
                                {col}
                                    {block name='productdetails-pushed-success-product-cell-details'}
                                        {row}
                                            {col cols=12}
                                                <dl class="form-row">
                                                    <dt class="col-6">{lang key='productNo'}:</dt>
                                                    <dd class="col-6">{$pushedArtikel->cArtNr}</dd>
                                                    {if !empty($pushedArtikel->cHersteller)}
                                                        <dt class="col-6">{lang key='manufacturer' section='productDetails'}:</dt>
                                                        <dd class="col-6">{$pushedArtikel->cHersteller}</dd>
                                                    {/if}
                                                    {if !empty($pushedArtikel->oMerkmale_arr)}
                                                        <dt class="col-6">{lang key='characteristics' section='comparelist'}:</dt>
                                                        <dd class="col-6 attr-characteristic">
                                                            {block name='productdetails-pushed-success-characteristics'}
                                                                {foreach $pushedArtikel->oMerkmale_arr as $oMerkmal}
                                                                    {$oMerkmal->cName}
                                                                    {if $oMerkmal@index === 10 && !$oMerkmal@last}&hellip;{break}{/if}
                                                                    {if !$oMerkmal@last}, {/if}
                                                                {/foreach}
                                                            {/block}
                                                        </dd>
                                                    {/if}
                                                    {if isset($pushedArtikel->dMHD) && isset($pushedArtikel->dMHD_de)}
                                                        <dt class="col-6">{lang key='productMHDTool'}:</dt>
                                                        <dd class="col-6">{$pushedArtikel->dMHD_de}</dd>
                                                    {/if}
                                                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_gewicht_anzeigen === 'Y' && isset($pushedArtikel->cGewicht) && $pushedArtikel->fGewicht > 0}
                                                        <dt class="col-6">{lang key='shippingWeight'}:</dt>
                                                        <dd class="col-6">{$pushedArtikel->cGewicht} {lang key='weightUnit'}</dd>
                                                    {/if}
                                                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_artikelgewicht_anzeigen === 'Y' && isset($pushedArtikel->cArtikelgewicht) && $pushedArtikel->fArtikelgewicht > 0}
                                                        <dt class="col-6">{lang key='productWeight'}:</dt>
                                                        <dd class="col-6">{$pushedArtikel->cArtikelgewicht} {lang key='weightUnit'}</dd>
                                                    {/if}
                                                    {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && (int)$pushedArtikel->fDurchschnittsBewertung !== 0}
                                                        <dt class="col-6">{lang key='ratingAverage'}:</dt>
                                                        <dd class="col-6">
                                                            {block name='productdetails-pushed-success-include-rating'}
                                                                {include file='productdetails/rating.tpl' stars=$pushedArtikel->fDurchschnittsBewertung}
                                                            {/block}
                                                        </dd>
                                                    {/if}
                                                </dl>
                                            {/col}
                                        {/row}
                                    {/block}
                                {/col}
                            {/row}
                        </div>
                    {/block}
                    {block name='productdetails-pushed-success-product-cell-links'}
                        {row class="pushed-success-buttons"}
                            {col cols=12 md=6}
                                {link href=$pushedArtikel->cURLFull
                                    class="btn btn-outline-primary btn-block continue-shopping"
                                    data=["dismiss"=>"{if !$card}modal{else}alert{/if}"]
                                    aria=["label"=>"Close"]}
                                    <i class="fa fa-arrow-circle-right"></i> {lang key='continueShopping' section='checkout'}
                                {/link}
                            {/col}
                            {col cols=12 md=6}
                                {link href="{get_static_route id='warenkorb.php'}"
                                    class="btn btn-primary btn-basket btn-block"}
                                    <i class="fas fa-shopping-cart"></i> {lang key='gotoBasket'}
                                {/link}
                            {/col}
                        {/row}
                    {/block}
                {/col}
            {/block}
            {block name='productdetails-pushed-success-x-sell'}
                {if $showXSellingCart}
                    {col cols=6 class="x-selling"}
                        {row}
                            {col cols=12}
                                {block name='productdetails-pushed-success-x-sell-heading'}
                                    <div class="productbox-title subheadline">{lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails'}</div>
                                {/block}
                            {/col}
                            {col cols=12}
                                {block name='productdetails-pushed-success-include-product-slider'}
                                    {include file='snippets/product_slider.tpl' id='' productlist=$Xselling->Kauf->Artikel title='' tplscope='half'}
                                {/block}
                            {/col}
                        {/row}
                    {/col}
                {/if}
            {/block}
        {/row}
        {if $card}</div>{/if}
    </div>
{/block}
