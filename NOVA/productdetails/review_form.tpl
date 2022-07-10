{block name='productdetails-review-form'}
    {block name='productdetails-review-form-include-header'}
        {include file='layout/header.tpl'}
    {/block}
    {block name='productdetails-review-form-include-extension'}
        {include file='snippets/extension.tpl'}
    {/block}

    {block name='productdetails-review-form-content'}
        {container class="review-form {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {block name='productdetails-review-form-heading'}
                <h1>{lang key='productRating' section='product rating'}</h1>
            {/block}
            {block name='productdetails-review-form-form'}
                {form action="{get_static_route id='bewertung.php'}#tab-votes" class="jtl-validate" slide=true}
                    {block name='productdetails-review-form-alerts'}
                        {$alertList->displayAlertByKey('productNotBuyed')}
                        {$alertList->displayAlertByKey('loginFirst')}
                    {/block}
                    {if $ratingAllowed}
                        {block name='productdetails-review-form-form-main'}
                            {block name='productdetails-review-form-form-info'}
                                <div class="alert alert-info">{lang key='shareYourRatingGuidelines' section='product rating'}</div>
                            {/block}
                            {block name='productdetails-review-form-image-name'}
                                <div class="review-form-image">
                                    {include file='snippets/image.tpl' item=$Artikel square=false sizes='200px'}
                                    <span>{$Artikel->cName}</span>
                                </div>
                                <hr>
                            {/block}
                            {block name='productdetails-review-form-rating'}
                                {formgroup label-for="stars" label="{lang key='productRating' section='product rating'}"}
                                    {select name="nSterne" id="stars" class='custom-select' required=true}
                                        {$ratings = [5,4,3,2,1]}
                                        {foreach $ratings as $rating}
                                            <option value="{$rating}"{if isset($oBewertung->nSterne) && (int)$oBewertung->nSterne === $rating} selected{/if}>
                                                {$rating}
                                                {if (int)$rating === 1}
                                                    {lang key='starSingular' section='product rating'}
                                                {else}
                                                    {lang key='starPlural' section='product rating'}
                                                {/if}
                                            </option>
                                        {/foreach}
                                    {/select}
                                {/formgroup}
                            {/block}
                            {block name='productdetails-review-form-inputs'}
                                {formgroup label-for="headline" label="{lang key='headline' section='product rating'}"}
                                    {input type="text" name="cTitel" placeholder=" " value=$oBewertung->cTitel|default:'' id="headline" required=true}
                                {/formgroup}
                                {formgroup label-for="comment" label="{lang key='comment' section='product rating'}"}
                                    {textarea name="cText" cols="80" rows="8" id="comment" required=true placeholder=" "}{$oBewertung->cText|default:""}{/textarea}
                                {/formgroup}
                            {/block}
                        {/block}
                        {block name='productdetails-review-form-form-submit'}
                            {row class="review-form-buttons"}
                                {col cols=12 md=4 lg=3 class='ml-auto-util'}
                                    {input type="hidden" name="bfh" value="1"}
                                    {input type="hidden" name="a" value=$Artikel->kArtikel}
                                    {button type="submit" value="1" variant="primary" block=true}
                                        {lang key='submitRating' section='product rating'}
                                    {/button}
                                {/col}
                            {/row}
                        {/block}
                    {/if}
                {/form}
            {/block}
        {/container}
    {/block}

    {block name='productdetails-review-form-include-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
