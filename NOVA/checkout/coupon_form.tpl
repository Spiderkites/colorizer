{block name='checkout-coupon-form'}
    {if $KuponMoeglich == 1}
        {form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form jtl-validate coupon-form" slide=true}
            {block name='checkout-coupon-form-form-content'}
                {input type="hidden" name="pruefekupon" value="1"}
                <fieldset>
                    {row}
                        {col cols=12}
                            {block name='checkout-coupon-form-desc'}
                                <p class="credit-description">{lang key='couponFormDesc' section='checkout'}</p>
                            {/block}
                        {/col}
                        {col cols=12}
                            {block name='checkout-coupon-form-btn'}
                                {inputgroup}
                                    {input type="text"
                                        name="Kuponcode"
                                        maxlength="32"
                                        value="{if !empty($Kuponcode)}{$Kuponcode}{/if}"
                                        id="kupon"
                                        placeholder="{lang key='couponCodePlaceholder' section='checkout'}"
                                        aria=["label"=>"{lang key='couponCode' section='account data'}"]
                                        required=true}
                                    {inputgroupaddon append=true}
                                        {button type="submit" value="1" variant="outline-primary"}{lang key='couponSubmit' section='checkout'}{/button}
                                    {/inputgroupaddon}
                                {/inputgroup}
                            {/block}
                        {/col}
                    {/row}
                </fieldset>
            {/block}
        {/form}
    {/if}
{/block}
