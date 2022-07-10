{block name='page-free-gift'}
    {opcMountPoint id='opc_before_free_gift' inContainer=false}
    {container fluid=$Link->getIsFluid() class="page-freegift {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
        <p>{lang key='freeGiftFromOrderValue'}</p>
        {if !empty($oArtikelGeschenk_arr)}
            {opcMountPoint id='opc_before_free_gift_list'}
            {row id="freegift"}
                {block name='page-freegift-freegifts'}
                    {foreach $oArtikelGeschenk_arr as $oArtikelGeschenk}
                        {col sm=6 md=4 class="page-freegift-item"}
                            <label for="gift{$oArtikelGeschenk->kArtikel}">
                                {block name='page-freegift-freegift-image'}
                                    {link href=$oArtikelGeschenk->cURLFull}
                                        {include file='snippets/image.tpl'
                                            item=$oArtikelGeschenk
                                            square=false
                                            srcSize='sm'
                                            sizes='200px'}
                                    {/link}
                                {/block}
                                {block name='page-freegift-freegift-info'}
                                    <p class="small text-muted-util">{lang key='freeGiftFrom1'} {$oArtikelGeschenk->cBestellwert} {lang key='freeGiftFrom2'}</p>
                                {/block}
                                {block name='page-freegift-freegift-link'}
                                    <p>{link href=$oArtikelGeschenk->cURLFull}{$oArtikelGeschenk->cName}{/link}</p>
                                {/block}
                            </label>
                        {/col}
                    {/foreach}
                {/block}
            {/row}
        {/if}
    {/container}
{/block}
