{block name='checkout-inc-steps'}
    {assign var=step1_active value=($bestellschritt[1] == 1 || $bestellschritt[2] == 1)}
    {assign var=step2_active value=($bestellschritt[3] == 1 || $bestellschritt[4] == 1)}
    {assign var=step3_active value=($bestellschritt[5] == 1)}
    {if $bestellschritt[1] != 3}
        {nav class='stepper checkout-steps' tag='nav' aria=["label"=>"{lang key='secureCheckout' section='checkout'}"]}
            {col lg=4 class="nav-item step step-active {if $step1_active}step-current{else}col-auto{/if}"}
                {block name='checkout-inc-steps-first'}
                    {link href="{get_static_route id='bestellvorgang.php'}?editRechnungsadresse=1"
                        title="{lang section='account data' key='billingAndDeliveryAddress'}"
                        class="text-decoration-none-util"}
                        <div class="step-content">
                            {badge variant="primary" class="badge-pill"}
                                <span class="badge-count">1</span>
                            {/badge}
                            <span class="step-text {if !$step1_active}d-none d-md-inline-block{/if}">
                                {lang section='account data' key='billingAndDeliveryAddress'}
                            </span>
                            {if $step2_active || $step3_active}
                                <span class="fas fa-check step-check"></span>
                            {/if}
                        </div>
                    {/link}
                {/block}
            {/col}
            {col lg=4 class="nav-item step {if $step2_active || $step3_active}step-active{/if} {if $step2_active}step-current{else}col-auto{/if}"}
                {block name='checkout-inc-steps-second'}
                    {link href="{get_static_route id='bestellvorgang.php'}?editVersandart=1"
                        title="{lang section='account data' key='shippingAndPaymentOptions'}"
                        class="text-decoration-none-util"}
                        <div class="step-content">
                            {badge variant="{if $step2_active || $step3_active}primary{else}secondary{/if}" class="badge-pill"}
                                <span class="badge-count">2</span>
                            {/badge}
                            <span class="step-text {if !$step2_active}d-none d-md-inline-block{/if}">
                                {lang section='account data' key='shippingAndPaymentOptions'}
                            </span>
                            {if $step3_active}
                                <span class="fas fa-check step-check"></span>
                            {/if}
                        </div>
                    {/link}
                {/block}
            {/col}
            {col lg=4 class="nav-item step {if $step3_active}step-active step-current{else}col-auto{/if}"}
                {block name='checkout-inc-steps-third'}
                    <div class="step-content">
                        {badge variant="{if $step3_active}primary{else}secondary{/if}" class="badge-pill"}
                            <span class="badge-count">3</span>
                        {/badge}
                        <span class="step-text {if !$step3_active}d-none d-md-inline-block{/if}">
                            {lang section='checkout' key='summary'}
                        </span>
                    </div>
                {/block}
            {/col}
        {/nav}
    {/if}
{/block}
