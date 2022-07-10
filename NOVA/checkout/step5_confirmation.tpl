{block name='checkout-step5-confirmation'}
    <div id="order-confirm" class="checkout-confirmation">
        {block name='checkout-step5-confirmation-alert'}
            {if !empty($smarty.get.mailBlocked)}
                {alert variant="danger"}{lang key='kwkEmailblocked' section='errorMessages'}{/alert}
            {/if}
            {if !empty($smarty.get.fillOut)}
                {alert variant="danger"}{lang key='mandatoryFieldNotification' section='errorMessages'}{/alert}
            {/if}
        {/block}

        {row class="row-eq-height"}
            {col cols=12 md=6 id="billing-address"}
                {block name='checkout-step5-confirmation-delivery-billing-address'}
                    {card no-body=true class="checkout-confirmation-billing-address"}
                        {cardheader}
                            {block name='checkout-step5-confirmation-delivery-billing-address-header'}
                                {row class='align-items-center-util'}
                                    {col}
                                        <span class="h3 checkout-confirmation-heading">{lang section="account data" key='billingAndDeliveryAddress'}</span>
                                    {/col}
                                    {col class='col-auto'}
                                        {button variant="link"
                                            size="sm"
                                            href="{get_static_route id='bestellvorgang.php'}?editRechnungsadresse=1"
                                            aria=['label'=>{lang key='change'}]
                                        }
                                            <span class="checkout-confirmation-change">{lang key='change'}</span>
                                            <span class="fa fa-pencil-alt"></span>
                                        {/button}
                                    {/col}
                                {/row}
                            {/block}
                        {/cardheader}
                        {cardbody}
                            {block name='checkout-step5-confirmation-delivery-billing-address-body'}
                                {row}
                                    {col cols=12 md=6}
                                        {block name='checkout-step5-confirmation-include-inc-billing-address'}
                                            <p><strong class="title">{lang key='billingAdress' section='account data'}</strong></p>
                                            <p>{include file='checkout/inc_billing_address.tpl'}</p>
                                        {/block}
                                    {/col}
                                    {col cols=12 md=6}
                                        {block name='checkout-step5-confirmation-include-inc-delivery-address'}
                                            <p><strong class="title">{lang key='shippingAdress' section='account data'}</strong></p>
                                            <p>{include file='checkout/inc_delivery_address.tpl'}</p>
                                        {/block}
                                    {/col}
                                {/row}
                            {/block}
                        {/cardbody}
                    {/card}
                {/block}
            {/col}
            {col cols=12 md=6 id="shipping-method"}
                {block name='checkout-step5-confirmation-shipping-billing-method'}
                    {card no-body=true class="checkout-confirmation-shipping"}
                        {cardheader}
                            {block name='checkout-step5-confirmation-shipping-billing-method-header'}
                                {row class='align-items-center-util'}
                                    {col}
                                        <span class="h3 checkout-confirmation-heading">{lang section="account data" key='shippingAndPaymentOptions'}</span>
                                    {/col}
                                    {col class='col-auto'}
                                        {button variant="link"
                                            size="sm"
                                            href="{get_static_route id='bestellvorgang.php'}?editVersandart=1"
                                            aria=['label'=>{lang key='change'}]
                                        }
                                            <span class="checkout-confirmation-change">{lang key='change'}</span>
                                            <span class="fa fa-pencil-alt"></span>
                                        {/button}
                                    {/col}
                                {/row}
                            {/block}
                        {/cardheader}
                        {cardbody}
                            {block name='checkout-step5-confirmation-shipping-billing-method-body'}
                                {row}
                                    {col cols=12 md=6}
                                        {block name='checkout-step5-confirmation-shipping-method'}
                                            <p><strong class="title">{lang key='shippingOptions'}</strong></p>
                                            <p>{$smarty.session.Versandart->angezeigterName|trans}</p>

                                            {$cEstimatedDelivery = $smarty.session.Warenkorb->getEstimatedDeliveryTime()}
                                            {if $cEstimatedDelivery|@count_characters > 0}
                                                <p class="small text-muted-util">
                                                    <strong>{lang key='shippingTime'}</strong>: {$cEstimatedDelivery}
                                                </p>
                                            {/if}
                                        {/block}
                                    {/col}
                                    {col cols=12 md=6}
                                        {block name='checkout-step5-confirmation-payment-method'}
                                            <p><strong class="title">{lang key='paymentOptions'}</strong></p>
                                            <p>{$smarty.session.Zahlungsart->angezeigterName|trans}</p>
                                            {if isset($smarty.session.Zahlungsart->cHinweisText) && !empty($smarty.session.Zahlungsart->cHinweisText)}{* this should be localized *}
                                                <p class="small text-muted-util">{$smarty.session.Zahlungsart->cHinweisText}</p>
                                            {/if}
                                        {/block}
                                    {/col}
                                {/row}
                            {/block}
                        {/cardbody}
                    {/card}
                {/block}
            {/col}

            {col cols=12 md=6}
                {block name='checkout-step5-confirmation-comment'}
                    {card no-body=true id="panel-edit-comment" class="min-h-card"}
                        {cardheader}
                            {block name='checkout-step5-confirmation-comment-header'}
                                <span class="h3 checkout-confirmation-heading">{lang key='comment' section='product rating'}</span>
                            {/block}
                        {/cardheader}
                        {cardbody}
                            {block name='checkout-step5-confirmation-comment-body'}
                                {lang assign='orderCommentsTitle' key='orderComments' section='shipping payment'}
                                {textarea title=$orderCommentsTitle|escape:'html'
                                    name="kommentar"
                                    cols="50"
                                    rows="3"
                                    id="comment"
                                    placeholder=$orderCommentsTitle|escape:'html'
                                    aria=["label"=>$orderCommentsTitle|escape:'html']
                                    class="checkout-confirmation-comment"
                                }
                                    {if isset($smarty.session.kommentar)}{$smarty.session.kommentar}{/if}
                                {/textarea}
                            {/block}
                        {/cardbody}
                    {/card}
                {/block}
            {/col}
            {if $KuponMoeglich}
                {col cols=12 md=6}
                    {block name='checkout-step5-confirmation-coupon'}
                        {card no-body=true id="panel-edit-coupon" class="min-h-card"}
                            {cardheader}
                                {block name='checkout-step5-confirmation-coupon-header'}
                                    <span class="h3 checkout-confirmation-heading">{lang key='useCoupon' section='checkout'}</span>
                                {/block}
                            {/cardheader}
                            {cardbody}
                                {block name='checkout-step5-confirmation-include-coupon-form'}
                                    {include file='checkout/coupon_form.tpl'}
                                {/block}
                            {/cardbody}
                        {/card}
                    {/block}
                {/col}
            {/if}

            {if $GuthabenMoeglich}
                {block name='checkout-step5-confirmation-credit'}
                    {col cols=12}
                        {card id="panel-edit-credit" no-body=true}
                            {cardheader}
                                {block name='checkout-step5-confirmation-credit-header'}
                                    <span class="h3 checkout-confirmation-heading">{lang key='credit' section='account data'}</span>
                                {/block}
                            {/cardheader}
                            {cardbody}
                                {block name='checkout-step5-confirmation-include-credit-form'}
                                    {include file='checkout/credit_form.tpl'}
                                {/block}
                            {/cardbody}
                        {/card}
                    {/col}
                {/block}
            {/if}
        {/row}

        {block name="checkout-step5-confirmation-pre-form-hr"}
            <hr class="checkout-confirmation-pre-form-hr">
        {/block}

        {block name='checkout-step5-confirmation-form'}
            {form method="post" name="agbform" id="complete_order" action="{get_static_route id='bestellabschluss.php'}" class="jtl-validate"}
                {block name='checkout-step5-confirmation-form-content'}
                    {lang key='agb' assign='agb'}
                    {if !empty($AGB->cAGBContentHtml)}
                        {block name='checkout-step5-confirmation-modal-agb-html'}
                            {modal id="agb-modal" title=$agb}{$AGB->cAGBContentHtml}{/modal}
                        {/block}
                    {elseif !empty($AGB->cAGBContentText)}
                        {block name='checkout-step5-confirmation-modal-agb-text'}
                            {modal id="agb-modal" title=$agb}{$AGB->cAGBContentText}{/modal}
                        {/block}
                    {/if}
                    {if $Einstellungen.kaufabwicklung.bestellvorgang_wrb_anzeigen == 1}
                        {lang key='wrb' section='checkout' assign='wrb'}
                        {lang key='wrbform' assign='wrbform'}
                        {if !empty($AGB->cWRBContentHtml)}
                            {block name='checkout-step5-confirmation-modal-wrb-html'}
                                {modal id="wrb-modal" title=$wrb}{$AGB->cWRBContentHtml}{/modal}
                            {/block}
                        {elseif !empty($AGB->cWRBContentText)}
                            {block name='checkout-step5-confirmation-modal-wrb-text'}
                                {modal id="wrb-modal" title=$wrb}{$AGB->cWRBContentText}{/modal}
                            {/block}
                        {/if}
                        {if !empty($AGB->cWRBFormContentHtml)}
                            {block name='checkout-step5-confirmation-modal-wrb-form-html'}
                                {modal id="wrb-form-modal" title=$wrbform}{$AGB->cWRBFormContentHtml}{/modal}
                            {/block}
                        {elseif !empty($AGB->cWRBFormContentText)}
                            {block name='checkout-step5-confirmation-modal-wrb-form-text'}
                                {modal id="wrb-form-modal" title=$wrbform}{$AGB->cWRBFormContentText}{/modal}
                            {/block}
                        {/if}
                    {/if}

                    {block name='checkout-step5-confirmation-alert-agb'}
                        <div class="checkout-confirmation-legal-notice">
                            <p>{$AGB->agbWrbNotice}</p>
                        </div>
                    {/block}

                    {if !isset($smarty.session.cPlausi_arr)}
                        {assign var=plausiArr value=array()}
                    {else}
                        {assign var=plausiArr value=$smarty.session.cPlausi_arr}
                    {/if}

                    {hasCheckBoxForLocation bReturn="bCheckBox" nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
                    {if $bCheckBox}
                        {block name='checkout-step5-confirmation-include-checkbox'}
                            <hr>
                            {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
                            <hr>
                        {/block}
                    {/if}
                    {row}
                        {col cols=12 class="order-submit"}
                            {block name='checkout-step5-confirmation-confirm-order'}
                            <div class="checkout-confirmation-items basket-final">
                                <div id="panel-submit-order">
                                    {input type="hidden" name="abschluss" value="1"}
                                    {input type="hidden" id="comment-hidden" name="kommentar" value=""}
                                    {block name='checkout-step5-confirmation-order-items'}
                                        {card no-body=true class='card-gray card-products'}
                                            {cardheader}
                                                {block name='checkout-step5-confirmation-order-items-header'}
                                                    {button variant="link"
                                                        size="sm"
                                                        href="{get_static_route id='warenkorb.php'}"
                                                    }
                                                        <span class="checkout-confirmation-change">{lang key='change'}</span>
                                                        <span class="fa fa-pencil-alt"></span>
                                                    {/button}
                                                {/block}
                                            {/cardheader}
                                            {cardbody}
                                                {block name='checkout-step5-confirmation-include-inc-order-items'}
                                                    {include file='checkout/inc_order_items.tpl' tplscope='confirmation'}
                                                {/block}
                                            {/cardbody}
                                        {/card}
                                    {/block}
                                    {block name='checkout-step5-confirmation-order-items-actions'}
                                        {row class="checkout-button-row"}
                                            {col cols=12 md=6 lg=4 class='ml-auto-util order-1 order-md-2'}
                                                {button type="submit" variant="primary" id="complete-order-button" block=true class="submit_once button-row-mb"}
                                                    {lang key='orderLiableToPay' section='checkout'}
                                                {/button}
                                            {/col}
                                            {col cols=12 md=6 lg=3 class='order-2 order-md-1'}
                                                {link href="{get_static_route id='warenkorb.php'}" class="btn btn-outline-primary btn-block"}
                                                    {lang key='modifyBasket' section='checkout'}
                                                {/link}
                                            {/col}
                                        {/row}
                                    {/block}
                                </div>
                            </div>
                            {/block}
                        {/col}
                    {/row}
                {/block}
            {/form}
        {/block}
    </div>
{/block}
