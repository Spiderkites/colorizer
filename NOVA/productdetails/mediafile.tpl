{block name='productdetails-mediafile'}
    {if !empty($Artikel->oMedienDatei_arr)}
        {assign var=mp3List value=false}
        {assign var=titles value=false}
        <div class="mediafiles card-columns {if $mediaType->count < 3}card-columns-2{/if}">
        {foreach $Artikel->oMedienDatei_arr as $oMedienDatei}
            {if ($mediaType->name == $oMedienDatei->cMedienTyp && $oMedienDatei->cAttributTab|count_characters == 0)
            || ($oMedienDatei->cAttributTab|count_characters > 0 && $mediaType->name == $oMedienDatei->cAttributTab)}
                {if $oMedienDatei->nErreichbar == 0}
                    {block name='productdetails-mediafilealert'}
                        {col class="mediafiles-no-media"}
                            {alert variant="danger"}
                                {lang key='noMediaFile' section='errorMessages'}
                            {/alert}
                        {/col}
                    {/block}
                {else}
                    {assign var=cName value=$oMedienDatei->cName}
                    {assign var=titles value=$titles|cat:$cName}
                    {if !$oMedienDatei@last}
                        {assign var=titles value=$titles|cat:'|'}
                    {/if}

                    {* Images *}
                    {if $oMedienDatei->nMedienTyp === 1}
                        {block name='productdetails-mediafile-images'}
                            {$cMediaAltAttr = ""}
                            {if isset($oMedienDatei->oMedienDateiAttribut_arr) && $oMedienDatei->oMedienDateiAttribut_arr|@count > 0}
                                {foreach $oMedienDatei->oMedienDateiAttribut_arr as $oAttribut}
                                    {if $oAttribut->cName === 'img_alt'}
                                        {assign var=cMediaAltAttr value=$oAttribut->cWert}
                                    {/if}
                                {/foreach}
                            {/if}
                            {card class="mediafiles-image" img-src="{if !empty($oMedienDatei->cPfad)}{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}{elseif !empty($oMedienDatei->cURL)}{$oMedienDatei->cURL}{/if}" title-text="{$oMedienDatei->cName}" img-top=true img-alt="{$cMediaAltAttr}"}
                                <p>{$oMedienDatei->cBeschreibung}</p>
                            {/card}
                        {/block}
                        {* Audio *}
                    {elseif $oMedienDatei->nMedienTyp === 2}
                        {if $oMedienDatei->cName|strlen > 1}
                            {block name='productdetails-mediafile-audio'}
                                {card class="mediafiles-audio" title-text=$oMedienDatei->cName}
                                    {row}
                                        {col class="mediafiles-description" cols=12}
                                            {$oMedienDatei->cBeschreibung}
                                        {/col}
                                        {col cols=12}
                                            {if $oMedienDatei->cPfad|strlen > 1 || $oMedienDatei->cURL|strlen > 1}
                                                {assign var=audiosrc value=$oMedienDatei->cURL}
                                                {if $oMedienDatei->cPfad|strlen > 1}
                                                    {assign var=audiosrc value=$ShopURL|cat:'/':$smarty.const.PFAD_MEDIAFILES:$oMedienDatei->cPfad}
                                                {/if}
                                                {if $audiosrc|strlen > 1}
                                                    <audio controls controlsList="nodownload">
                                                        <source src="{$audiosrc}" type="audio/mpeg">
                                                        {lang key='audioTagNotSupported' section='errorMessages'}
                                                    </audio>
                                                {/if}
                                            {/if}
                                        {/col}
                                    {/row}
                                {/card}
                            {/block}
                        {/if}

                    {* Video *}
                    {elseif $oMedienDatei->nMedienTyp === 3}
                        {block name='productdetails-mediafile-video'}
                            {if ($oMedienDatei->videoType === 'mp4'
                            || $oMedienDatei->videoType === 'webm'
                            || $oMedienDatei->videoType === 'ogg')}
                                {card class="mediafiles-video" title-text=$oMedienDatei->cName}
                                    {row}
                                        {col class="mediafiles-description" cols=12}
                                            {$oMedienDatei->cBeschreibung}
                                        {/col}
                                        {col cols=12}
                                            <video class="product-detail-video mw-100" controls>
                                                <source src="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" type="video/{$oMedienDatei->videoType}">
                                                {lang key='videoTagNotSupported' section='errorMessages'}
                                            </video>
                                        {/col}
                                    {/row}
                                {/card}
                            {else}
                                {lang key='videoTypeNotSupported' section='errorMessages'}
                            {/if}
                        {/block}
                    {* Sonstiges *}
                    {elseif $oMedienDatei->nMedienTyp === 4}
                        {block name='productdetails-mediafile-misc'}
                            {card class="mediafiles-misc" title-text=$oMedienDatei->cName}
                                {row}
                                    {col class="mediafiles-description" cols=12}
                                        {$oMedienDatei->cBeschreibung}
                                    {/col}
                                    {col cols=12}
                                        {if $oMedienDatei->cURL|strpos:'youtube' !== false || $oMedienDatei->cURL|strpos:'youtu.be' !== false}
                                            {include file='productdetails/mediafile_youtube_embed.tpl'}
                                        {else}
                                            {if isset($oMedienDatei->oEmbed) && $oMedienDatei->oEmbed->code}
                                                {$oMedienDatei->oEmbed->code}
                                            {/if}
                                            {if !empty($oMedienDatei->cPfad)}
                                                <p>
                                                    {link href="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" target="_blank"}{$oMedienDatei->cName}{/link}
                                                </p>
                                            {elseif !empty($oMedienDatei->cURL)}
                                                <p>
                                                    {link href=$oMedienDatei->cURL target="_blank"}<i class="fa fa-external-link"></i> {$oMedienDatei->cName}{/link}
                                                </p>
                                            {/if}
                                        {/if}
                                    {/col}
                                {/row}
                            {/card}
                        {/block}
                        {* PDF *}
                    {elseif $oMedienDatei->nMedienTyp == 5}
                        {block name='productdetails-mediafile-pdf'}
                            {card class="mediafiles-pdf" title-text=$oMedienDatei->cName}
                                {row}
                                    {col class="mediafiles-description" md=6}
                                        {$oMedienDatei->cBeschreibung}
                                    {/col}
                                    {col md=6}
                                        {if !empty($oMedienDatei->cPfad)}
                                            {link class="text-decoration-none-util"
                                                href="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}"
                                                target="_blank"
                                            }
                                                {image alt="PDF" src="{$smarty.const.PFAD_BILDER}intern/file-pdf.png"}
                                                <span class="text-decoration-underline" >{$oMedienDatei->cName}</span>
                                            {/link}
                                        {elseif !empty($oMedienDatei->cURL)}
                                            {link class="text-decoration-none-util" href=$oMedienDatei->cURL target="_blank"}
                                                {image alt="PDF" src="{$smarty.const.PFAD_BILDER}intern/file-pdf.png"}
                                                <span class="text-decoration-underline">{$oMedienDatei->cName}</span>
                                            {/link}
                                        {/if}
                                    {/col}
                                {/row}
                            {/card}
                        {/block}
                    {/if}
                {/if}
            {/if}
        {/foreach}
        </div>
    {/if}
{/block}
