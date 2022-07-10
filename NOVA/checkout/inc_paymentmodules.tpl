{block name='checkout-inc-paymentmodules'}
    {if !isset($abschlussseite) || $abschlussseite !== 1}
        {if $oPlugin !== null && $oPlugin instanceof JTL\Plugin\PluginInterface}
            {$method = $oPlugin->getPaymentMethods()->getMethodByID($Bestellung->Zahlungsart->cModulId)}
        {else}
            {$method = null}
        {/if}
        {assign var=cModulId value=$Bestellung->Zahlungsart->cModulId}
        {if ($method === null || $Bestellung->Zahlungsart->cModulId !== $method->getModuleID())
            && $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl'
            && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'
        }
            {block name='checkout-inc-paymentmodules-alert'}
                <p class="checkout-paymentmodules-alert">
                    {if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
                        {lang key='orderConfirmationPre' section='checkout'}
                    {else}
                        {lang key='orderConfirmationPost' section='checkout'}
                    {/if}
                </p>
            {/block}
        {/if}

        {if (empty($smarty.session.Zahlungsart->nWaehrendBestellung) || $smarty.session.Zahlungsart->nWaehrendBestellung != 1)
            && $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl'
            && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'
        }
            {block name='checkout-inc-paymentmodules-during-order'}
                <ul class="list-unstyled payment-method-module-ids">
                    <li><strong>{lang key='yourOrderId' section='checkout'}: </strong>{$Bestellung->cBestellNr}</li>
                    <li><strong>{lang key='yourChosenPaymentOption' section='checkout'}: </strong>{$Bestellung->cZahlungsartName}</li>
                </ul>
            {/block}
        {/if}
        {block name='checkout-inc-paymentmodules-method-inner'}
            <div class="payment-method-inner">
                {if $Bestellung->Zahlungsart->cModulId === 'za_paypal_jtl'}
                    {block name='checkout-inc-paymentmodules-include-bestellabschluss'}
                        {include file='checkout/modules/paypal/bestellabschluss.tpl'}
                    {/block}
                {elseif $Bestellung->Zahlungsart->cModulId === 'za_kreditkarte_jtl'}
                    {block name='checkout-inc-paymentmodules-include-retrospective-payment'}
                        {include file='account/retrospective_payment.tpl'}
                    {/block}
                {elseif $method !== null && $Bestellung->Zahlungsart->cModulId === $method->getModuleID()}
                    {block name='checkout-inc-paymentmodules-include-plugin'}
                        {include file=$method->getTemplateFilePath()}
                    {/block}
                {/if}
            </div>
        {/block}
    {/if}
{/block}
