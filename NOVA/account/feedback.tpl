{block name='account-feedback'}
    {block name='account-feedback-heading'}
        <h1>{lang key='allRatings'}</h1>
    {/block}
    {if empty($smarty.session.Kunde->kKunde)}
        {block name='account-feedback-alert-login'}
            {alert variant="danger"}{lang key='loginFirst' section='product rating'}{/alert}
        {/block}
    {elseif empty($bewertungen)}
        {block name='account-feedback-alert-feedback'}
            {alert variant="danger"}{lang key='no feedback' section='product rating'}{/alert}
        {/block}
    {else}
        {block name='account-feedback-ratings'}
            {foreach $bewertungen as $Bewertung}
                {card no-body=true class="account-feedback"}
                    {cardheader}
                        {block name='account-feedback-rating-header'}
                            <strong>{$Bewertung->cTitel}</strong> - {$Bewertung->dDatum}
                            {block name='account-feedback-include-rating'}
                                {include file='productdetails/rating.tpl' stars=$Bewertung->nSterne}
                            {/block}
                        {/block}
                    {/cardheader}
                    {cardbody}
                        {block name='account-feedback-rating-body'}
                            {block name='account-feedback-rating-body-rating'}
                                {$Bewertung->cText}
                                <span class="float-right">
                                    {link class="btn btn-sm btn-outline-primary"
                                        title="{lang key='edit' section='product rating'}"
                                        href="{get_static_route id='bewertung.php'}?a={$Bewertung->kArtikel}&bfa=1&token={$smarty.session.jtl_token}"}
                                        <span class="fa fa-pencil-alt"></span>
                                    {/link}
                                </span>
                            {/block}
                            {if !empty($Bewertung->cAntwort)}
                                {block name='account-feedback-rating-body-reply'}
                                    {card}
                                        <strong>{lang key='reply' section='product rating'} {$cShopName}:</strong>
                                        <hr>
                                        <blockquote>
                                            <p>{$Bewertung->cAntwort}</p>
                                            <small>{$Bewertung->dAntwortDatum}</small>
                                        </blockquote>
                                    {/card}
                                {/block}
                            {/if}
                        {/block}
                    {/cardbody}
                    {cardfooter}
                        {block name='account-feedback-rating-footer'}
                            {if !empty($Bewertung->fGuthabenBonus)}
                                {lang key='balance bonus' section='product rating'}: {$Bewertung->fGuthabenBonusLocalized}
                            {/if}
                            {if $Bewertung->nAktiv == 1}
                                {lang key='feedback activated' section='product rating'}
                            {else}
                                {lang key='feedback deactivated' section='product rating'}
                            {/if}
                        {/block}
                    {/cardfooter}
                {/card}
            {/foreach}
        {/block}
    {/if}
{/block}
