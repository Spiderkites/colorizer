{block name='productdetails-product-images-modal'}
<div class="modal modal-fullview fade" id="productImagesModal" tabindex="-1" role="dialog" aria-labelledby="productImagesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            {block name='productdetails-product-images-modal-header'}
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" class="fas fa-times"></span>
                    </button>
                </div>
            {/block}
            {block name='productdetails-product-images-modal-body'}
                <div class="modal-body">
                    {foreach $images as $image}
                        {block name='productdetails-product-images-modal-image'}
                            <div class="square square-image">
                                <div class="inner">
                                    {image alt=$image->cAltAttribut
                                        class="product-image"
                                        fluid=true
                                        lazy=true
                                        webp=true
                                        src="{$Artikel->Bilder[0]->cURLNormal}"
                                        srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
                                                            {$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
                                                            {$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w,
                                                            {$image->cURLGross} {$Einstellungen.bilder.bilder_artikel_gross_breite}w"
                                        sizes="auto"
                                        data=["list"=>"{$image->galleryJSON|escape:"html"}", "index"=>$image@index]
                                    }
                                </div>
                            </div>
                        {/block}
                    {/foreach}
                </div>
            {/block}
        </div>
    </div>
</div>
{/block}
