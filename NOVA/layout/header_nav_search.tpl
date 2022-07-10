{block name='layout-header-nav-search'}
    {block name='layout-header-nav-search-search'}
        <li class="nav-item" id="search">
            <div class="search-wrapper">
                {form action="{get_static_route id='index.php'}" method='get'}
                    <div class="form-icon">
                        {inputgroup}
                            {input id="search-header" name="qs" type="text" class="ac_input" placeholder="{lang key='search'}" autocomplete="off" aria=["label"=>"{lang key='search'}"]}
                            {inputgroupaddon append=true}
                                {button type="submit" name='search' variant="secondary" aria=["label"=>{lang key='search'}]}<span class="fas fa-search"></span>{/button}
                            {/inputgroupaddon}
                            <span class="form-clear d-none"><i class="fas fa-times"></i></span>
                        {/inputgroup}
                    </div>
                {/form}
            </div>
        </li>
    {/block}
    {block name='layout-header-nav-search-search-dropdown'}
        {if $Einstellungen.template.theme.mobile_search_type === 'dropdown'}
            {navitemdropdown class='search-wrapper-dropdown d-block d-lg-none'
                text='<i id="mobile-search-dropdown" class="fas fa-search"></i>'
                right=true
                no-caret=true
                router-aria=['label'=>{lang key='findProduct'}]}
                <div class="dropdown-body">
                    {include file='snippets/search_form.tpl' id='search-header-desktop'}
                </div>
            {/navitemdropdown}
        {/if}
    {/block}
{/block}
