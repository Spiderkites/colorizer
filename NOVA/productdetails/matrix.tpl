{block name='productdetails-matrix'}
    {if $showMatrix}
        <div class="product-matrix clearfix">
            <div class="product-matrix-title">
                {lang key='productMatrixTitle' section='productDetails'}
            </div>
            <p class="product-matrix-desc">
                {lang key='productMatrixDesc' section='productDetails'}
            </p>
            {if $Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_anzeigeformat === 'L' && $Artikel->nIstVater == 1 && $Artikel->oVariationKombiKinderAssoc_arr|count > 0}
                {block name='productdetails-index-include-matrix-list'}
                    <div class="matrix-list-wrapper">
                        {include file='productdetails/matrix_list.tpl'}
                    </div>
                {/block}
            {else}
                {block name='productdetails-index-include-matrix-classic'}
                    <div class="matrix-classic-wrapper">
                        {include file='productdetails/matrix_classic.tpl'}
                    </div>
                {/block}
            {/if}
         </div>
    {/if}
{/block}
