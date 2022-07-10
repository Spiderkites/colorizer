{block name='snippets-newscategories-recursive'}
    {foreach $oNewsKategorie_arr as $oNewsKategorie}
        {if $selectedCat === $oNewsKategorie->getID()}{assign var=oCurNewsCat value=$oNewsKategorie}{/if}
        {block name='snippets-newscategories-recursive-newscategorie-options'}
            <option value="{$oNewsKategorie->getID()}"
                {if isset($selectedCat)}
                    {if is_array($selectedCat)}
                        {foreach $selectedCat as $singleCat}
                            {if $singleCat->getID() === $oNewsKategorie->getID()} selected{/if}
                        {/foreach}
                    {elseif $selectedCat === $oNewsKategorie->getID()} selected{/if}
                {/if}>
                {for $j=1 to $i}-&nbsp;{/for}{$oNewsKategorie->getName()}
            </option>
        {/block}
        {if $oNewsKategorie->getChildren()->count() > 0}
            {block name='snippets-newscategories-recursive-include-newscategories-recursive'}
                {include file='snippets/newscategories_recursive.tpl' i=$i+1 oNewsKategorie_arr=$oNewsKategorie->getChildren() selectedCat=$selectedCat}
            {/block}
        {/if}
    {/foreach}
{/block}
