{block name='checkout-customer-shipping-contact'}
    {if $Einstellungen.kunden.lieferadresse_abfragen_tel !== 'N'
        || $Einstellungen.kunden.lieferadresse_abfragen_fax !== 'N'
        || $Einstellungen.kunden.lieferadresse_abfragen_email !== 'N'
        || $Einstellungen.kunden.lieferadresse_abfragen_mobil !== 'N'
    }
        <fieldset class="customer-shipping-contact">
            {formrow}
                {$name = 'shipping_address'}
                {col cols=12}
                    {block name='checkout-customer-shipping-contact.top-hr'}
                        <hr>
                    {/block}
                {/col}
                {col cols=12}
                    {block name='checkout-customer-shipping-contact-heading'}
                        <div class="h3">{lang key='contactInformation' section='account data'}</div>
                    {/block}
                {/col}
                {if $Einstellungen.kunden.lieferadresse_abfragen_email !== 'N' || $Einstellungen.kunden.lieferadresse_abfragen_mobil !== 'N'}
                    {block name='checkout-customer-shipping-contact-email-phone'}
                        {if $Einstellungen.kunden.lieferadresse_abfragen_email !== 'N'}
                        {col cols=12 md=6}
                            {block name='checkout-customer-shipping-contact-email'}
                                {include file='snippets/form_group_simple.tpl'
                                    options=[
                                        "email", "{$prefix}-{$name}-email", "{$prefix}[{$name}][email]",
                                        {$Lieferadresse->cMail|default:null}, {lang key='email' section='account data'},
                                        $Einstellungen.kunden.lieferadresse_abfragen_email, null, "shipping email"
                                    ]
                                }
                            {/block}
                        {/col}
                        {/if}
                        {if $Einstellungen.kunden.lieferadresse_abfragen_mobil !== 'N'}
                            {col cols=12 md=6}
                                {block name='checkout-customer-shipping-contact-mobile'}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            "tel", "{$prefix}-{$name}-mobil", "{$prefix}[{$name}][mobil]",
                                            {$Lieferadresse->cMobil|default:null}, {lang key='mobile' section='account data'},
                                            $Einstellungen.kunden.lieferadresse_abfragen_mobil, null, "shipping mobile tel"
                                        ]
                                    }
                                {/block}
                            {/col}
                        {/if}
                    {/block}
                {/if}
                {if $Einstellungen.kunden.lieferadresse_abfragen_tel !== 'N' || $Einstellungen.kunden.lieferadresse_abfragen_fax !== 'N'}
                    {block name='checkout-customer-shipping-contact-mobile-fax'}
                        {if $Einstellungen.kunden.lieferadresse_abfragen_tel !== 'N'}
                            {col cols=12 md=6}
                                {block name='checkout-customer-shipping-contact-tel'}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            "tel", "{$prefix}-{$name}-tel", "{$prefix}[{$name}][tel]",
                                            {$Lieferadresse->cTel|default:null}, {lang key='tel' section='account data'},
                                            $Einstellungen.kunden.lieferadresse_abfragen_tel, null, "shipping home tel"
                                        ]
                                    }
                                {/block}
                            {/col}
                        {/if}
                        {if $Einstellungen.kunden.lieferadresse_abfragen_fax !== 'N'}
                            {col cols=12 md=6}
                                {block name='checkout-customer-shipping-contact-fax'}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            "tel", "{$prefix}-{$name}-fax", "{$prefix}[{$name}][fax]",
                                            {$Lieferadresse->cFax|default:null}, {lang key='fax' section='account data'},
                                            $Einstellungen.kunden.lieferadresse_abfragen_fax, null, "shipping fax tel"
                                        ]
                                    }
                                {/block}
                            {/col}
                        {/if}
                    {/block}
                {/if}
            {/formrow}
        </fieldset>
    {/if}
{/block}
