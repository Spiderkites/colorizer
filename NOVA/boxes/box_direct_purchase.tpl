{block name='boxes-box-direct-purchase'}
    <div class="box box-direct-purchase box-normal" id="sidebox{$oBox->getID()}">
        {block name='boxes-box-direct-purchase-title'}
            <div class="productlist-filter-headline">
                {lang key='quickBuy'}
            </div>
        {/block}
        {block name='boxes-box-direct-purchase-form'}
            <div class="box-content-wrapper">
            {form action="{get_static_route id='warenkorb.php'}" method="post" slide=true}
                {input type="hidden" name="schnellkauf" value="1"}
                {inputgroup}
                    {input aria=["label"=>"{lang key='quickBuy'}"] type="text" placeholder="{lang key='productNoEAN'}"
                           name="ean" id="quick-purchase"}
                    {inputgroupaddon append=true}
                        {button type="submit" variant="secondary" title="{lang key='intoBasket'}"}
                            <span class="fas fa-shopping-cart"></span>
                        {/button}
                    {/inputgroupaddon}
                {/inputgroup}
            {/form}
            </div>
        {/block}
        {block name='boxes-box-direct-purchase-hr-end'}
            <hr class="box-normal-hr">
        {/block}
    </div>
{/block}
