{block name='snippets-ribbon'}
    {if !empty($Artikel->Preise->Sonderpreis_aktiv)}
        {$sale = $Artikel->Preise->discountPercentage}
    {/if}

    {block name='snippets-ribbon-main'}
        <div class="ribbon
            ribbon-{$Artikel->oSuchspecialBild->getType()} productbox-ribbon">
            {block name='snippets-ribbon-content'}
                {lang key='ribbon-'|cat:$Artikel->oSuchspecialBild->getType() section='productOverview' printf=$sale|default:''|cat:'%'}
            {/block}
        </div>
    {/block}
{/block}
