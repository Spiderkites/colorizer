{block name='account-login'}
    {block name='account-login-heading'}
        <h1>{if !empty($oRedirect->cName)}{$oRedirect->cName}{else}{lang key='loginTitle' section='login'}{/if}</h1>
    {/block}
    {if !$bCookieErlaubt}
        {block name='account-login-alert-no-cookie'}
            {alert variant="danger" class="d-none" id="no-cookies-warning"}
                <strong>{lang key='noCookieHeader' section='errorMessages'}</strong>
                <p>{lang key='noCookieDesc' section='errorMessages'}</p>
            {/alert}
        {/block}
        {block name='account-login-script-no-cookie'}
            {inline_script}<script>
               $(function() {
                   if (navigator.cookieEnabled === false) {
                       $('#no-cookies-warning').show();
                   }
               });
            </script>{/inline_script}
        {/block}
    {elseif !$alertNote}
        {block name='account-login-alert'}
            {alert variant="info"}
                {lang key='loginDesc' section='login'}
                {if isset($oRedirect->cName) && $oRedirect->cName}{lang key='redirectDesc1'} {$oRedirect->cName} {lang key='redirectDesc2'}.{/if}
            {/alert}
        {/block}
    {/if}

    {block name='account-login-form'}
        {opcMountPoint id='opc_before_login'}
        {row class="login-form"}
            {col sm=8 lg=6}
                {form id="login_form" action="{get_static_route id='jtl.php'}" method="post" role="form" class="jtl-validate" slide=true}
                    <fieldset>
                        {block name='account-login-form-submit-legend-login'}
                            <legend>
                                {lang key='loginForRegisteredCustomers' section='checkout'}
                            </legend>
                        {/block}
                        {block name='account-login-form-submit-body'}
                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'email', 'email', 'email', null,
                                    {lang key='emailadress'}, true, null, "email"
                                ]
                            }

                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'password', 'password', 'passwort', null,
                                    {lang key='password' section='account data'}, true, null, "current-password"
                                ]
                            }

                            {if isset($showLoginCaptcha) && $showLoginCaptcha}
                                {block name='account-login-form-submit-captcha'}
                                   {formgroup class="simple-captcha-wrapper"}
                                        {captchaMarkup getBody=true}
                                   {/formgroup}
                                {/block}
                            {/if}

                            {block name='account-login-form-submit'}
                                {formgroup class="login-form-submit"}
                                    {input type="hidden" name="login" value="1"}
                                    {if !empty($oRedirect->cURL)}
                                        {foreach $oRedirect->oParameter_arr as $oParameter}
                                            {input type="hidden" name=$oParameter->Name value=$oParameter->Wert}
                                        {/foreach}
                                        {input type="hidden" name="r" value=$oRedirect->nRedirect}
                                        {input type="hidden" name="cURL" value=$oRedirect->cURL}
                                    {/if}
                                    {block name='account-login-form-submit-button'}
                                        {button type="submit" value="1" block=true variant="primary"}
                                            {lang key='login' section='checkout'}
                                        {/button}
                                    {/block}
                                {/formgroup}
                            {/block}
                            {block name='account-login-form-submit-register'}
                                <span class="register-wrapper">
                                    {lang key='newHere'}
                                    {link class="register" href="{get_static_route id='registrieren.php'}"}
                                        {lang key='registerNow'}
                                    {/link}
                                </span>
                            {/block}
                            {block name='account-login-form-submit-resetpw'}
                                <span class="resetpw-wrapper">
                                   {link class="resetpw" href="{get_static_route id='pass.php'}"}
                                       <span class="fa fa-question-circle"></span> {lang key='forgotPassword'}
                                   {/link}
                                </span>
                            {/block}
                        {/block}
                    </fieldset>
                {/form}
            {/col}
        {/row}
    {/block}
{/block}
