{block name='productdetails-variation'}
    {if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0 && !$showMatrix}
        {assign var=VariationsSource value='Variationen'}
        {if isset($ohneFreifeld) && $ohneFreifeld}
            {assign var=VariationsSource value='VariationenOhneFreifeld'}
        {/if}
        {assign var=oVariationKombi_arr value=$Artikel->getChildVariations()}
        {block name='productdetails-variation-spinner'}
            {row}
                {col class="updatingStockInfo text-center-util d-none"}
                    <i class="fa fa-spinner fa-spin" title="{lang key='updatingStockInformation' section='productDetails'}"></i>
                {/col}
            {/row}
        {/block}
        {block name='productdetails-variation-variation'}
            {row class="variations {if $simple}simple{else}switch{/if}-variations"}
                {col}
                    <dl>
                    {foreach name=Variationen from=$Artikel->$VariationsSource key=i item=Variation}

                    {strip}
                        <dt>{$Variation->cName}&nbsp;
                            {if $Variation->cTyp === 'IMGSWATCHES'}
                                <span class="swatches-selected text-success" data-id="{$Variation->kEigenschaft}">
                                {foreach $Variation->Werte as $variationValue}
                                    {if isset($oVariationKombi_arr[$variationValue->kEigenschaft])
                                        && in_array($variationValue->kEigenschaftWert, $oVariationKombi_arr[$variationValue->kEigenschaft])}
                                        {$variationValue->cName}
                                        {break}
                                    {/if}
                                {/foreach}
                                </span>
                            {/if}
                        </dt>
                        <dd class="form-group text-left-util">
                            {if $Variation->cTyp === 'SELECTBOX'}
                                {block name='productdetails-variation-select-outer'}
                                {select data=["size"=>"10"] class='custom-select selectpicker' title="{lang key='pleaseChooseVariation' section='productDetails'}" name="eigenschaftwert[{$Variation->kEigenschaft}]" required=!$showMatrix}
                                    {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                        {assign var=bSelected value=false}
                                        {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                            {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                        {/if}
                                        {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                            {assign var=bSelected value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                                        {/if}
                                        {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                        $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                        !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                        {else}
                                            {block name='productdetails-variation-select-inner'}
                                                {block name='productdetails-variation-select-include-variation-value'}
                                                    {include file='productdetails/variation_value.tpl' assign='cVariationsWert'}
                                                {/block}
                                                <option value="{$Variationswert->kEigenschaftWert}" class="variation"
                                                        data-content="<span data-value='{$Variationswert->kEigenschaftWert}'>{$cVariationsWert|trim|escape:'html'}
                                                    {if $Variationswert->notExists} <span class='badge badge-danger badge-not-available'>{lang key='notAvailableInSelection'}</span>
                                                    {elseif !$Variationswert->inStock}<span class='badge badge-danger badge-not-available'>{lang key='ampelRot'}</span>{/if}</span>"
                                                        data-type="option"
                                                        data-original="{$Variationswert->cName}"
                                                        data-key="{$Variationswert->kEigenschaft}"
                                                        data-value="{$Variationswert->kEigenschaftWert}"
                                                        {if !empty($Variationswert->cBildPfadMini)}
                                                            data-list='{prepare_image_details item=$Variationswert json=true}'
                                                            data-title='{$Variationswert->cName}'
                                                        {/if}
                                                        {if isset($Variationswert->oVariationsKombi)}
                                                            data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                                        {/if}
                                                        {if $bSelected} selected="selected"{/if}>
                                                    {$cVariationsWert|trim|escape:'html'}
                                                </option>
                                            {/block}
                                        {/if}
                                    {/foreach}
                                {/select}
                                {/block}
                            {elseif $Variation->cTyp === 'RADIO'}
                                {block name='productdetails-variation-radio-outer'}
                                    {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                        {assign var=bSelected value=false}
                                        {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                           {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                        {/if}
                                        {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                            {assign var=bSelected value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                                        {/if}
                                        {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                        $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                        !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                        {else}
                                            {block name='productdetails-variation-radio-inner'}
                                                <div class="custom-control custom-radio">
                                                    <input type="radio"
                                                        class="custom-control-input"
                                                        name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                                        id="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                        value="{$Variationswert->kEigenschaftWert}"
                                                        {if $bSelected}checked="checked"{/if}
                                                        {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                                    >
                                                    <label class="variation custom-control-label d-flex" for="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                           data-type="radio"
                                                           data-original="{$Variationswert->cName}"
                                                           data-key="{$Variationswert->kEigenschaft}"
                                                           data-value="{$Variationswert->kEigenschaftWert}"
                                                           {if !empty($Variationswert->cBildPfadMini)}
                                                                data-list='{prepare_image_details item=$Variationswert json=true}'
                                                                data-title='{$Variationswert->cName}{if $Variationswert->notExists} - {lang key='notAvailableInSelection'}{elseif !$Variationswert->inStock} - {lang key='ampelRot'}{/if}'
                                                           {/if}
                                                           {if !$Variationswert->inStock}
                                                                data-stock="out-of-stock"
                                                           {/if}
                                                           {if isset($Variationswert->oVariationsKombi)}
                                                                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                                           {/if}>
                                                        {block name='productdetails-variation-radio-include-variation-value'}
                                                            {include file="productdetails/variation_value.tpl" badgeRight=true}
                                                            {if $Variationswert->notExists}
                                                                {badge class='badge-not-available' variant='danger'}{lang key='notAvailableInSelection'}{/badge}
                                                            {elseif !$Variationswert->inStock}
                                                                {badge class='badge-not-available' variant='danger'}{lang key='ampelRot'}{/badge}
                                                            {/if}
                                                        {/block}
                                                    </label>
                                                </div>
                                            {/block}
                                        {/if}
                                    {/foreach}
                                {/block}
                            {elseif $Variation->cTyp === 'IMGSWATCHES'}
                                {block name='productdetails-variation-swatch-outer'}
                                    {formrow class="swatches {$Variation->cTyp|lower}"}
                                        {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                            {assign var=bSelected value=false}
                                            {assign var=hasImage value=!empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))
                                                && $Variationswert->getImage(\JTL\Media\Image::SIZE_XS)|strpos:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN === false}
                                            {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                                {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                            {/if}
                                            {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                                {assign var=bSelected value=($Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert)}
                                            {/if}
                                            {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                            $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                            !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                                {* /do nothing *}
                                            {else}
                                                {block name='productdetails-variation-swatch-inner'}
                                                {col class='col-auto'}
                                                    <label class="variation swatches {if $hasImage}swatches-image{else}swatches-text{/if} {if $bSelected}active{/if} {if $Variationswert->notExists}swatches-not-in-stock not-available{elseif !$Variationswert->inStock}swatches-sold-out not-available{/if}"
                                                            data-type="swatch"
                                                            data-original="{$Variationswert->cName}"
                                                            data-key="{$Variationswert->kEigenschaft}"
                                                            data-value="{$Variationswert->kEigenschaftWert}"
                                                            for="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                            {if !empty($Variationswert->cBildPfadMini)}
                                                                data-list='{prepare_image_details item=$Variationswert json=true}'
                                                            {/if}
                                                            {if $Variationswert->notExists}
                                                                title="{lang key='notAvailableInSelection'}"
                                                                data-title="{$Variationswert->cName} - {lang key='notAvailableInSelection'}"
                                                                data-toggle="tooltip"
                                                            {elseif $Variationswert->inStock}
                                                                data-title="{$Variationswert->cName}"
                                                            {else}
                                                                title="{lang key='ampelRot'}"
                                                                data-title="{$Variationswert->cName} - {lang key='ampelRot'}"
                                                                data-toggle="tooltip"
                                                                data-stock="out-of-stock"
                                                            {/if}
                                                            {if isset($Variationswert->oVariationsKombi)}
                                                                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                                            {/if}>
                                                        <input type="radio"
                                                               class="control-hidden"
                                                               name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                                               id="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                               value="{$Variationswert->kEigenschaftWert}"
                                                               {if $bSelected}checked="checked"{/if}
                                                               {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                                               />
                                                            {if $hasImage}
                                                                {include file='snippets/image.tpl' sizes='90px' item=$Variationswert srcSize='xs'}
                                                            {else}
                                                                {$Variationswert->cName}
                                                            {/if}
                                                        {block name='productdetails-variation-swatch-include-variation-value'}
                                                            {include file='productdetails/variation_value.tpl' hideVariationValue=true}
                                                        {/block}
                                                    </label>
                                                {/col}
                                                {/block}
                                            {/if}
                                        {/foreach}
                                    {/formrow}
                                {/block}
                            {elseif $Variation->cTyp === 'TEXTSWATCHES'}
                                {block name='productdetails-variation-textswatch-outer'}
                                    {formrow class="swatches {$Variation->cTyp|lower}"}
                                        {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                            {assign var=bSelected value=false}
                                            {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                                {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                            {/if}
                                            {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                                {assign var=bSelected value=($Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert)}
                                            {/if}
                                            {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                            $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                            !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                                {* /do nothing *}
                                            {else}
                                                {block name='productdetails-variation-textswatch-inner'}
                                                {col class='col-auto'}
                                                    <label class="variation swatches swatches-text{if $bSelected} active{/if} {if $Variationswert->notExists}swatches-not-in-stock{elseif !$Variationswert->inStock}swatches-sold-out{/if}"
                                                            data-type="swatch"
                                                            data-original="{$Variationswert->cName}"
                                                            data-key="{$Variationswert->kEigenschaft}"
                                                            data-value="{$Variationswert->kEigenschaftWert}"
                                                            for="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                            {if !empty($Variationswert->cBildPfadMini)}
                                                                data-list='{prepare_image_details item=$Variationswert json=true}'
                                                            {/if}
                                                            {if $Variationswert->notExists}
                                                                title="{lang key='notAvailableInSelection'}"
                                                                data-title="{$Variationswert->cName} - {lang key='notAvailableInSelection'}"
                                                                data-toggle="tooltip"
                                                            {elseif $Variationswert->inStock}
                                                                data-title="{$Variationswert->cName}"
                                                            {else}
                                                                title="{lang key='ampelRot'}"
                                                                data-title="{$Variationswert->cName} - {lang key='ampelRot'}"
                                                                data-toggle="tooltip"
                                                                data-stock="out-of-stock"
                                                            {/if}
                                                            {if isset($Variationswert->oVariationsKombi)}
                                                                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                                            {/if}>
                                                        <input type="radio"
                                                               class="control-hidden"
                                                               name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                                               id="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                               value="{$Variationswert->kEigenschaftWert}"
                                                               {if $bSelected}checked="checked"{/if}
                                                               {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                                               />
                                                        <span class="label-variation">
                                                            {$Variationswert->cName}
                                                        </span>
                                                        {block name='productdetails-variation-textswatch-include-variation-value'}
                                                            {include file='productdetails/variation_value.tpl' hideVariationValue=true}
                                                        {/block}
                                                    </label>
                                                {/col}
                                                {/block}
                                            {/if}
                                        {/foreach}
                                    {/formrow}
                                {/block}
                            {elseif $Variation->cTyp === 'FREIFELD' || $Variation->cTyp === 'PFLICHT-FREIFELD'}
                                {block name='productdetails-variation-info-variation-text'}
                                    <label for="vari-{$Variation->kEigenschaft}" class="sr-only">{$Variation->cName}</label>
                                    {input id="vari-{$Variation->kEigenschaft}" name='eigenschaftwert['|cat:$Variation->kEigenschaft|cat:']'
                                       value=$oEigenschaftWertEdit_arr[$Variation->kEigenschaft]->cEigenschaftWertNameLocalized|default:''
                                       data=['key' => $Variation->kEigenschaft] required=$Variation->cTyp === 'PFLICHT-FREIFELD'
                                       maxlength=255}
                                {/block}
                            {/if}
                        </dd>
                    {/strip}
                    {/foreach}
                    </dl>
                {/col}
            {/row}
        {/block}
    {/if}
{/block}
