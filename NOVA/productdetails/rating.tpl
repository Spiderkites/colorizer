{block name='productdetails-rating'}
    {if $stars > 0}
        {if isset($total) && $total > 1}
            {lang key='averageProductRating' section='product rating' assign='ratingLabelText'}
        {else}
            {lang key='productRating' section='product rating' assign='ratingLabelText'}
        {/if}
        {block name='productdetails-rating-main'}
        {if isset($link)}
            <a class="rating" href="{$link}#tab-votes" title="{$ratingLabelText}: {$stars}/5" aria-label={lang key='Votes'}>
        {else}
            <span class="rating" title="{$ratingLabelText}: {$stars}/5">
        {/if}
        {strip}
            {if $stars >= 5}
                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
            {elseif $stars >= 4}
                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                {if $stars > 4}
                    <i class="fas fa-star-half-alt"></i>
                {else}
                    <i class="far fa-star"></i>
                {/if}
            {elseif $stars >= 3}
                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                {if $stars > 3}
                    <i class="fas fa-star-half-alt"></i><i class="far fa-star"></i>
                {else}
                    <i class="far fa-star"></i><i class="far fa-star"></i>
                {/if}
            {elseif $stars >= 2}
                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                {if $stars > 2}
                    <i class="fas fa-star-half-alt"></i><i class="far fa-star-"></i><i class="far fa-star"></i>
                {else}
                    <i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                {/if}
            {elseif $stars >= 1}
                <i class="fas fa-star"></i>
                {if $stars > 1}
                    <i class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                {else}
                    <i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                {/if}
            {elseif $stars > 0}
                <i class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            {/if}
        {/strip}

        {if isset($link)}
            </a>
        {else}
            </span>
        {/if}
        {/block}
    {/if}
{/block}
