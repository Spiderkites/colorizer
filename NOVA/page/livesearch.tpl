{block name='page-livesearch'}
    {if count($LivesucheTop) > 0 || count($LivesucheLast) > 0}
        {opcMountPoint id='opc_before_livesearch' inContainer=false}
        {container class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {row id="livesearch" class="mt-4"}
                {block name='page-livesearch-top-searches'}
                    {col}
                        <div class="h2">{lang key='topsearch'}{$Einstellungen.sonstiges.sonstiges_livesuche_all_top_count}</div>
                        <ul class="list-unstyled">
                            {if count($LivesucheTop) > 0}
                                {foreach $LivesucheTop as $suche}
                                    <li class="my-2">
                                        {link href=$suche->cURL class="mr-1"}{$suche->cSuche}{/link},
                                        {lang key='matches'}: <span class="badge-pill badge-primary">{$suche->nAnzahlTreffer}</span>
                                    </li>
                                {/foreach}
                            {else}
                                <li class="my-2">{lang key='noDataAvailable'}</li>
                            {/if}
                        </ul>
                    {/col}
                {/block}
                {block name='page-livesearch-latest-searches'}
                    {col}
                        <div class="h2">{lang key='lastsearch'}</div>
                        <ul class="list-unstyled">
                            {if count($LivesucheLast) > 0}
                                {foreach $LivesucheLast as $suche}
                                    <li class="my-2">
                                        {link class="mr-1" href=$suche->cURL}{$suche->cSuche}{/link},
                                        {lang key='matches'}:<span class="badge-pill badge-primary">{$suche->nAnzahlTreffer}</span>
                                    </li>
                                {/foreach}
                            {else}
                                <li class="my-2">{lang key='noDataAvailable'}</li>
                            {/if}
                        </ul>
                    {/col}
                {/block}
            {/row}
        {/container}
    {/if}
{/block}
