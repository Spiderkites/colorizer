{block name='snippets-suggestion'}
    <div class="snippets-suggestion">
        {link href="{get_static_route id='index.php'}?qs={$result->keyword}"}
            {$result->keyword} {badge variant="primary" class="float-right"}{$result->quantity}{/badge}
        {/link}
    </div>
{/block}
