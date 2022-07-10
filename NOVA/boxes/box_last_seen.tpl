{block name='boxes-box-last-seen'}
    {lang key='lastViewed' assign='boxtitle'}
    <div class="box box-last-seen box-normal" id="sidebox{$oBox->getID()}">
        {block name='boxes-box-last-seen-content'}
            {block name='boxes-box-last-seen-title'}
                <div class="productlist-filter-headline">
                    {$boxtitle}
                </div>
            {/block}
            {block name='boxes-box-last-seen-content'}
            <div class="box-content-wrapper">
            {foreach $oBox->getProducts() as $product}
                <div class="box-last-seen-item">
                    {block name='boxes-box-last-seen-image-link'}
                        <div class="productbox productbox-row productbox-sidebar">
                            <div class="productbox-inner">
                                {formrow}
                                    {col md=4 lg=6 xl=3}
                                        {link class="image-wrapper" href=$product->cURLFull}
                                            {include file='snippets/image.tpl' item=$product srcSize='sm'}
                                        {/link}
                                    {/col}
                                    {col class="col-md"}
                                        {link class="productbox-title" href=$product->cURLFull}
                                            {$product->cKurzbezeichnung}
                                        {/link}
                                        {include file='productdetails/price.tpl' Artikel=$product tplscope='box'}
                                    {/col}
                                {/formrow}
                            </div>
                        </div>
                    {/block}
                </div>
            {/foreach}
            </div>
            {/block}
            {block name='boxes-box-last-seen-hr-end'}
                <hr class="box-normal-hr">
            {/block}
        {/block}
    </div>
{/block}
