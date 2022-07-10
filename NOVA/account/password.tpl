{block name='account-password'}
    {block name='account-password-include-header'}
        {include file='layout/header.tpl'}
    {/block}

    {block name='account-password-content'}
        {block name='account-password-include-extension'}
            {include file='snippets/extension.tpl'}
        {/block}
        {block name='account-password-heading'}
            {container fluid=$Link->getIsFluid() class="account-password-heading {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                <h1>{lang key='forgotPassword' section='global'}</h1>
            {/container}
        {/block}
        {container fluid=$Link->getIsFluid() class="account-password {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {if $step === 'formular'}
                {row}
                    {col cols=12 lg=8}
                        {block name='account-password-alert'}
                            {$alertList->displayAlertByKey('forgotPasswordDesc')}
                        {/block}
                        {block name='account-password-form-password-reset'}
                            {form id="passwort_vergessen"
                                action="{get_static_route id='pass.php'}{if $bExclusive === true}?exclusive_content=1{/if}"
                                method="post"
                                class="jtl-validate"
                                slide=true}
                                {block name='account-password-form-password-reset-content'}
                                    <fieldset>
                                        {include file='snippets/form_group_simple.tpl'
                                            options=[
                                                'email', 'email', 'email', "{if $presetEmail !== ''}{$presetEmail}{/if}",
                                                {lang key='emailadress'}, true
                                            ]
                                        }
                                        {block name='account-password-form-reset-submit'}
                                            {row}
                                                {col class='col-md-auto ml-md-auto'}
                                                    {if $bExclusive === true}
                                                      {input type="hidden" name="exclusive_content" value="1"}
                                                    {/if}
                                                    {input type="hidden" name="passwort_vergessen" value="1"}
                                                    {button type="submit" value="1" block=true class="submit_once" variant="primary"}
                                                        {lang key='createNewPassword' section='forgot password'}
                                                    {/button}
                                                {/col}
                                            {/row}
                                        {/block}
                                    </fieldset>
                                {/block}
                            {/form}
                        {/block}
                    {/col}
                {/row}
            {elseif $step === 'confirm'}
                {row}
                    {col cols=12 md=8 md-offset=2}
                        {block name='account-password-form-password-reset-confirm'}
                            <div class="h3">{block name='account-password-password-reset-confirm-title'}{lang key='customerInformation' section='global'}{/block}</div>
                            {form id="passwort_vergessen" action="{get_static_route id='pass.php'}{if $bExclusive === true}?exclusive_content=1{/if}" method="post" class="jtl-validate" slide=true}
                                {block name='account-password-form-password-reset-confirm-content'}
                                    <fieldset>
                                        {include file='snippets/form_group_simple.tpl'
                                            options=[
                                                "password", "pw_new", "pw_new", null,
                                                {lang key='password' section='account data'}, true, null, "new-password"
                                            ]
                                        }
                                        {include file='snippets/form_group_simple.tpl'
                                            options=[
                                                "password", "pw_new_confirm", "pw_new_confirm", null,
                                                {lang key='passwordRepeat' section='account data'}, true, null, "new-password"
                                            ]
                                        }
                                        {block name='account-password-form-confirm-submit'}
                                            {formgroup}
                                                {if $bExclusive === true}
                                                    {input type="hidden" name="exclusive_content" value="1"}
                                                {/if}
                                                {input type="hidden" name="fpwh" value=$fpwh}
                                                {button type="submit" value="1" block=true class="submit_once" variant="primary"}
                                                    {lang key='confirmNewPassword' section='forgot password'}
                                                {/button}
                                            {/formgroup}
                                        {/block}
                                    </fieldset>
                                {/block}
                            {/form}
                        {/block}
                    {/col}
                {/row}
            {else}
                {block name='account-password-alert-success'}
                    {alert variant="success"}{lang key='newPasswortWasGenerated' section='forgot password'}{/alert}
                {/block}
            {/if}
        {/container}
    {/block}

    {block name='account-password-include-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
