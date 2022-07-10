{block name='productlist-item-slider'}
    {block name='productlist-item-slider-link'}
        {link href=$Artikel->cURLFull}
            <div class="item-slider productbox-image square square-image">
                <div class="inner">
                    {if isset($Artikel->Bilder[0]->cAltAttribut)}
                        {assign var=alt value=$Artikel->Bilder[0]->cAltAttribut|truncate:60}
                    {else}
                        {assign var=alt value=$Artikel->cName}
                    {/if}
                    {block name='productlist-item-slider-image'}
                        {include file='snippets/image.tpl' item=$Artikel square=false srcSize='sm' class='product-image'}
                    {/block}
                    {if $tplscope !== 'box'}
                        <meta itemprop="image" content="{$Artikel->Bilder[0]->cURLNormal}">
                        <meta itemprop="url" content="{$Artikel->cURLFull}">
                    {/if}
                </div>
            </div>
        {/link}
    {/block}
    {block name='productlist-item-slider-caption'}
        {block name='productlist-item-slider-caption-short-desc'}
            {link href=$Artikel->cURLFull}
                <span class="item-slider-desc text-clamp-2">
                    {if isset($showPartsList) && $showPartsList === true && isset($Artikel->fAnzahl_stueckliste)}
                        {block name='productlist-item-slider-caption-bundle'}
                            {$Artikel->fAnzahl_stueckliste}x
                        {/block}
                    {/if}
                    <span {if $tplscope !== 'box'}itemprop="name"{/if}>{$Artikel->cKurzbezeichnung}</span>
                </span>
            {/link}
        {/block}
        {if $tplscope === 'box'}
            {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}
                {block name='productlist-item-slider-include-rating'}
                    <small class="item-slider-rating">{include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung link=$Artikel->cURLFull}</small>
                {/block}
            {/if}
        {/if}
        {block name='productlist-item-slider-include-price'}
            <div class="item-slider-price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                {include file='productdetails/price.tpl' Artikel=$Artikel tplscope=$tplscope}
            </div>
        {/block}
    {/block}
{/block}
