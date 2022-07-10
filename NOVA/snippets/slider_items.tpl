{block name='snippets-slider-items'}
    {foreach $items as $item}
        {if $type === 'product'}
            {block name='snippets-slider-items-product'}
                <div class="product-wrapper product-wrapper-product text-center-util {if $item@first && $item@last} m-auto{elseif $item@first} ml-auto-util {elseif $item@last} mr-auto {/if}{if isset($style)} {$style}{/if}" {if $tplscope !== 'box'}{if isset($Link) && $Link->getLinkType() === $smarty.const.LINKTYP_STARTSEITE || $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}itemprop="about"{else}itemprop="isRelatedTo"{/if} itemscope itemtype="https://schema.org/Product"{/if}>
                    {include file='productlist/item_slider.tpl' Artikel=$item tplscope=$tplscope}
                </div>
            {/block}
        {elseif $type === 'news'}
            {block name='snippets-slider-items-news'}
                <div class="product-wrapper product-wrapper-news
                            {if $item@first && $item@last}
                                mx-auto
                            {elseif $item@first}
                                ml-auto-util
                            {elseif $item@last}
                                mr-auto
                            {/if}">
                    {include file='blog/preview.tpl' newsItem=$item}
                </div>
            {/block}
        {elseif $type === 'freegift'}
            <div class="product-wrapper product-wrapper-freegift {if $item@first && $item@last} m-auto {elseif $item@first} ml-auto-util {elseif $item@last} mr-auto {/if}freegift">
                <div class="custom-control custom-radio">
                    <input class="custom-control-input " type="radio" id="gift{$item->kArtikel}" name="gratisgeschenk" value="{$item->kArtikel}" onclick="submit();">
                    <label for="gift{$item->kArtikel}" class="custom-control-label {if $selectedFreegift===$item->kArtikel}badge-check{/if}">
                        {if $selectedFreegift===$item->kArtikel}{badge class="badge-circle"}<i class="fas fa-check mx-auto"></i>{/badge}{/if}
                        <div class="square square-image">
                            <div class="inner">
                                {image lazy=true
                                    webp=true
                                    src=$item->Bilder[0]->cURLKlein
                                    fluid=true
                                    alt=$item->cName}
                            </div>
                        </div>
                        <div class="caption">
                            <p class="small text-muted-util">{lang key='freeGiftFrom1'} {$item->cBestellwert} {lang key='freeGiftFrom2'}</p>
                            <p>{link href=$item->cURLFull}{$item->cName}{/link}</p>
                        </div>
                    </label>
                </div>
            </div>
        {/if}
    {/foreach}
{/block}
