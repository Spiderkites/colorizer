{block name='productdetails-image'}
    <div id="image_wrapper" class="gallery-with-action" role="group">
        {row class="gallery-with-action-main"}
        {block name='productdetails-image-button'}
            {col cols=12 class="product-detail-image-topbar"}
                {button id="image_fullscreen_close" variant="link" aria=["label"=>"close"]}
                    <span aria-hidden="true"><i class="fa fa-times"></i></span>
                {/button}
            {/col}
        {/block}
        {block name='productdetails-image-main'}
            {col cols=12}
            {if !($Artikel->nIstVater && $Artikel->kVaterArtikel == 0)}
                {block name='productdetails-image-actions'}
                    <div class="product-actions" data-toggle="product-actions">
                        {if $Einstellungen.artikeldetails.artikeldetails_vergleichsliste_anzeigen === 'Y'
                            && $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
                            {block name='productdetails-image-include-comparelist-button'}
                                {include file='snippets/comparelist_button.tpl'}
                            {/block}
                        {/if}
                        {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
                            {block name='productdetails-image-include-wishlist-button'}
                                {include file='snippets/wishlist_button.tpl'}
                            {/block}
                        {/if}
                    </div>
                {/block}
            {/if}
            {block name='productdetails-image-images-wrapper'}
                <div id="gallery_wrapper" class="clearfix">
                    <div id="gallery"
                         class="product-images slick-smooth-loading carousel slick-lazy"
                         data-slick-type="gallery">
                        {block name='productdetails-image-images'}
                            {foreach $Artikel->Bilder as $image}
                                {strip}
                                    <div class="square square-image js-gallery-images {if !$image@first}d-none{/if}">
                                        <div class="inner">
                                            {image alt=$image->cAltAttribut
                                                class="product-image"
                                                fluid=true
                                                lazy=true
                                                webp=true
                                                src="{$image->cURLMini}"
                                                srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
                                                    {$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
                                                    {$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w,
                                                    {$image->cURLGross} {$Einstellungen.bilder.bilder_artikel_gross_breite}w"
                                                data=["list"=>"{$image->galleryJSON|escape:"html"}", "index"=>$image@index, "sizes"=>"auto"]
                                            }
                                        </div>
                                    </div>
                                {/strip}
                            {/foreach}
                        {/block}
                    </div>
                    {if $Artikel->Bilder|count > 1}
                        <ul class="slick-dots initial-slick-dots d-lg-none" style="" role="tablist">
                            {foreach $Artikel->Bilder as $image}
                                <li class="{if $image@first}slick-active{/if}" role="presentation">
                                    {button}{/button}
                                </li>
                            {/foreach}
                        </ul>
                    {/if}
                </div>
            {/block}
            {/col}
        {/block}
        {block name='productdetails-image-preview'}
            {col cols=12 align-self='end' class='product-detail-image-preview-bar'}
            {$imageCount = $Artikel->Bilder|@count}
            {$imageCountDefault = 5}
            {if $imageCount > 1}
                <div id="gallery_preview_wrapper" class="product-thumbnails-wrapper">
                    <div id="gallery_preview"
                         class="product-thumbnails slick-smooth-loading carousel carousel-thumbnails slick-lazy {if $imageCount <= $imageCountDefault}slick-count-default{/if}"
                         data-slick-type="gallery_preview">
                        {if $imageCount > $imageCountDefault}
                            <button class="slick-prev slick-arrow slick-inital-arrow" aria-label="Previous" type="button" style="">Previous</button>
                        {/if}
                        {block name='productdetails-image-preview-images'}
                            {foreach $Artikel->Bilder as $image}
                                {strip}
                                <div class="square square-image js-gallery-images
                                    {if $image@first} preview-first {if $imageCount <= $imageCountDefault} first-ml{/if}
                                    {elseif $image@index >= $imageCountDefault} d-none{/if}
                                    {if $image@last && $imageCount <= $imageCountDefault} last-mr{/if}">
                                    <div class="inner">
                                        {image alt=$image->cAltAttribut
                                            class="product-image"
                                            fluid=true
                                            lazy=true
                                            webp=true
                                            src="{$image->cURLKlein}"
                                        }
                                    </div>
                                </div>
                                {/strip}
                            {/foreach}
                        {/block}
                        {if $imageCount > $imageCountDefault}
                            <button class="slick-next slick-arrow slick-inital-arrow" aria-label="Next" type="button" style="">Next</button>
                        {/if}
                    </div>
                </div>
            {/if}
            {/col}
        {/block}
        {/row}
        {block name='productdetails-image-meta'}
            {foreach $Artikel->Bilder as $image}
                <meta itemprop="image" content="{$image->cURLNormal}">
            {/foreach}
        {/block}

        {block name='productdetails-image-include-product-images-modal'}
            {include file='productdetails/product_images_modal.tpl' images=$Artikel->Bilder}
        {/block}

        {block name='productdetails-image-variation-preview'}
            {if !$isMobile && isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0}
                {assign var=VariationsSource value='Variationen'}
                {if isset($ohneFreifeld) && $ohneFreifeld}
                    {assign var=VariationsSource value='VariationenOhneFreifeld'}
                {/if}
                {foreach name=Variationen from=$Artikel->$VariationsSource key=i item=Variation}
                    {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                        {if $Variationswert->getImage() !== null}
                            {block name='productdetails-image-variation-preview-inner'}
                                <div class="variation-image-preview d-none fade vt{$Variationswert->kEigenschaftWert}">
                                    {block name='productdetails-image-variation-preview-title'}
                                        {if $Variation->cTyp === 'IMGSWATCHES'}
                                            <div class="variation-image-preview-title">
                                                {$Variation->cName}: <span class="variation-image-preview-title-value">{$Variationswert->cName}</span>
                                            </div>
                                        {/if}
                                    {/block}
                                    {block name='productdetails-image-variation-preview-image'}
                                        {include file='snippets/image.tpl' item=$Variationswert sizes='100vw'}
                                    {/block}
                                </div>
                            {/block}
                        {/if}
                    {/foreach}
                {/foreach}
            {/if}
        {/block}
    </div>
{/block}
