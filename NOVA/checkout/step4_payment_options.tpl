{**
 * This file is for compatibility in 3-step checkout (content will be replaced by payment plugins if this file is loaded)
 * @deprecated since 4.06
 *}
{block name='checkout-step4-payment-options'}
    {row class="checkout-payment-options form-group"}
        {block name='checkout-step4-payment-options-include-inc-payment-methods'}
            {include file='checkout/inc_payment_methods.tpl'}
        {/block}
    {/row}
{/block}
