{block name='checkout-inc-billing-address'}
    <ul class="list-unstyled inc-billing-address">
        {if isset($orderDetail)}
            {if $Kunde->cFirma}<li>{$Kunde->cFirma}</li>{/if}
            <li>{$Kunde->cTitel} {$Kunde->cVorname} {$Kunde->cNachname}</li>
            <li>
                {$Kunde->cStrasse} {$Kunde->cHausnummer} {if $Kunde->cAdressZusatz}{$Kunde->cAdressZusatz}{/if},
                {$Kunde->cPLZ} {$Kunde->cOrt},
                {$Kunde->cLand}
            </li>
        {else}
            {if $Kunde->cFirma}<li>{$Kunde->cFirma}</li>{/if}
            {if $Kunde->cZusatz}<li>{$Kunde->cZusatz}</li>{/if}
            <li>{$Kunde->cTitel} {$Kunde->cVorname} {$Kunde->cNachname}</li>
            <li>{$Kunde->cStrasse} {$Kunde->cHausnummer}</li>
            {if $Kunde->cAdressZusatz}<li>{$Kunde->cAdressZusatz}</li>{/if}
            <li>{$Kunde->cPLZ} {$Kunde->cOrt}</li>
            {if $Kunde->cBundesland}<li>{$Kunde->cBundesland}</li>{/if}
            <li>{if $Kunde->angezeigtesLand}{$Kunde->angezeigtesLand}{else}{$Kunde->cLand}{/if}</li>
        {/if}
        {if $Kunde->cUSTID}<li>{lang key='ustid' section='account data'}: {$Kunde->cUSTID}</li>{/if}
        {if $Kunde->cTel}<li>{lang key='tel' section='account data'}: {$Kunde->cTel}</li>{/if}
        {if $Kunde->cFax}<li>{lang key='fax' section='account data'}: {$Kunde->cFax}</li>{/if}
        {if $Kunde->cMobil}<li>{lang key='mobile' section='account data'}: {$Kunde->cMobil}</li>{/if}
        <li>{$Kunde->cMail}</li>
    </ul>
{/block}
