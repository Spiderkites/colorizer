{block name='snippets-language-dropdown'}
    {if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
        {navitemdropdown
        class="language-dropdown {$dropdownClass|default:''}"
        right=true
        text="
            {foreach $smarty.session.Sprachen as $language}
                {if $language->getId() == $smarty.session.kSprache}
                    {block name='snippets-language-dropdown-text'}
                        {$language->getIso639()|upper}
                    {/block}
                {/if}
            {/foreach}"
        }
            {foreach $smarty.session.Sprachen as $language}
                {block name='snippets-language-dropdown-item'}
                    {dropdownitem href="{$language->getUrl()}"
                        class="link-lang"
                        data=["iso"=>$language->getIso()]
                        rel="nofollow"
                        active=($language->getId() == $smarty.session.kSprache)}
                        {$language->getIso639()|upper}
                    {/dropdownitem}
                {/block}
            {/foreach}
        {/navitemdropdown}
    {/if}
{/block}
