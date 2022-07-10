{block name='productdetails-download'}
<div class="productdetails-download card-columns">
    {foreach $Artikel->oDownload_arr as $oDownload}
        {if isset($oDownload->oDownloadSprache)}
            {card title-text=$oDownload->oDownloadSprache->getName()}
                {row}
                    {block name='productdetails-download-description'}
                        {col cols=12}
                            {$oDownload->oDownloadSprache->getBeschreibung()}
                        {/col}
                    {/block}
                    {if $oDownload->hasPreview()}
                        {block name='productdetails-download-preview'}
                            {col cols=12}
                                {if $oDownload->getPreviewType() === 'music'}
                                    {block name='productdetails-download-preview-music'}
                                        <audio controls controlsList="nodownload" preload="none">
                                            <source src="{PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}" >
                                            Your browser does not support the audio element.
                                        </audio>
                                    {/block}
                                {elseif $oDownload->getPreviewType() === 'video'}
                                    {block name='productdetails-download-preview-video'}
                                        <video width="320" height="240" controls controlsList="nodownload" preload="none">
                                            <source src="{PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}" >
                                            Your browser does not support the video tag.
                                        </video>
                                    {/block}
                                {elseif $oDownload->getPreviewType() === 'image'}
                                    {block name='productdetails-download-preview-image'}
                                        {image src="{PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}"
                                             fluid=true alt=$oDownload->oDownloadSprache->getBeschreibung()|strip_tags}
                                    {/block}
                                {else}
                                    {block name='productdetails-download-preview-misc'}
                                        {link href="{PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}"
                                           title="{$oDownload->oDownloadSprache->getName()}" target="_blank"}
                                            {$oDownload->oDownloadSprache->getName()}
                                        {/link}
                                    {/block}
                                {/if}
                            {/col}
                        {/block}
                    {/if}
                {/row}
            {/card}
        {/if}
    {/foreach}
</div>
{/block}
