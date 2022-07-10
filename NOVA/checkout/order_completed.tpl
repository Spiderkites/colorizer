{block name='checkout-order-completed'}
    {block name='checkout-order-completed-include-header'}
        {include file='layout/header.tpl'}
    {/block}
    {block name='checkout-order-completed-content'}
        {block name='checkout-order-completed-heading'}
            {container fluid=$Link->getIsFluid()}
                {if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
                    <h2>{lang key='orderCompletedPre' section='checkout'}</h2>
                {elseif $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl' && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
                    <h2>{lang key='orderCompletedPost' section='checkout'}</h2>
                {/if}
            {/container}
        {/block}
        {block name='checkout-order-completed-include-extension'}
            {include file='snippets/extension.tpl'}
        {/block}
        {block name='checkout-order-completed-main'}
            {container fluid=$Link->getIsFluid()}
                <div class="order-completed">
                    {block name='checkout-order-completed-include-inc-paymentmodules'}
                        {include file='checkout/inc_paymentmodules.tpl'}
                    {/block}
                    {block name='checkout-order-completed-order-completed'}
                        {if isset($abschlussseite)}
                            {block name='checkout-order-completed-include-inc-order-completed'}
                                {include file='checkout/inc_order_completed.tpl'}
                            {/block}
                        {/if}
                    {/block}
                    {block name='checkout-order-completed-continue-shopping'}
                        {row}
                            {col md=4 lg=3 xl=2}
                                {button block=true type="link" href={$ShopURL} variant="primary"}
                                    {lang key='continueShopping' section='checkout'}
                                {/button}
                            {/col}
                        {/row}
                    {/block}
                </div>
            {/container}
        {/block}
    {/block}
    {block name='checkout-order-completed-include-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
