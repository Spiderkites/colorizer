{block name='register-form'}
    {form action="{get_static_route id='registrieren.php'}" class="jtl-validate register-form clearfix" slide=true}
        {block name='register-form-content'}
            {block name='register-form-include-customer-account'}
                {include file='register/form/customer_account.tpl'}
            {/block}
            {block name='register-form-hr'}
                <hr>
            {/block}
            {if isset($checkout) && $checkout === 1}
                {block name='register-form-include-inc-shipping-address'}
                    {include file='checkout/inc_shipping_address.tpl'}
                {/block}
            {/if}
            {block name='register-form-submit'}
                {row class="checkout-button-row"}
                    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
                    {col cols=12 class="checkout-register-form-buttons-privacy"}
                        {block name='register-form-submit-privacy'}
                            {link href=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL() class="popup"}
                                {lang key='privacyNotice'}
                            {/link}
                        {/block}
                    {/col}
                    {/if}
                    {col cols=12 md=4 xl=3 class="checkout-button-row-submit"}
                        {input type="hidden" name="checkout" value=$checkout|default:''}
                        {input type="hidden" name="form" value="1"}
                        {input type="hidden" name="editRechnungsadresse" value=$editRechnungsadresse}
                        {opcMountPoint id='opc_before_submit'}
                        {block name='register-form-submit-button'}
                            {button type="submit" value="1" variant="primary" class="submit_once" block=true}
                                {lang key='sendCustomerData' section='account data'}
                            {/button}
                        {/block}
                    {/col}
                {/row}
            {/block}
        {/block}
    {/form}
{/block}
