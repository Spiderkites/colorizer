{block name='checkout-step6-init-payment'}
    {block name='checkout-step6-init-payment-include-header'}
        {include file='layout/header.tpl'}
    {/block}

    {block name='checkout-step6-init-payment-content'}
        <div id="content">
            {block name='checkout-step6-init-payment-heading'}
                {if $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
                    <h1>{lang key='orderCompletedPre' section='checkout'}</h1>
                {else}
                    <h1>{lang key='orderCompletedPost' section='checkout'}</h1>
                {/if}
            {/block}
            <div class="order_process">
                {block name='checkout-step6-init-payment-include-inc-order-items'}
                    {include file='checkout/inc_order_items.tpl' tplscope='init-payment'}
                {/block}
                {block name='checkout-step6-init-payment-include-inc-paymentmodules'}
                    {include file='checkout/inc_paymentmodules.tpl'}
                {/block}
            </div>
        </div>
    {/block}

    {block name='checkout-step6-init-payment-include-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
