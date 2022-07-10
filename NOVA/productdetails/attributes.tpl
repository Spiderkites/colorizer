{block name='productdetails-attributes'}
{if $showAttributesTable}
    <div class="product-attributes">
    {block name='productdetails-attributes-table'}
        <table class="table table-sm table-striped table-bordered-outline">
            {if $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'}
                {block name='productdetails-attributes-characteristics'}
                    {foreach $Artikel->oMerkmale_arr as $characteristic}
                        <tr>
                            <td class="h6">{$characteristic->cName}:</td>
                            <td class="attr-characteristic">
                                {strip}
                                    {foreach $characteristic->oMerkmalWert_arr as $characteristicValue}
                                        {if $characteristic->cTyp === 'TEXT' || $characteristic->cTyp === 'SELECTBOX' || $characteristic->cTyp === ''}
                                            {block name='productdetails-attributes-badge'}
                                                {link href=$characteristicValue->cURLFull class="badge badge-primary"}{$characteristicValue->cWert|escape:'html'}{/link}
                                            {/block}
                                        {else}
                                            {block name='productdetails-attributes-image'}
                                                {link href=$characteristicValue->cURLFull
                                                    class="text-decoration-none-util"
                                                    data=['toggle'=>'tooltip', 'placement'=>'top', 'boundary'=>'window']
                                                    title=$characteristicValue->cWert|escape:'html'
                                                    aria=["label"=>$characteristicValue->cWert|escape:'html']
                                                }
                                                    {$img = $characteristicValue->getImage(\JTL\Media\Image::SIZE_XS)}
                                                    {if $img !== null && $img|strpos:$smarty.const.BILD_KEIN_MERKMALBILD_VORHANDEN === false
                                                    && $img|strpos:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN === false}
                                                        {include file='snippets/image.tpl'
                                                            item=$characteristicValue
                                                            square=false
                                                            srcSize='xs'
                                                            sizes='40px'
                                                            width='40'
                                                            height='40'
                                                            class='img-aspect-ratio'
                                                            alt=$characteristicValue->cWert}
                                                    {else}
                                                        {badge variant="primary"}{$characteristicValue->cWert|escape:'html'}{/badge}
                                                    {/if}
                                                {/link}
                                            {/block}
                                        {/if}
                                    {/foreach}
                                {/strip}
                            </td>
                        </tr>
                    {/foreach}
                {/block}
            {/if}

            {if $showShippingWeight}
                {block name='productdetails-attributes-shipping-weight'}
                    <tr>
                        <td class="h6">{lang key='shippingWeight'}:</td>
                        <td class="weight-unit">
                            {$Artikel->cGewicht} {lang key='weightUnit'}
                        </td>
                    </tr>
                {/block}
            {/if}

            {if $showProductWeight}
                {block name='productdetails-attributes-product-weight'}
                    <tr class="attr-weight">
                        <td class="h6">{lang key='productWeight'}:</td>
                        <td class="weight-unit" itemprop="weight" itemscope itemtype="https://schema.org/QuantitativeValue">
                            <span itemprop="value">{$Artikel->cArtikelgewicht}</span> <span itemprop="unitText">{lang key='weightUnit'}
                        </td>
                    </tr>
                {/block}
            {/if}

            {if isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0 && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1) && isset($Artikel->cMassMenge)}
                {block name='productdetails-attributes-unit'}
                    <tr class="attr-contents">
                        <td class="h6">{lang key='contents' section='productDetails'}: </td>
                        <td class="attr-value">
                            {$Artikel->cMassMenge} {$Artikel->cMasseinheitName}
                        </td>
                    </tr>
                {/block}
            {/if}

            {if $dimension && $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y'}
                {block name='productdetails-attributes-dimensions'}
                    {assign var=dimensionArr value=$Artikel->getDimensionLocalized()}
                    {if $dimensionArr|count > 0}
                        <tr class="attr-dimensions">
                            <td class="h6">{lang key='dimensions' section='productDetails'}
                                ({foreach $dimensionArr as $dimkey => $dim}
                                    {$dimkey}{if !$dim@last} &times; {/if}
                                {/foreach}):
                            </td>
                            <td class="attr-value">
                                {foreach $dimensionArr as $dim}
                                    {$dim}{if $dim@last} cm {else} &times; {/if}
                                {/foreach}
                            </td>
                        </tr>
                    {/if}
                {/block}
            {/if}

            {if $Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y'
            || $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]|default:0 == 1}
                {block name='productdetails-attributes-shop-attributes'}
                    {foreach $Artikel->Attribute as $Attribut}
                        <tr class="attr-custom">
                            <td class="h6">{$Attribut->cName}: </td>
                            <td class="attr-value">{$Attribut->cWert}</td>
                        </tr>
                    {/foreach}
                {/block}
            {/if}
        </table>
    {/block}
    </div>
{/if}
{/block}
