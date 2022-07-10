{block name='boxes-box-login'}
    <div id="sidebox{$oBox->getID()}" class="box box-login box-normal">
        {block name='boxes-box-login-content'}
            {block name='boxes-box-login-title'}
                <div class="productlist-filter-headline">
                    {if empty($smarty.session.Kunde)}{lang key='login'}{else}{lang key='hello'}, {$smarty.session.Kunde->cVorname} {$smarty.session.Kunde->cNachname}{/if}
                </div>
            {/block}
            {if empty($smarty.session.Kunde->kKunde)}
                {block name='boxes-box-login-form'}
                    <div class="box-content-wrapper">
                    {form action="{get_static_route id='jtl.php' secure=true}" method="post" class="form jtl-validate" slide=true}
                        {block name='boxes-box-login-form-data'}
                            {input type="hidden" name="login" value="1"}
                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'email', "email-box-login-{$oBox->getID()}", 'email', null,{lang key='emailadress'}, true, null, 'email', 'sm'
                                ]
                            }
                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'password', "password-box-login-{$oBox->getID()}", 'passwort', null,
                                    {lang key='password' section='account data'}, true, null, 'current-password', 'sm'
                                ]
                            }
                        {/block}
                        {if isset($showLoginCaptcha) && $showLoginCaptcha}
                            {block name='boxes-box-login-form-captcha'}
                                {formgroup class="simple-captcha-wrapper"}
                                    {captchaMarkup getBody=true}
                                {/formgroup}
                            {/block}
                        {/if}
                        {block name='boxes-box-login-form-submit'}
                            {formgroup}
                                {if !empty($oRedirect->cURL)}
                                    {foreach $oRedirect->oParameter_arr as $oParameter}
                                        {input type="hidden" name=$oParameter->Name value=$oParameter->Wert}
                                    {/foreach}
                                    {input type="hidden" name="r" value=$oRedirect->nRedirect}
                                    {input type="hidden" name="cURL" value=$oRedirect->cURL}
                                {/if}
                                {button type="submit" name="speichern" value="1" variant="primary" block=true class="submit" size="sm"}
                                    {lang key='login' section='checkout'}
                                {/button}
                            {/formgroup}
                        {/block}
                        {block name='boxes-box-login-form-links'}
                            {link class="resetpw box-login-resetpw" href="{get_static_route id='pass.php' secure=true}"}
                                {lang key='forgotPassword'}
                            {/link}
                            {lang key='newHere'}
                            {link class="register text-decoration-underline" href="{get_static_route id='registrieren.php'}"}
                                {lang key='registerNow'}
                            {/link}
                        {/block}
                    {/form}
                    </div>
                {/block}
            {else}
                {block name='boxes-box-login-actions'}
                    <div class="box-content-wrapper">
                    {link href="{get_static_route id='jtl.php'}" class="btn btn-outline-primary btn-block btn-sm btn-account"}
                        {lang key='myAccount'}
                    {/link}
                    {link href="{get_static_route id='jtl.php'}?logout=1&token={$smarty.session.jtl_token}"
                        class="btn btn-block btn-sm btn-primary btn-logout"
                    }
                        {lang key='logOut'}
                    {/link}
                    </div>
                {/block}
            {/if}
            {block name='boxes-box-login-hr-end'}
                <hr class="box-normal-hr">
            {/block}
        {/block}
    </div>
{/block}
