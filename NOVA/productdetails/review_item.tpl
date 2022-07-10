{block name='productdetails-review-item'}
    {row id="comment{$oBewertung->kBewertung}" class="review-comment {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y' && isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde > 0 && $smarty.session.Kunde->kKunde != $oBewertung->kKunde}use_helpful{/if} {if isset($bMostUseful) && $bMostUseful}most_useful{/if}"}
        {block name='productdetails-review-itme-helpful'}
            {if $oBewertung->nHilfreich > 0}
            {col cols=12 class="review-helpful-total"}
                <small class="text-muted-util">
                    {if $oBewertung->nHilfreich > 0}
                        {$oBewertung->nHilfreich}
                    {else}
                        {lang key='nobody' section='product rating'}
                    {/if}
                    {lang key='from' section='product rating'} {$oBewertung->nAnzahlHilfreich}
                    {if $oBewertung->nAnzahlHilfreich > 1}
                        {lang key='ratingHelpfulCount' section='product rating'}
                    {else}
                        {lang key='ratingHelpfulCountExt' section='product rating'}
                    {/if}
                </small>
            {/col}
            {/if}
        {/block}
        {block name='productdetails-review-item-content'}
            {col cols=12}
                {row itemprop="review" itemscope=true itemtype="https://schema.org/Review"}
                    {block name='productdetails-review-item-title'}
                        <span itemprop="name" class="d-none">{$oBewertung->cTitel}</span>
                    {/block}
                    {block name='productdetails-review-item-review'}
                        {col class="col-auto text-center-util" itemprop="reviewRating" itemscope=true itemtype="https://schema.org/Rating"}
                            {block name='productdetails-review-item-rating'}
                                {block name='productdetails-review-item-include-rating'}
                                    {include file='productdetails/rating.tpl' stars=$oBewertung->nSterne}
                                {/block}
                                <small class="d-none">
                                    <span itemprop="ratingValue">{$oBewertung->nSterne}</span> {lang key='from'}
                                    <span itemprop="bestRating">5</span>
                                    <meta itemprop="worstRating" content="1">
                                </small>
                            {/block}
                            {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y'}
                                {if isset($smarty.session.Kunde) && $smarty.session.Kunde->kKunde > 0 && $smarty.session.Kunde->kKunde != $oBewertung->kKunde}
                                    {block name='productdetails-review-item-buttons'}
                                        {formrow class="review-helpful" id="help{$oBewertung->kBewertung}"}
                                            {col}
                                                {button size="sm"
                                                    class="btn-icon btn-icon-primary js-helpful badge-circle-1 badge-circle-no-sizes {if (int)$oBewertung->rated === 1}on-list{/if}"
                                                    title="{lang key='yes'}"
                                                    name="hilfreich_{$oBewertung->kBewertung}"
                                                    type="submit"
                                                    variant="icon-primary"
                                                    data=["review-id"=>{$oBewertung->kBewertung}]}
                                                    <i class="far fa-thumbs-up"></i>
                                                {/button}
                                                <b><span class="d-block" data-review-count-id="hilfreich_{$oBewertung->kBewertung}">{$oBewertung->nHilfreich}</span></b>
                                            {/col}
                                            {col}
                                                {button size="sm"
                                                    class="btn-icon js-helpful badge-circle-1 badge-circle-no-sizes {if $oBewertung->rated !== null && (int)$oBewertung->rated === 0}on-list{/if}"
                                                    title="{lang key='no'}"
                                                    name="nichthilfreich_{$oBewertung->kBewertung}"
                                                    type="submit"
                                                    variant="icon-primary"
                                                    data=["review-id"=>{$oBewertung->kBewertung}]}
                                                    <i class="far fa-thumbs-down"></i>
                                                {/button}
                                                <b><span class="d-block" data-review-count-id="nichthilfreich_{$oBewertung->kBewertung}">{$oBewertung->nNichtHilfreich}</span></b>
                                            {/col}
                                        {/formrow}
                                    {/block}
                                {/if}
                            {/if}
                        {/col}
                    {/block}
                    {block name='productdetails-review-item-details'}
                        {col}
                            <blockquote>
                                <span class="subheadline">{$oBewertung->cTitel}</span>
                                <p itemprop="reviewBody">{$oBewertung->cText|nl2br}</p>
                                <div class="blockquote-footer">
                                    <span itemprop="author" itemscope=true itemtype="https://schema.org/Person">
                                        <span itemprop="name">{$oBewertung->cName}</span>
                                    </span>,
                                    <meta itemprop="datePublished" content="{$oBewertung->dDatum}" />{$oBewertung->Datum}
                                </div>
                            </blockquote>
                            <meta itemprop="thumbnailURL" content="{$Artikel->cVorschaubildURL}">
                            {if !empty($oBewertung->cAntwort)}
                                <div class="review-reply">
                                    <span class="subheadline">{lang key='reply' section='product rating'} {$cShopName}:</span>
                                    <blockquote>
                                        <p>{$oBewertung->cAntwort}</p>
                                        <div class="blockquote-footer">{$oBewertung->AntwortDatum}</div>
                                    </blockquote>
                                </div>
                            {/if}
                        {/col}
                    {/block}
                {/row}
            {/col}
        {/block}
    {/row}
{/block}
