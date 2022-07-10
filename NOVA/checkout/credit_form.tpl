{block name='checkout-credit-form'}
    {if $Kunde->fGuthaben > 0 && (!isset($smarty.session.Bestellung->GuthabenNutzen) || !$smarty.session.Bestellung->GuthabenNutzen)}
        {form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form form-inline credit-form" slide=true}
            {block name='checkout-credit-form-form-content'}
                <fieldset>
                    {row}
                        {col cols=12 md=6}
                            {block name='checkout-credit-form-desc'}
                                <p class="credit-description">{lang key='creditDesc' section='account data'}</p>
                            {/block}
                        {/col}
                        {col cols=12 md=6}
                            {block name='checkout-credit-form-alert'}
                                <div class="credit-amount-description">
                                    {lang key='yourCreditIs' section='account data'} <strong class="credit-amount">{$GuthabenLocalized}</strong>
                                </div>
                            {/block}
                            {block name='checkout-credit-form-submit'}
                                {input type="hidden" name="guthabenVerrechnen" value="1"}
                                {input type="hidden" name="guthaben" value="1"}
                                {button type="submit" value="1" block=true variant="outline-primary"}{lang key='useCredits' section='checkout'}{/button}
                            {/block}
                        {/col}
                    {/row}
                </fieldset>
            {/block}
        {/form}
    {/if}
{/block}
