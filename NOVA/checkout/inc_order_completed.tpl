{block name='checkout-inc-order-completed'}
    {card id="order-confirmation"}
        {block name='checkout-inc-order-completed-alert'}
            <p class="order-confirmation-note">{lang key='orderConfirmationPost' section='checkout'}</p>
        {/block}
        {block name='checkout-inc-order-completed-id-payment'}
            <ul class="list-unstyled order-confirmation-details">
                <li><strong>{lang key='yourOrderId' section='checkout'}:</strong> {$Bestellung->cBestellNr}</li>
                <li><strong>{lang key='yourChosenPaymentOption' section='checkout'}:</strong> {$Bestellung->cZahlungsartName}</li>
            </ul>
        {/block}
    {/card}
{/block}
