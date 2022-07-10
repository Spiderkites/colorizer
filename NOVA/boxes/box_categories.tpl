{block name='boxes-box-categories'}
    <div class="box box-normal box-categories word-break" id="sidebox-categories-{$oBox->getID()}">
        {block name='boxes-box-categories-content'}
            {block name='boxes-box-categories-toggle-title'}
                {link id="crd-hdr-{$oBox->getID()}"
                    href="#crd-cllps-{$oBox->getID()}"
                    data=["toggle"=>"collapse"]
                    role="button"
                    aria=["expanded"=>"false","controls"=>"crd-cllps-{$oBox->getID()}"]
                    class="box-normal-link dropdown-toggle"}
                    {if !empty($oBox->getTitle())}{$oBox->getTitle()}{else}{lang key='categories'}{/if}
                {/link}
            {/block}
            {block name='boxes-box-categories-title'}
                <div class="productlist-filter-headline d-none d-md-flex">
                    {if !empty($oBox->getTitle())}{$oBox->getTitle()}{else}{lang key='categories'}{/if}
                </div>
            {/block}
            {block name='boxes-box-categories-collapse'}
                {collapse
                    class="d-md-block"
                    visible=false
                    id="crd-cllps-{$oBox->getID()}"
                    aria=["labelledby"=>"crd-hdr-{$oBox->getID()}"]}
                    <div class="nav-panel">
                        {nav vertical=true}
                            {block name='boxes-box-categories-include-categories-recursive'}
                                {include file='snippets/categories_recursive.tpl'
                                    i=0
                                    categoryId=0
                                    categoryBoxNumber=$oBox->getCustomID()
                                    limit=3
                                    categories=$oBox->getItems()
                                    id=$oBox->getID()}
                            {/block}
                        {/nav}
                    </div>
                {/collapse}
            {/block}
            {block name='boxes-box-categories-hr-end'}
                <hr class="box-normal-hr">
            {/block}
        {/block}
    </div>
{/block}
