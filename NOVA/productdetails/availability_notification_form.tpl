{block name='productdetails-availability-notification-form'}
    {if isset($position) && $position === 'popup'}
        {if isset($Artikelhinweise) && count($Artikelhinweise) > 0}
            {block name='productdetails-availability-notification-form-alert'}
                {alert dismissable=true variant="danger"}
                    {foreach $Artikelhinweise as $Artikelhinweis}
                        {$Artikelhinweis}
                    {/foreach}
                {/alert}
            {/block}
        {/if}
    {/if}
    {block name='productdetails-availability-notification-form-form'}
        {form action="{if !empty($Artikel->cURLFull)}{$Artikel->cURLFull}{else}{$ShopURL}/{/if}"
            method="post" id="article_availability{$Artikel->kArtikel}"
            class="jtl-validate availability-notification-form"
            slide=true}
            {block name='productdetails-availability-notification-form-fieldset-contact'}
                <fieldset>
                    {block name='productdetails-availability-notification-form-legend-contact'}
                        <legend>{lang key='contact'}</legend>
                    {/block}
                    {if $Einstellungen.$tplscope.benachrichtigung_abfragen_vorname !== 'N' || $Einstellungen.$tplscope.benachrichtigung_abfragen_nachname !== 'N'}
                        {block name='productdetails-availability-notification-form-name'}
                            {row}
                                {if $Einstellungen.$tplscope.benachrichtigung_abfragen_vorname !== 'N'}
                                {col md=6}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            "text", "article_availability{$Artikel->kArtikel}_firstName", "vorname",
                                            {$Benachrichtigung->cVorname|default:null}, {lang key='firstName' section='account data'},
                                            $Einstellungen.$tplscope.benachrichtigung_abfragen_vorname|default:null, null, "given-name"
                                        ]
                                    }
                                {/col}
                                {/if}

                                {if $Einstellungen.$tplscope.benachrichtigung_abfragen_nachname !== 'N'}
                                {col md=6}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            "text", "article_availability{$Artikel->kArtikel}_lastName", "nachname",
                                            {$Benachrichtigung->cNachname|default:null}, {lang key='lastName' section='account data'},
                                            $Einstellungen.$tplscope.benachrichtigung_abfragen_nachname|default:null, null, "family-name"
                                        ]
                                    }
                                {/col}
                                {/if}
                            {/row}
                        {/block}
                    {/if}
                    {block name='productdetails-availability-notification-form-email'}
                        {row}
                            {col md=6}
                                {include file='snippets/form_group_simple.tpl'
                                    options=[
                                        "email", "article_availability{$Artikel->kArtikel}_email", "email",
                                        {$Benachrichtigung->cMail|default:null}, {lang key='email' section='account data'},
                                        true, $fehlendeAngaben_benachrichtigung.email|default:null, "email"
                                    ]
                                }
                            {/col}
                        {/row}
                    {/block}
                    {block name='productdetails-availability-notification-form-include-checkbox'}
                        {if isset($fehlendeAngaben_benachrichtigung)}
                            {include file='snippets/checkbox.tpl' nAnzeigeOrt=$smarty.const.CHECKBOX_ORT_FRAGE_VERFUEGBARKEIT cPlausi_arr=$fehlendeAngaben_benachrichtigung cPost_arr=null}
                        {else}
                            {include file='snippets/checkbox.tpl' nAnzeigeOrt=$smarty.const.CHECKBOX_ORT_FRAGE_VERFUEGBARKEIT cPlausi_arr=null cPost_arr=null cIDPrefix="article_availability{$Artikel->kArtikel}"}
                        {/if}
                    {/block}
                </fieldset>
            {/block}
            {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
                isset($Einstellungen.$tplscope.benachrichtigung_abfragen_captcha) && $Einstellungen.$tplscope.benachrichtigung_abfragen_captcha !== 'N' && empty($smarty.session.Kunde->kKunde)}
                {block name='productdetails-availability-notification-form-captcha'}
                    <hr>
                    {row}
                        {col class="{if !empty($fehlendeAngaben_benachrichtigung.captcha)}has-error{/if}"}
                            {captchaMarkup getBody=true}
                            <hr>
                        {/col}
                    {/row}
                {/block}
            {/if}
            {block name='productdetails-availability-notification-form-submit'}
                {input type="hidden" name="a" value="{if $Artikel->kVariKindArtikel}{$Artikel->kVariKindArtikel}{else}{$Artikel->kArtikel}{/if}"}
                {input type="hidden" name="show" value="1"}
                {input type="hidden" name="benachrichtigung_verfuegbarkeit" value="1"}
                {row}
                    {col cols=12 md="auto"}
                        {button type="submit" value="1" variant="primary" block=true}
                            {lang key='requestNotification'}
                        {/button}
                    {/col}
                {/row}
            {/block}
        {/form}
    {/block}
{/block}
