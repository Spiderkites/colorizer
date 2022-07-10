{block name='productdetails-variation-value'}
    {$badgeRight = $badgeRight|default:false}
    {strip}
        {if !isset($hideVariationValue) || !$hideVariationValue}
            {block name='productdetails-variation-value-name-not-hide'}
                {$Variationswert->cName}
            {/block}
        {/if}
    {* variationskombination *}
    {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
        {if $Artikel->nVariationOhneFreifeldAnzahl == 1}
            {block name='productdetails-variation-value-varkombi'}
                {assign var=kEigenschaftWert value=$Variationswert->kEigenschaftWert}
                {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1}
                    {if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cAufpreisLocalized[$NettoPreise])}
                        <span class="variation-badge {if $badgeRight}badge-right{/if}">
                            {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cAufpreisLocalized[$NettoPreise]}
                            {if !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}
                                &nbsp;({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]})
                            {/if}
                        </span>
                    {/if}
                {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2}
                    <span class="variation-badge {if $badgeRight}badge-right{/if}">
                        {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}
                        {if !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}
                            &nbsp;({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]})
                        {/if}
                    </span>
                {/if}
            {/block}
        {/if}
    {/if}
    {* einfache kombination oder variationskombination mit mindestens 2 nicht-freifeld positionen *}
    {if ($Artikel->kVaterArtikel == 0 && $Artikel->nIstVater == 0) && isset($Variationswert->fAufpreisNetto)}
        {block name='productdetails-variation-value-varkombi-single-2-free'}
            {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $Variationswert->fAufpreisNetto!=0}
                <span class="variation-badge {if $badgeRight}badge-right{/if}">
                    {$Variationswert->cAufpreisLocalized[$NettoPreise]}
                </span>
            {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $Variationswert->fAufpreisNetto!=0}
                <span class="variation-badge {if $badgeRight}badge-right{/if}">
                    {$Variationswert->cPreisInklAufpreis[$NettoPreise]}
                </span>
            {/if}
        {/block}
    {/if}
    {* variationskombination mit mindestens 2 nicht-freifeld positionen *}
    {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl > 1 && isset($Variationswert->fAufpreisNetto)}
        {block name='productdetails-variation-value-varkombi-2-free'}
            {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $Variationswert->fAufpreisNetto!=0}
                <span class="variation-badge {if $badgeRight}badge-right{/if}">{$Variationswert->cAufpreisLocalized[$NettoPreise]}
                {if !empty($Variationswert->cPreisVPEWertAufpreis[$NettoPreise]) && $Artikel->nVariationOhneFreifeldAnzahl == 1}
                    &nbsp;({$Variationswert->cPreisVPEWertAufpreis[$NettoPreise]})
                {/if}
                </span>
            {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $Variationswert->fAufpreisNetto!=0}
                <span class="variation-badge {if $badgeRight}badge-right{/if}">{$Variationswert->cPreisInklAufpreis[$NettoPreise]}
                {if !empty($Variationswert->cPreisVPEWertInklAufpreis[$NettoPreise]) && $Artikel->nVariationOhneFreifeldAnzahl == 1}
                    &nbsp;({$Variationswert->cPreisVPEWertInklAufpreis[$NettoPreise]})
                {/if}
                </span>
            {/if}
        {/block}
    {/if}
    {/strip}
{/block}
