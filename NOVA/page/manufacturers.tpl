{block name='page-manufacturers'}
    {opcMountPoint id='opc_before_manufacturers' inContainer=false}
    {block name='page-manufacturers-content'}
        {container fluid=$Link->getIsFluid() class="page-manufacturers {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {row}
                {foreach $oHersteller_arr as $mft}
                    {col xl=3 md=4 sm=6}
                        {link href=$mft->cURL title=$mft->cMetaTitle|escape:'html'}
                                <div class="square square-image manufacturer-image-wrapper">
                                    <div class="inner">
                                        {if !empty($mft->getImage(\JTL\Media\Image::SIZE_MD))}
                                            {image fluid=true lazy=true webp=true
                                            src=$mft->getImage(\JTL\Media\Image::SIZE_MD)
                                            alt=$mft->getName()|escape:'html'}
                                        {/if}
                                    </div>
                                </div>
                            {$mft->getName()}
                        {/link}
                    {/col}
                {/foreach}
            {/row}
        {/container}
    {/block}
{/block}
