{block name='register-form-customer-login'}
    {block name='register-form-customer-login-email'}
        {formgroup label="{lang key='email' section='account data'}" label-for="login_email"}
            {input type="text"
                name="email"
                id="login_email"
                placeholder=" "
                required=true
                autocomplete="email"
                value=""
            }
        {/formgroup}
    {/block}
    {block name='register-form-customer-login-password'}
        {formgroup label="{lang key='password' section='account data'}" label-for="login_password"}
            {input type="password"
                name="passwort"
                id="login_password"
                placeholder=" "
                required=true
                autocomplete="current-password"
                value=""
            }
        {/formgroup}
    {/block}
    {if isset($showLoginCaptcha) && $showLoginCaptcha}
        {block name='register-form-customer-login-captcha'}
            <div class="form-group simple-captcha-wrapper">
                {captchaMarkup getBody=true}
            </div>
        {/block}
    {/if}

    {block name='register-form-customer-login-submit'}
        {formgroup label-for=" " class="customer-login-buttons"}
            {input type="hidden" name="login" value="1"}
            {input type="hidden" name="wk" value="{if isset($one_step_wk)}{$one_step_wk}{else}0{/if}"}
            {if !empty($oRedirect->cURL)}
                {foreach $oRedirect->oParameter_arr as $oParameter}
                    {input type="hidden" name=$oParameter->Name value=$oParameter->Wert}
                {/foreach}
                {input type="hidden" name="r" value=$oRedirect->nRedirect}
                {input type="hidden" name="cURL" value=$oRedirect->cURL}
            {/if}
            {formrow}
                {col cols=12 lg=6}
                    {block name='register-form-customer-submit'}
                        {button type="submit" variant="primary" block=true}
                            {lang key='login' section='checkout'}
                        {/button}
                    {/block}
                {/col}
                {col cols=12 lg=6}
                    {block name='register-form-customer-forgot'}
                        {link class="btn btn-link customer-login-buttons-forgot" href="{get_static_route id='pass.php'}"}
                            {lang key='forgotPassword'}
                        {/link}
                    {/block}
                {/col}
            {/formrow}
        {/formgroup}
    {/block}
{/block}
