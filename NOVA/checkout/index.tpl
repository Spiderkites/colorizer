{block name='checkout-index'}
    {block name='checkout-index-include-header'}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/header.tpl'}
        {/if}
    {/block}

    {block name='checkout-index-content'}

        <div id="result-wrapper" data-wrapper="true">
            {container fluid=$Link->getIsFluid() id="checkout"}
                {block name='checkout-index-include-inc-steps'}
                    {include file='checkout/inc_steps.tpl'}
                {/block}
                {block name='checkout-index-include-extension'}
                    {include file='snippets/extension.tpl'}
                {/block}
                {if $step === 'accountwahl'}
                    {include file='checkout/step0_login_or_register.tpl'}{*bestellvorgang_accountwahl.tpl*}
                {elseif $step === 'edit_customer_address' || $step === 'Lieferadresse'}
                    {include file='checkout/step1_edit_customer_address.tpl'}{*bestellvorgang_unregistriert_formular.tpl*}
                {elseif $step === 'Versand' || $step === 'Zahlung'}
                    {include file='checkout/step3_shipping_options.tpl'}{*bestellvorgang_versand.tpl*}
                {elseif $step === 'ZahlungZusatzschritt'}
                    {include file='checkout/step4_payment_additional.tpl'}{*bestellvorgang_zahlung_zusatzschritt*}
                {elseif $step === 'Bestaetigung'}
                    {include file='checkout/step5_confirmation.tpl'}{*bestellvorgang_bestaetigung*}
                {/if}
            {/container}
        </div>

        {if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
            {block name='checkout-index-script-basket-merge'}
                {inline_script}<script>
                    $(window).on('load', function() {
                        $(function() {
                            eModal.addLabel('{lang key='yes' section='global'}', '{lang key='no' section='global'}');
                            var options = {
                                message: '{lang key='basket2PersMerge' section='login'}',
                                label: '{lang key='yes' section='global'}',
                                title: '{lang key='basket' section='global'}'
                            };
                            eModal.confirm(options).then(
                                function() {
                                    window.location = "{get_static_route id='bestellvorgang.php'}?basket2Pers=1&token={$smarty.session.jtl_token}"
                                }
                            );
                        });
                    });
                </script>{/inline_script}
            {/block}
        {/if}
        {block name='checkout-index-script-location'}
            <script>
                if (top.location !== self.location) {
                    top.location = self.location.href;
                }
            </script>
        {/block}
    {/block}

    {block name='checkout-index-include-footer'}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/footer.tpl'}
        {/if}
    {/block}
{/block}
