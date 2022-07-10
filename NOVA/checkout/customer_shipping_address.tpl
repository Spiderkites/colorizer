{block name='checkout-customer-shipping-address'}
    <fieldset>
    {formrow class="customer-shipping-address"}
        {$name = 'shipping_address'}
        {* salutation / title *}
        {block name='checkout-customer-shipping-address-salutation-title'}
            {if $Einstellungen.kunden.lieferadresse_abfragen_anrede !== 'N'}
                {col cols=12 md=6}
                    {block name='checkout-customer-shipping-address-salutation'}
                        {formgroup
                            class="{if !empty($fehlendeAngaben.anrede)} has-error{/if}"
                            label="{lang key='salutation' section='account data'}{if $Einstellungen.kunden.lieferadresse_abfragen_anrede === 'O'}<span class='optional'> - {lang key='optional'}</span>{/if}"
                            label-for="{$prefix}-{$name}-salutation"
                        }
                            {if !empty($fehlendeAngaben.anrede)}
                                <div class="form-error-msg">{lang key='fillOut'}</div>
                            {/if}
                            {select name="{$prefix}[{$name}][anrede]" id="{$prefix}-{$name}-salutation" class='custom-select' required=($Einstellungen.kunden.lieferadresse_abfragen_anrede === 'Y') autocomplete="shipping sex"}
                                <option value="" selected="selected" {if $Einstellungen.kunden.lieferadresse_abfragen_anrede === 'Y'}disabled{/if}>
                                    {if $Einstellungen.kunden.lieferadresse_abfragen_anrede === 'Y'}{lang key='salutation' section='account data'}{else}{lang key='noSalutation'}{/if}
                                </option>
                                <option value="w"{if isset($Lieferadresse->cAnrede) && $Lieferadresse->cAnrede === 'w'} selected="selected"{/if}>{lang key='salutationW'}</option>
                                <option value="m"{if isset($Lieferadresse->cAnrede) && $Lieferadresse->cAnrede === 'm'} selected="selected"{/if}>{lang key='salutationM'}</option>
                            {/select}
                        {/formgroup}
                    {/block}
                {/col}
            {/if}
            {if $Einstellungen.kunden.lieferadresse_abfragen_titel !== 'N'}
                {col cols=12 md=6}
                    {block name='checkout-customer-shipping-address-title-prefix'}
                        {include file='snippets/form_group_simple.tpl'
                            options=[
                                "text", "{$prefix}-{$name}-title", "{$prefix}[{$name}][titel]",
                                {$Lieferadresse->cTitel|default:null},
                                {lang key='title' section='account data'}, {$Einstellungen.kunden.lieferadresse_abfragen_titel},
                                null, "shipping honorific-prefix"
                            ]
                        }
                    {/block}
                {/col}
            {/if}
            <div class="w-100-util"></div>
        {/block}

        {* firstname lastname *}
        {block name='checkout-customer-shipping-address-firstname-lastname'}
            {col cols=12 md=6}
                {block name='checkout-customer-shipping-address-first-name'}
                    {include file='snippets/form_group_simple.tpl'
                        options=[
                            "text", "{$prefix}-{$name}-firstName", "{$prefix}[{$name}][vorname]",
                            {$Lieferadresse->cVorname|default:null}, {lang key='firstName' section='account data'},
                            {$Einstellungen.kunden.kundenregistrierung_pflicht_vorname},
                            null, "shipping given-name"
                        ]
                    }
                {/block}
            {/col}
            {col cols=12 md=6}
                {block name='checkout-customer-shipping-address-last-name'}
                    {include file='snippets/form_group_simple.tpl'
                        options=[
                            "text", "{$prefix}-{$name}-lastName", "{$prefix}[{$name}][nachname]",
                            {$Lieferadresse->cNachname|default:null}, {lang key='lastName' section='account data'},
                            true, null, "shipping family-name"
                        ]
                    }
                {/block}
            {/col}
            <div class="w-100-util"></div>
        {/block}

        {* firm / firmtext *}
        {block name='checkout-customer-shipping-address-company-wrap'}
            {if $Einstellungen.kunden.lieferadresse_abfragen_firma !== 'N'}
                {col cols=12 md=6}
                    {block name='checkout-customer-shipping-address-company'}
                        {include file='snippets/form_group_simple.tpl'
                            options=[
                                "text", "{$prefix}-{$name}-firm", "{$prefix}[{$name}][firma]",
                                {$Lieferadresse->cFirma|default:null}, {lang key='firm' section='account data'},
                                $Einstellungen.kunden.lieferadresse_abfragen_firma, null, "shipping organization"
                            ]
                        }
                    {/block}
                {/col}
            {/if}
            {if $Einstellungen.kunden.lieferadresse_abfragen_firmazusatz !== 'N'}
                {col cols=12 md=6}
                    {block name='checkout-customer-shipping-address-company-additional'}
                        {include file='snippets/form_group_simple.tpl'
                            options=[
                                "text", "{$prefix}-{$name}-firmext", "{$prefix}[{$name}][firmazusatz]",
                                {$Lieferadresse->cZusatz|default:null}, {lang key='firmext' section='account data'},
                                $Einstellungen.kunden.lieferadresse_abfragen_firmazusatz
                            ]
                        }
                    {/block}
                {/col}
            {/if}
            <div class="w-100-util"></div>
        {/block}

        {* street / number *}
        {block name='checkout-customer-shipping-address-street-wrap'}
            {col cols=12 md=8}
                {block name='checkout-customer-shipping-address-street'}
                    {include file='snippets/form_group_simple.tpl'
                        options=[
                            "text", "{$prefix}-{$name}-street", "{$prefix}[{$name}][strasse]",
                            {$Lieferadresse->cStrasse|default:null}, {lang key='street' section='account data'},
                            true, null, "shipping address-line1"
                        ]
                    }
                {/block}
            {/col}
            {col cols=12 md=4}
                {block name='checkout-customer-shipping-address-street-number'}
                    {include file='snippets/form_group_simple.tpl'
                        options=[
                            "text", "{$prefix}-{$name}-streetnumber", "{$prefix}[{$name}][hausnummer]",
                            {$Lieferadresse->cHausnummer|default:null}, {lang key='streetnumber' section='account data'},
                            true, null, "shipping address-line2"
                        ]
                    }
                {/block}
            {/col}
            <div class="w-100-util"></div>
        {/block}

        {* address addition *}
        {if $Einstellungen.kunden.lieferadresse_abfragen_adresszusatz !== 'N'}
            {block name='checkout-customer-shipping-address-addition'}
                {col cols=12 md=6}
                    {block name='checkout-customer-shipping-address-street-additional'}
                        {include file='snippets/form_group_simple.tpl'
                            options=[
                                "text", "{$prefix}-{$name}-street2", "{$prefix}[{$name}][adresszusatz]",
                                {$Lieferadresse->cAdressZusatz|default:null}, {lang key='street2' section='account data'},
                                $Einstellungen.kunden.lieferadresse_abfragen_adresszusatz, null, "shipping address-line3"
                            ]
                        }
                    {/block}
                {/col}
            {/block}
            <div class="w-100-util"></div>
        {/if}

        {* country *}
        {if isset($Lieferadresse->cLand)}
            {$countryISO=$Lieferadresse->cLand}
        {elseif !empty($smarty.session.preferredDeliveryCountryCode)}
            {$countryISO=$smarty.session.preferredDeliveryCountryCode}
        {elseif !empty($Kunde->cLand)}
            {$countryISO=$Kunde->cLand}
        {elseif !empty($Einstellungen.kunden.lieferadresse_abfragen_standardland)}
            {$countryISO=$Einstellungen.kunden.lieferadresse_abfragen_standardland}
        {else}
            {$countryISO=$shippingCountry}
        {/if}
        {getCountry iso=$countryISO assign='selectedCountry'}
        {block name='checkout-customer-shipping-address-country-wrap'}
            {col cols=12}
                {block name='checkout-customer-shipping-address-country'}
                    {formgroup label="{lang key='country' section='account data'}" label-for="{$prefix}-{$name}-country"}
                        {select name="{$prefix}[{$name}][land]" id="{$prefix}-{$name}-country" class="country-input custom-select js-country-select" autocomplete="shipping country"}
                            <option value="" selected disabled>{lang key='country' section='account data'}</option>
                            {foreach $LieferLaender as $land}
                                {if $land->isShippingAvailable()}
                                    <option value="{$land->getISO()}" {if $countryISO === $land->getISO()}selected="selected"{/if}>{$land->getName()}</option>
                                {/if}
                            {/foreach}
                        {/select}
                    {/formgroup}
                {/block}
            {/col}
            {if $Einstellungen.kunden.lieferadresse_abfragen_bundesland !== 'N'}
                {getStates cIso=$countryISO assign='oShippingStates'}
                {if isset($Lieferadresse->cBundesland)}
                    {assign var=cState value=$Lieferadresse->cBundesland}
                {elseif !empty($Kunde->cBundesland)}
                    {assign var=cState value=$Kunde->cBundesland}
                {else}
                    {assign var=cState value=''}
                {/if}
                {col cols=12}
                    {block name='checkout-customer-shipping-address-state'}
                        {formgroup
                            class="{if isset($fehlendeAngaben.bundesland)} has-error{/if}"
                            label="{lang key='state' section='account data'}<span class='state-optional optional {if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y' || $selectedCountry->isRequireStateDefinition()}d-none{/if}'> - {lang key='optional'}</span>"
                            label-for="{$prefix}-{$name}-state"
                        }
                            {if !empty($oShippingStates)}
                                {select
                                        name="{$prefix}[{$name}][bundesland]"
                                        id="{$prefix}-{$name}-state"
                                        class="state-input custom-select js-state-select"
                                        data=["defaultoption"=>{lang key=pleaseChoose}]
                                        autocomplete="shipping address-level1"
                                        required=($Einstellungen.kunden.lieferadresse_abfragen_bundesland === 'Y' || $selectedCountry->isRequireStateDefinition())
                                }
                                    <option value="" selected disabled>{lang key='pleaseChoose'}</option>
                                    {foreach $oShippingStates as $oState}
                                        <option value="{$oState->cCode}" {if $cState === $oState->cName || $cState === $oState->cCode}selected{/if}>{$oState->cName}</option>
                                    {/foreach}
                                {/select}
                            {else}
                                {input
                                    type="text"
                                    name="{$prefix}[{$name}][bundesland]"
                                    value="{if isset($Lieferadresse->cBundesland)}{$Lieferadresse->cBundesland}{/if}"
                                    id="{$prefix}-{$name}-state"
                                    data=[
                                        "toggle"=>"state",
                                        "defaultoption"=>{lang key=pleaseChoose},
                                        "target"=>"#{$prefix}-{$name}-country"
                                    ]
                                    placeholder="{lang key='state' section='account data'}"
                                    required=($Einstellungen.kunden.lieferadresse_abfragen_bundesland === 'Y')
                                    autocomplete="shipping address-level1"}
                            {/if}

                            {if !empty($fehlendeAngaben.bundesland)}
                                <div class="form-error-msg">{lang key='fillOut'}</div>
                            {/if}
                        {/formgroup}
                    {/block}
                {/col}
            {/if}
        {/block}

        {* zip / city *}
        {block name='checkout-customer-shipping-address-city-wrap'}
            {col cols=12 md=4}
                {block name='checkout-customer-shipping-address-zip'}
                    {formgroup
                        class="{if !empty($fehlendeAngaben.plz)} has-error{/if} postcode-wrapper"
                        label="{lang key='plz' section='account data'}"
                        label-for="{$prefix}-{$name}-postcode"
                    }
                        {if isset($fehlendeAngaben.plz)}
                            <div class="form-error-msg"><i class="fa fa-exclamation-triangle"></i>
                                {if $fehlendeAngaben.plz >= 2}
                                    {lang key='checkPLZCity' section='checkout'}
                                {else}
                                    {lang key='fillOut'}
                                {/if}
                            </div>
                        {/if}
                        {input
                            type="text"
                            name="{$prefix}[{$name}][plz]"
                            value="{if isset($Lieferadresse->cPLZ)}{$Lieferadresse->cPLZ}{/if}"
                            id="{$prefix}-{$name}-postcode"
                            class="postcode_input"
                            placeholder=" "
                            data-toggle="postcode"
                            data-city="#{$prefix}-{$name}-city"
                            data-country="#{$prefix}-{$name}-country"
                            required=true
                            autocomplete="shipping postal-code"}
                    {/formgroup}
                {/block}
            {/col}

            {col cols=12 md=8}
                {block name='checkout-customer-shipping-address-city'}
                    {formgroup
                        class="{if !empty($fehlendeAngaben.ort)} has-error{/if} city-wrapper exclude-from-label-slide"
                        label=""
                        label-for="{$prefix}-{$name}-city"
                    }
                        {if isset($fehlendeAngaben.ort)}
                            <div class="form-error-msg"><i class="fa fa-exclamation-triangle"></i>
                                {if $fehlendeAngaben.ort==3}
                                    {lang key='cityNotNumeric' section='account data'}
                                {else}
                                    {lang key='fillOut'}
                                {/if}
                            </div>
                        {/if}
                        {input type="text"
                            name="{$prefix}[{$name}][ort]"
                            value="{if isset($Lieferadresse->cOrt)}{$Lieferadresse->cOrt}{/if}"
                            id="{$prefix}-{$name}-city"
                            class="city_input typeahead bg-typeahead-fix"
                            placeholder="{lang key='city' section='account data'}"
                            required=true
                            autocomplete="shipping address-level2"
                            aria=["label"=>{lang key='city' section='account data'}]}
                    {/formgroup}
                {/block}
            {/col}
        {/block}
    {/formrow}
    </fieldset>
{/block}
