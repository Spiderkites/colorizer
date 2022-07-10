{block name='snippets-form-group-simple'}
    {$inputType     = $options[0]}
    {$inputId       = $options[1]}
    {$inputName     = $options[2]}
    {$inputValue    = $options[3]}
    {$label         = $options[4]}
    {$invalidReason = $options[6]|default:''}
    {$autocomplete  = $options[7]|default:''}
    {$size          = $options[8]|default:''}
    {$isRequired    = !empty($options[5]) && ($options[5] === 'Y' || $options[5] === true)}
    {$inputNameTmp  = $inputName|replace:"register[shipping_address][":""|replace:"]":""}

    {if $invalidReason !== ''}
        {$hasError = true}
    {elseif !empty($fehlendeAngaben) && isset($fehlendeAngaben.{$inputNameTmp})}
        {$errCode  = $fehlendeAngaben.{$inputNameTmp}}
        {$hasError = true}
        {if $inputNameTmp === 'email'}
            {if $errCode == 1}
                {lang assign='invalidReason' key='fillOut'}
            {elseif $errCode == 2}
                {lang assign='invalidReason' key='invalidEmail'}
            {elseif $errCode == 3}
                {lang assign='invalidReason' key='blockedEmail'}
            {elseif $errCode == 4}
                {lang assign='invalidReason' key='noDnsEmail' section='account data'}
            {elseif $errCode == 5}
                {lang assign='invalidReason' key='emailNotAvailable' section='account data'}
            {/if}
        {elseif $inputNameTmp === 'mobil'
        || $inputNameTmp === 'tel'
        || $inputNameTmp === 'fax'}
            {if $errCode == 1}
                {lang assign='invalidReason' key='fillOut'}
            {elseif $errCode == 2}
                {lang assign='invalidReason' key='invalidTel'}
            {/if}
        {elseif $inputNameTmp === 'vorname'}
            {if $errCode == 1}
                {lang assign='invalidReason' key='fillOut'}
            {elseif $errCode == 2}
                {lang assign='invalidReason' key='firstNameNotNumeric' section='account data'}
            {/if}
        {elseif $inputNameTmp === 'nachname'}
            {if $errCode == 1}
                {lang assign='invalidReason' key='fillOut'}
            {elseif $errCode == 2}
                {lang assign='invalidReason' key='lastNameNotNumeric' section='account data'}
            {/if}
        {elseif $inputNameTmp === 'geburtstag'}
            {if $errCode == 1}
                {lang assign='invalidReason' key='fillOut'}
            {elseif $errCode == 2}
                {lang assign='invalidReason' key='invalidDateformat'}
            {elseif $errCode == 3}
                {lang assign='invalidReason' key='invalidDate'}
            {/if}
        {elseif $inputNameTmp === 'www'}
            {if $errCode == 1}
                {lang assign='invalidReason' key='fillOut'}
            {elseif $errCode == 2}
                {lang assign='invalidReason' key='invalidURL'}
            {/if}
        {else}
            {lang assign='invalidReason' key='fillOut'}
        {/if}
    {else}
        {$hasError = false}
    {/if}

    {formgroup label-for=$inputId
        label="{$label}{if !$isRequired}<span class='optional'> - {lang key='optional'}</span>{/if}"
        class="{if $hasError}has-error{/if}"}
        {block name='snippets-form-group-simple-error'}
            {if $hasError}
                <div class="form-error-msg">{$invalidReason}</div>
            {/if}
        {/block}
        {if isset($inputType) && $inputType === 'number'}
            {block name='snippets-form-group-simple-input-number'}
                {inputgroup}
                    {inputgroupaddon append=false data=["type"=>"minus", "field"=>"quant[1]"]}
                        -
                    {/inputgroupaddon}
                        {input type=$inputType
                            name=$inputName
                            value=$inputValue
                            id=$inputId
                            placeholder="{if isset($placeholder)}{$placeholder}{else}{$label}{/if}"
                            required=$isRequired
                            autocomplete=$autocomplete
                        }
                    {inputgroupaddon append=true data=["type"=>"minus", "field"=>"quant[1]"]}
                        +
                    {/inputgroupaddon}
                {/inputgroup}
            {/block}
        {else}
            {block name='snippets-form-group-simple-input-other'}
                {input type="{if isset($inputType)}{$inputType}{else}text{/if}"
                    name=$inputName
                    value=$inputValue
                    id=$inputId
                    placeholder="{if isset($placeholder)}{$placeholder}{else} {/if}"
                    required=$isRequired
                    autocomplete=$autocomplete
                    size=$size
                }
            {/block}
        {/if}
    {/formgroup}
{/block}
