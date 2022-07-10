{block name='newsletter-index'}
    {block name='newsletter-index-include-header'}
        {include file='layout/header.tpl'}
    {/block}

    {block name='newsletter-index-content'}
        {block name='newsletter-index-heading'}
            {if !empty($Link->getTitle())}
                {opcMountPoint id='opc_before_newsletter_heading' inContainer=false}
                {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                    <h1>{$Link->getTitle()}</h1>
                {/container}
            {/if}
        {/block}
        {block name='newsletter-index-include-extension'}
            {include file='snippets/extension.tpl'}
        {/block}
        {if !isset($cPost_arr)}
            {assign var=cPost_arr value=array()}
        {/if}
        {block name='newsletter-index-link-content'}
            {if !empty($Link->getContent())}
                {opcMountPoint id='opc_before_newsletter_content' inContainer=false}
                {container fluid=$Link->getIsFluid() class="newsletter-content {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                    {$Link->getContent()}
                {/container}
            {/if}
        {/block}
        {if $cOption === 'eintragen'}
            {if empty($bBereitsAbonnent)}
                {block name='newsletter-index-newsletter-subscribe-form'}
                    {opcMountPoint id='opc_before_newsletter_subscribe' inContainer=false}
                    {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                        {row}
                            {col cols=12 lg=8}
                                <div id="newsletter-subscribe" class="newsletter-subscribe">
                                    {block name='newsletter-index-newsletter-subscribe-subheading'}
                                        <div class="h3">{lang key='newsletterSubscribe' section='newsletter'}</div>
                                    {/block}
                                    {block name='newsletter-index-newsletter-subscribe-desc'}
                                        <p>{lang key='newsletterSubscribeDesc' section='newsletter'}</p>
                                    {/block}
                                    {form method="post" action="{get_static_route id='newsletter.php'}" role="form" class="jtl-validate" slide=true}
                                    {block name='newsletter-index-newsletter-subscribe-form-content'}
                                        <fieldset>
                                            {if !empty($oPlausi->cPost_arr.cEmail)}
                                                {assign var=inputVal_email value=$oPlausi->cPost_arr.cEmail}
                                            {elseif !empty($oKunde->cMail)}
                                                {assign var=inputVal_email value=$oKunde->cMail}
                                            {/if}
                                            {block name='newsletter-index-form-email'}
                                                {include file='snippets/form_group_simple.tpl'
                                                options=[
                                                'email', 'email', 'cEmail',
                                                {$inputVal_email|default:null}, {lang key='newsletteremail' section='newsletter'},
                                                true, null, 'email'
                                                ]
                                                }
                                            {/block}
                                            {assign var=plausiArr value=$oPlausi->nPlausi_arr|default:[]}
                                            {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
                                            isset($Einstellungen.newsletter.newsletter_sicherheitscode) && $Einstellungen.newsletter.newsletter_sicherheitscode !== 'N' && empty($smarty.session.Kunde->kKunde)}
                                                {block name='newsletter-index-form-captcha'}
                                                    <div class="form-group simple-captcha-wrapper{if !empty($plausiArr.captcha) && $plausiArr.captcha === true} has-error{/if}">
                                                        {captchaMarkup getBody=true}
                                                    </div>
                                                {/block}
                                            {/if}
                                            {hasCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr bReturn="bHasCheckbox"}
                                            {if $bHasCheckbox}
                                                {block name='newsletter-index-form-include-checkbox'}
                                                    {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
                                                {/block}
                                            {/if}

                                            {block name='newsletter-index-newsletter-subscribe-form-content-submit'}
                                                {row}
                                                    {col md=6 class='ml-auto-util'}
                                                        {input type="hidden" name="abonnieren" value="1"}
                                                        {button type="submit" variant="primary" block=true}
                                                            <span>{lang key='newsletterSendSubscribe' section='newsletter'}</span>
                                                        {/button}
                                                        {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
                                                        <p class="info small newsletter-subscribe-consent">
                                                            {lang key='newsletterInformedConsent' section='newsletter' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}
                                                        </p>
                                                        {/if}
                                                    {/col}
                                                {/row}
                                            {/block}
                                        </fieldset>
                                    {/block}
                                    {/form}
                                </div>
                            {/col}
                        {/row}
                    {/container}
                {/block}
            {/if}

            {block name='newsletter-index-newsletter-unsubscribe-form'}
                {opcMountPoint id='opc_before_newsletter_unsubscribe' inContainer=false}
                {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                    {row}
                        {col cols=12 lg=8}
                            <div id="newsletter-unsubscribe" class="newsletter-unsubscribe">
                                {block name='newsletter-index-newsletter-unsubscribe-subheading'}
                                    <div class="h3">{lang key='newsletterUnsubscribe' section='newsletter'}</div>
                                {/block}
                                {block name='newsletter-index-newsletter-unsubscribe-desc'}
                                    <p>{lang key='newsletterUnsubscribeDesc' section='newsletter'}</p>
                                {/block}
                                {form method="post" action="{get_static_route id='newsletter.php'}" name="newsletterabmelden" class="jtl-validate" slide=true}
                                {block name='newsletter-index-newsletter-unsubscribe-form-content'}
                                    <fieldset>
                                        {include file='snippets/form_group_simple.tpl'
                                        options=[
                                        'email', 'checkOut', 'cEmail',
                                        {$oKunde->cMail|default:null}, {lang key='newsletteremail' section='newsletter'},
                                        true, $oFehlendeAngaben->cUnsubscribeEmail|default:null, 'email'
                                        ]
                                        }
                                        {input type="hidden" name="abmelden" value="1"}
                                        {row}
                                            {col md=6 class='ml-auto-util'}
                                                {button type="submit" block=true variant="outline-primary"}
                                                    <span>{lang key='newsletterSendUnsubscribe' section='newsletter'}</span>
                                                {/button}
                                            {/col}
                                        {/row}
                                    </fieldset>
                                {/block}
                                {/form}
                            </div>
                        {/col}
                    {/row}
                {/container}
            {/block}
        {elseif $cOption === 'anzeigen'}
            {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                {if isset($oNewsletterHistory) && $oNewsletterHistory->kNewsletterHistory > 0}
                    {block name='newsletter-index-newsletter-history'}
                        {block name='newsletter-index-newsletter-history-heading'}
                            <div class="h2">{lang key='newsletterhistory' section='global'}</div>
                        {/block}
                        {block name='newsletter-index-newsletter-history-content'}
                            <div id="newsletterContent">
                                <div class="newsletter">
                                    <p class="newsletterSubject">
                                        <strong>{lang key='newsletterdraftsubject' section='newsletter'}:</strong> {$oNewsletterHistory->cBetreff}
                                    </p>
                                    <p class="newsletterReference">
                                        {lang key='newsletterdraftdate' section='newsletter'}: {$oNewsletterHistory->Datum}
                                    </p>
                                </div>

                                <fieldset id="newsletterHtml">
                                    <legend>{lang key='newsletterHtml' section='newsletter'}</legend>
                                    {$oNewsletterHistory->cHTMLStatic|replace:'src="http://':'src="//'}
                                </fieldset>
                            </div>
                        {/block}
                    {/block}
                {else}
                    {block name='newsletter-index-alert'}
                        {alert variant="danger"}{lang key='noEntriesAvailable' section='global'}{/alert}
                    {/block}
                {/if}
            {/container}
        {/if}
    {/block}

    {block name='newsletter-index-include-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
