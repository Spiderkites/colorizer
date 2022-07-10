{block name='checkout-step0-login-or-register'}
    {block name='checkout-step0-login-or-register-alert'}
        {if !empty($fehlendeAngaben) && !$alertNote}
            {alert variant="danger"}{lang key='mandatoryFieldNotification' section='errorMessages'}{/alert}
        {/if}
        {if isset($fehlendeAngaben.email_vorhanden) && $fehlendeAngaben.email_vorhanden == 1}
            {alert variant="danger"}{lang key='emailAlreadyExists' section='account data'}{/alert}
        {/if}
        {if isset($fehlendeAngaben.formular_zeit) && $fehlendeAngaben.formular_zeit == 1}
            {alert variant="danger"}{lang key='formToFast' section='account data'}{/alert}
        {/if}
    {/block}
    {row id="register-customer"}
        {col cols=12 id="existing-customer" lg=4 class="checkout-existing-customer"}
            {block name='checkout-step0-login-or-register-form-login'}
                {card class='card-gray'}
                    {form method="post" action="{get_static_route id='bestellvorgang.php'}" class="jtl-validate" id="order_register_or_login" slide=true}
                        {block name='checkout-step0-login-or-register-fieldset-form-login-content'}
                            <fieldset>
                                {block name='checkout-step0-login-or-register-headline-form-login-content'}
                                    <div class="card-title h3">{lang key='alreadyCustomer'}</div>
                                {/block}
                                {block name='checkout-step0-login-or-register-include-customer-login'}
                                    {include file='register/form/customer_login.tpl'}
                                {/block}
                            </fieldset>
                        {/block}
                    {/form}
                {/card}
            {/block}
            {block name='checkout-step0-login-or-hr'}
                <div class="checkout-existing-customer-hr">
                    <div class="hr-sect">{lang key='or'}</div>
                </div>
            {/block}
        {/col}
        {col cols=12 id="customer" lg=8}
            {block name='checkout-step0-login-or-register-form'}
                {form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form checkout-register-form jtl-validate" id="form-register" slide=true}
                    {block name='checkout-step0-login-or-register-include-customer-account'}
                        {include file='register/form/customer_account.tpl' checkout=1 step="formular"}
                        <hr>
                    {/block}
                    {block name='checkout-step0-login-or-register-include-inc-shipping-address'}
                        {include file='checkout/inc_shipping_address.tpl'}
                    {/block}
                    {block name='checkout-step0-login-or-register-form-submit'}
                        {row class="checkout-button-row"}
                            {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
                            {block name='checkout-step0-login-or-register-modal-privacy'}
                                {col cols=12 class="checkout-register-form-buttons-privacy"}
                                    {link href=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL() class="popup"}
                                        {lang key='privacyNotice'}
                                    {/link}
                                {/col}
                            {/block}
                            {/if}
                            {block name='checkout-step0-login-or-register-submit-button'}
                                {col cols=12 md=5 xl=4 class="checkout-button-row-submit"}
                                    {input type="hidden" name="checkout" value="1"}
                                    {input type="hidden" name="form" value="1"}
                                    {input type="hidden" name="editRechnungsadresse" value="0"}
                                    {button type="submit" variant="primary" class="submit_once" block=true}
                                        {lang key='sendCustomerData' section='account data'}
                                    {/button}
                                {/col}
                            {/block}
                        {/row}
                    {/block}
                {/form}
            {/block}
        {/col}
    {/row}
{/block}
