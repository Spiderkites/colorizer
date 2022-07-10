{block name='account-delete-account'}
    {block name='heading'}
        <h1>{lang key='deleteAccount' section='login'}</h1>
    {/block}
    {block name='account-delete-account-alert'}
        {alert variant="danger"}{lang key='reallyDeleteAccount' section='login'}{/alert}
    {/block}
    {block name='account-delete-account-form'}
        {form id="delete_account" action="{get_static_route id='jtl.php'}" method="post" slide=true}
            {block name='account-delete-account-form-submit'}
                {input type="hidden" name="del_acc" value="1"}
                {row}
                    {col md=3 cols=12}
                        {link class="btn btn-outline-primary btn-back" href="{get_static_route id='jtl.php'}"}
                            {lang key='back'}
                        {/link}
                    {/col}
                    {col class='ml-auto-util col-md-auto'}
                        {button type="submit" value="1" block=true variant="danger"}
                            {lang key='deleteAccount' section='login'}
                        {/button}
                    {/col}
                {/row}
            {/block}
        {/form}
    {/block}
{/block}
