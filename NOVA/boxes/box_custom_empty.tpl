{block name='boxes-box-custom-empty'}
    <div class="box box-custom box-normal" id="sidebox{$oBox->getID()}">
        {block name='boxes-box-custom-empty-content'}
            <div class="box-content-wrapper">
                {eval var=$oBox->getContent()}
            </div>
        {/block}
    </div>
{/block}
