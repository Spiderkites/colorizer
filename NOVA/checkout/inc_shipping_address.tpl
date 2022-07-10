{block name='checkout-inc-shipping-address'}
    {assign var=fehlendeAngabenShipping value=$fehlendeAngaben.shippingAddress|default:null}
    {assign var=showShippingAddress value=(isset($Lieferadresse) || !empty($kLieferadresse) || isset($forceDeliveryAddress))}
    {row class="inc-shipping-address"}
        {col cols=12}
            {block name='checkout-inc-shipping-address-checkbox-equals'}
                <div class="form-group checkbox control-toggle">
                    {input type="hidden" name="shipping_address" value="1"}
                    {checkbox id="checkout_register_shipping_address"
                        name="shipping_address" value="0" checked=!$showShippingAddress
                        data=["toggle"=>"collapse", "target"=>"#select_shipping_address"]
                        class="{if isset($forceDeliveryAddress)}d-none{/if}"
                    }
                        {lang key='shippingAdressEqualBillingAdress' section='account data'}
                    {/checkbox}
                </div>
            {/block}
        {/col}
        {col cols=12}
            {block name='checkout-inc-shipping-address-shipping-address'}
            <div id="select_shipping_address" class="collapse collapse-non-validate{if $showShippingAddress} show{/if}" aria-expanded="{if $showShippingAddress}true{else}false{/if}">
                {block name='checkout-inc-shipping-address-shipping-address-body'}
                    {if !empty($smarty.session.Kunde->kKunde) && isset($Lieferadressen) && $Lieferadressen|count > 0}
                        {row}
                            {col cols=12 md=4}
                                {block name='checkout-inc-shipping-address-legend-address'}
                                    <div class="h3">{lang key='deviatingDeliveryAddress' section='account data'}</div>
                                {/block}
                            {/col}
                            {col md=8}
                                {block name='checkout-inc-shipping-address-fieldset-address'}
                                    <fieldset>
                                        {listgroup class="form-group exclude-from-label-slide" tag="ul"}
                                        {foreach $Lieferadressen as $adresse}
                                            {if $adresse->kLieferadresse > 0}
                                                {block name='checkout-inc-shipping-address-address'}
                                                    {listgroupitem tag="li"}
                                                        <label class="btn-block no-caret text-wrap" for="delivery{$adresse->kLieferadresse}" data-toggle="collapse" data-target="#register_shipping_address.show">
                                                            {radio name="kLieferadresse" value=$adresse->kLieferadresse id="delivery{$adresse->kLieferadresse}" checked=($kLieferadresse == $adresse->kLieferadresse)}
                                                                <span class="control-label label-default">{if $adresse->cFirma}{$adresse->cFirma},{/if} {$adresse->cVorname} {$adresse->cNachname}
                                                                    , {$adresse->cStrasse} {$adresse->cHausnummer}, {$adresse->cPLZ} {$adresse->cOrt}
                                                                    , {$adresse->angezeigtesLand}</span>
                                                            {/radio}
                                                        </label>
                                                    {/listgroupitem}
                                                {/block}
                                            {/if}
                                        {/foreach}
                                        {block name='checkout-inc-shipping-address-new-address'}
                                            {listgroupitem tag="li"}
                                                <label class="btn-block" for="delivery_new" data-toggle="collapse" data-target="#register_shipping_address:not(.show)">
                                                    {radio name="kLieferadresse" value="-1" id="delivery_new" checked=($kLieferadresse == -1) required=true aria-required=true}
                                                        <span class="control-label label-default">{lang key='createNewShippingAdress' section='account data'}</span>
                                                    {/radio}
                                                </label>
                                            {/listgroupitem}
                                        {/block}
                                        {/listgroup}
                                    </fieldset>
                                {/block}
                                {block name='checkout-inc-shipping-address-fieldset-register'}
                                    <fieldset id="register_shipping_address" class="checkout-register-shipping-address collapse collapse-non-validate {if $kLieferadresse == -1}} show{/if}" aria-expanded="{if $kLieferadresse == -1}}true{else}false{/if}">
                                        {block name='checkout-inc-shipping-address-legend-register'}
                                            <legend>{lang key='createNewShippingAdress' section='account data'}</legend>
                                        {/block}
                                        {block name='checkout-inc-shipping-address-include-customer-shipping-address'}
                                            {include file='checkout/customer_shipping_address.tpl' prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
                                        {/block}
                                        {block name='checkout-inc-shipping-address-include-customer-shipping-contact'}
                                            {include file='checkout/customer_shipping_contact.tpl' prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
                                        {/block}
                                    </fieldset>
                                {/block}
                            {/col}
                        {/row}
                    {else}
                        {row}
                            {col cols=12 md=4}
                                {block name='checkout-inc-shipping-address-legend-register-first'}
                                    <div class="h3">{lang key='createNewShippingAdress' section='account data'}</div>
                                {/block}
                            {/col}
                            {col md=8}
                                {block name='checkout-inc-shipping-address-include-customer-shipping-address-first'}
                                    {include file='checkout/customer_shipping_address.tpl' prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
                                {/block}
                                {block name='checkout-inc-shipping-address-include-customer-shipping-contact-first'}
                                    {include file='checkout/customer_shipping_contact.tpl' prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
                                {/block}
                            {/col}
                        {/row}
                    {/if}
                {/block}
            </div>
            {/block}
        {/col}
    {/row}
    {if isset($smarty.get.editLieferadresse) || $step === 'Lieferadresse'}
        {block name='checkout-inc-shipping-address-script-show-shipping-address'}
            {inline_script}<script>
                $(window).on('load', function () {
                    var $registerShippingAddress = $('#checkout_register_shipping_address');
                    if ($registerShippingAddress.prop('checked')) {
                        $registerShippingAddress.click();
                    }
                    $.evo.extended().smoothScrollToAnchor('#checkout_register_shipping_address');
                });
            </script>{/inline_script}
        {/block}
    {/if}
{/block}
