{block name='productdetails-question-on-item'}
    {if isset($fehlendeAngaben_fragezumprodukt)}
        {$fehlendeAngaben = $fehlendeAngaben_fragezumprodukt}
    {/if}
    {if isset($position) && $position === 'popup'}
        {if count($Artikelhinweise) > 0}
            {block name='productdetails-question-on-item-alert'}
                {alert dismissable=true variant="danger"}
                    {foreach $Artikelhinweise as $Artikelhinweis}
                        {$Artikelhinweis}
                    {/foreach}
                {/alert}
            {/block}
        {/if}
    {/if}
    {block name='productdetails-question-on-item-form'}
    {form action="{if !empty($Artikel->cURLFull)}{$Artikel->cURLFull}{if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'Y'}#tab-questionOnItem{/if}{else}{$ShopURL}/{/if}"
        method="post"
        id="article_question"
        class="jtl-validate"
        slide=true}
        {block name='productdetails-question-on-item-form-fieldset-contact'}
            <fieldset>
                {block name='productdetails-question-on-item-form-legend-contact'}
                    <legend>{lang key='contact'}</legend>
                {/block}
                {row}
                    {if $Einstellungen.artikeldetails.produktfrage_abfragen_anrede !== 'N'}
                        {block name='productdetails-question-on-item-form-salutation'}
                            {col cols=12 md=6}
                                {formgroup
                                    label-for="salutation"
                                    label="{lang key='salutation' section='account data'}{if $Einstellungen.artikeldetails.produktfrage_abfragen_anrede === 'O'}<span class='optional'> - {lang key='optional'}</span>{/if}"
                                }
                                    {select class='custom-select' name="anrede" id="salutation" placeholder="{lang key='emailadress'}" autocomplete="honorific-prefix" required=($Einstellungen.artikeldetails.produktfrage_abfragen_anrede === 'Y')}
                                        <option value="" {if $Einstellungen.artikeldetails.produktfrage_abfragen_anrede === 'Y'}disabled{/if} selected>
                                            {if $Einstellungen.artikeldetails.produktfrage_abfragen_anrede === 'Y'}{lang key='salutation' section='account data'}{else}{lang key='noSalutation'}{/if}
                                        </option>
                                        <option value="w" {if isset($Anfrage->cAnrede) && $Anfrage->cAnrede === 'w'}selected="selected"{/if}>{lang key='salutationW'}</option>
                                        <option value="m" {if isset($Anfrage->cAnrede) && $Anfrage->cAnrede === 'm'}selected="selected"{/if}>{lang key='salutationM'}</option>
                                    {/select}
                                {/formgroup}
                            {/col}
                        {/block}
                        <div class="w-100-util"></div>
                    {/if}

                    {if $Einstellungen.artikeldetails.produktfrage_abfragen_vorname !== 'N' || $Einstellungen.artikeldetails.produktfrage_abfragen_nachname !== 'N'}
                        {block name='productdetails-question-on-item-form-name'}
                            {if $Einstellungen.artikeldetails.produktfrage_abfragen_vorname !== 'N'}
                                {col cols=12 md=6}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            'text', 'firstName', 'vorname',
                                            {$Anfrage->cVorname|default:null}, {lang key='firstName' section='account data'},
                                            $Einstellungen.artikeldetails.produktfrage_abfragen_vorname, null, 'given-name'
                                        ]
                                    }
                                {/col}
                            {/if}

                            {if $Einstellungen.artikeldetails.produktfrage_abfragen_nachname !== 'N'}
                                {col cols=12 md=6}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            'text', 'lastName', 'nachname',
                                            {$Anfrage->cNachname|default:null}, {lang key='lastName' section='account data'},
                                            $Einstellungen.artikeldetails.produktfrage_abfragen_nachname, null, 'family-name'
                                        ]
                                    }
                                {/col}
                            {/if}
                        {/block}
                        <div class="w-100-util"></div>
                    {/if}

                    {if $Einstellungen.artikeldetails.produktfrage_abfragen_firma !== 'N'}
                        {block name='productdetails-question-on-item-form-firm'}
                            {col cols=12 md=6}
                                {include file='snippets/form_group_simple.tpl'
                                    options=[
                                        'text', 'company', 'firma',
                                        {$Anfrage->cFirma|default:null}, {lang key='firm' section='account data'},
                                        $Einstellungen.artikeldetails.produktfrage_abfragen_firma, null, 'organization'
                                    ]
                                }
                            {/col}
                        {/block}
                    {/if}

                    {block name='productdetails-question-on-item-form-email'}
                        {col cols=12}
                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'email', 'question_email', 'email',
                                    {$Anfrage->cMail|default:null}, {lang key='email' section='account data'},
                                    true, null, 'email'
                                ]
                            }
                        {/col}
                    {/block}
                    {if $Einstellungen.artikeldetails.produktfrage_abfragen_tel !== 'N' || $Einstellungen.artikeldetails.produktfrage_abfragen_mobil !== 'N'}
                        {block name='productdetails-question-on-item-form-mobil'}
                            {if $Einstellungen.artikeldetails.produktfrage_abfragen_tel !== 'N'}
                                {col cols=12 md=6}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            'tel', 'tel', 'tel',
                                            {$Anfrage->cTel|default:null}, {lang key='tel' section='account data'},
                                            $Einstellungen.artikeldetails.produktfrage_abfragen_tel, null, 'home tel'
                                        ]
                                    }
                                {/col}
                            {/if}

                            {if $Einstellungen.artikeldetails.produktfrage_abfragen_mobil !== 'N'}
                                {col cols=12 md=6}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            'tel', 'mobile', 'mobil',
                                            {$Anfrage->cMobil|default:null}, {lang key='mobile' section='account data'},
                                            $Einstellungen.artikeldetails.produktfrage_abfragen_mobil, null, 'mobile tel'
                                        ]
                                    }
                                {/col}
                            {/if}
                        {/block}
                    {/if}

                    {if $Einstellungen.artikeldetails.produktfrage_abfragen_fax !== 'N'}
                        {block name='productdetails-question-on-item-form-fax'}
                            {col md=6}
                                {include file='snippets/form_group_simple.tpl'
                                    options=[
                                        'tel', 'fax', 'fax',
                                        {$Anfrage->cMobil|default:null}, {lang key='fax' section='account data'},
                                        $Einstellungen.artikeldetails.produktfrage_abfragen_fax, null, 'fax tel'
                                    ]
                                }
                            {/col}
                        {/block}
                    {/if}
                {/row}
            </fieldset>
        {/block}
        {block name='productdetails-question-on-item-form-fieldset-product-question'}
        <fieldset>
            {block name='productdetails-question-on-item-form-legend-product-question'}
                <legend>{lang key='productQuestion' section='productDetails'}</legend>
            {/block}
            {block name='productdetails-question-on-item-form-textarea'}
                {formgroup label-for="question" label="{lang key='question' section='productDetails'}"}
                    {if isset($fehlendeAngaben_fragezumprodukt.nachricht) && $fehlendeAngaben_fragezumprodukt.nachricht > 0}
                        <div class="form-error-msg"><i class="fas fa-exclamation-triangle"></i> {if $fehlendeAngaben_fragezumprodukt.nachricht > 0}{lang key='fillOut'}{/if}</div>
                    {/if}
                    {textarea name="nachricht" id="question" rows="8" required=true placeholder=" " class="{if isset($fehlendeAngaben_fragezumprodukt.nachricht) && $fehlendeAngaben_fragezumprodukt.nachricht > 0}has-error{/if}"}{if isset($Anfrage)}{$Anfrage->cNachricht}{/if}{/textarea}
                {/formgroup}
            {/block}
            {block name='productdetails-question-on-item-form-include-checkbox'}
                {if isset($fehlendeAngaben_fragezumprodukt)}
                    {include file='snippets/checkbox.tpl' nAnzeigeOrt=$smarty.const.CHECKBOX_ORT_FRAGE_ZUM_PRODUKT cPlausi_arr=$fehlendeAngaben_fragezumprodukt cPost_arr=null}
                {else}
                    {include file='snippets/checkbox.tpl' nAnzeigeOrt=$smarty.const.CHECKBOX_ORT_FRAGE_ZUM_PRODUKT cPlausi_arr=null cPost_arr=null}
                {/if}
            {/block}

        </fieldset>
        {/block}
        {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
            isset($Einstellungen.artikeldetails.produktfrage_abfragen_captcha) && $Einstellungen.artikeldetails.produktfrage_abfragen_captcha !== 'N' && empty($smarty.session.Kunde->kKunde)}
            {block name='productdetails-question-on-item-form-captcha'}
                {row}
                    {col class="{if !empty($fehlendeAngaben_fragezumprodukt.captcha)}has-error{/if}"}
                        {captchaMarkup getBody=true}
                    {/col}
                {/row}
            {/block}
        {/if}

        {if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P' && isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
            {block name='productdetails-question-on-item-form-privacy'}
                <p class="privacy text-muted-util small">
                    {link href=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL() class="popup"}
                        {lang key='privacyNotice'}
                    {/link}
                </p>
            {/block}
        {/if}

        {block name='productdetails-question-on-item-form-submit'}
            {input type="hidden" name="a" value=$Artikel->kArtikel}
            {input type="hidden" name="show" value="1"}
            {input type="hidden" name="fragezumprodukt" value="1"}
            {row}
                {col md='auto' class="ml-auto-util"}
                    {button type="submit" value="1" variant="primary" block=true}
                        {lang key='sendQuestion' section='productDetails'}
                    {/button}
                {/col}
            {/row}
        {/block}
    {/form}
    {/block}
{/block}
