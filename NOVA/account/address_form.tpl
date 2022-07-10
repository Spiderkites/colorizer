{block name='account-address-form'}
    {block name='account-address-form-form-rechnungsdaten'}
        {form method="post" id='rechnungsdaten' action="{get_static_route params=['editRechnungsadresse' => 1]}" class="jtl-validate" slide=true}
            <div id="panel-address-form">
                {block name='account-address-form-include-inc-billing-address-form'}
                    {include file='checkout/inc_billing_address_form.tpl'}
                {/block}
                {block name='account-address-form-form-submit'}
                    {row class='btn-row'}
                        {col md=3 cols=12}
                            {link class="btn btn-outline-primary btn-back" href="{get_static_route id='jtl.php'}"}
                                {lang key='back'}
                            {/link}
                        {/col}
                        {col md=4 xl=3 class="checkout-button-row-submit"}
                            {input type="hidden" name="editRechnungsadresse" value="1"}
                            {input type="hidden" name="edit" value="1"}
                            {button type="submit" value="1" block=true variant="primary"}
                                {lang key='editCustomerData' section='account data'}
                            {/button}
                        {/col}
                    {/row}
                {/block}
            </div>
        {/form}
    {/block}
{/block}
