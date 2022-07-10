{block name='blog-overview'}
    {block name='blog-overview-heading'}
        {opcMountPoint id='opc_before_heading' inContainer=false}
        {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            <h1>{lang key='news' section='news'}</h1>
        {/container}
    {/block}

    {block name='blog-overview-include-extension'}
        {include file='snippets/extension.tpl'}
    {/block}
    {opcMountPoint id='opc_before_filter' inContainer=false}
    {container fluid=$Link->getIsFluid() class="blog-overview {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
        {block name='filter'}
            {row class="blog-overview-main"}
                {col cols=12 class="col-xl"}
                    {get_static_route id='news.php' assign=routeURL}
                    {block name='blog-overview-form'}
                        {form id="frm_filter" name="frm_filter" action=$routeURL slide=true}
                            {formgroup}
                                {formrow}
                                    {col cols=12 sm=4 lg='auto'}
                                        {block name='blog-overview-form-sort'}
                                            {select name="nSort" class="onchangeSubmit custom-select" aria=["label"=>"{lang key='newsSort' section='news'}"]}
                                                <option value="-1"{if $nSort === -1} selected{/if}>{lang key='newsSort' section='news'}</option>
                                                <option value="1"{if $nSort === 1} selected{/if}>{lang key='newsSortDateDESC' section='news'}</option>
                                                <option value="2"{if $nSort === 2} selected{/if}>{lang key='newsSortDateASC' section='news'}</option>
                                                <option value="3"{if $nSort === 3} selected{/if}>{lang key='newsSortHeadlineASC' section='news'}</option>
                                                <option value="4"{if $nSort === 4} selected{/if}>{lang key='newsSortHeadlineDESC' section='news'}</option>
                                                <option value="5"{if $nSort === 5} selected{/if}>{lang key='newsSortCommentsDESC' section='news'}</option>
                                                <option value="6"{if $nSort === 6} selected{/if}>{lang key='newsSortCommentsASC' section='news'}</option>
                                            {/select}
                                        {/block}
                                    {/col}
                                    {col cols=12 sm=4 lg='auto'}
                                        {block name='blog-overview-form-date'}
                                            {select name="cDatum" class="onchangeSubmit custom-select" aria=["label"=>"{lang key='newsDateFilter' section='news'}"]}
                                                <option value="-1"{if $cDatum == -1} selected{/if}>{lang key='newsDateFilter' section='news'}</option>
                                                {if !empty($oDatum_arr)}
                                                    {foreach $oDatum_arr as $oDatum}
                                                        <option value="{$oDatum->cWert}"{if $cDatum == $oDatum->cWert} selected{/if}>{$oDatum->cName}</option>
                                                    {/foreach}
                                                {/if}
                                            {/select}
                                        {/block}
                                    {/col}
                                    {lang key='newsCategorie' section='news' assign='cCurrentKategorie'}
                                    {if $oNewsCat->getID() > 0}
                                        {assign var=kNewsKategorie value=$oNewsCat->getID()}
                                    {else}
                                        {assign var=kNewsKategorie value=$kNewsKategorie|default:0}
                                    {/if}
                                    {col cols=12 sm=4 lg='auto'}
                                        {block name='blog-overview-form-categories'}
                                            {select name="nNewsKat" class="onchangeSubmit custom-select" aria=["label"=>"{lang key='newsCategorie' section='news'}"]}
                                                <option value="-1"{if $kNewsKategorie === -1} selected{/if}>{lang key='newsCategorie' section='news'}</option>
                                                {if !empty($oNewsKategorie_arr)}
                                                    {assign var=selectedCat value=$kNewsKategorie}
                                                    {block name='blog-overview-include-newscategories-recursive'}
                                                        {include file='snippets/newscategories_recursive.tpl' i=0 selectedCat=$selectedCat}
                                                    {/block}
                                                {/if}
                                            {/select}
                                        {/block}
                                    {/col}
                                    {col cols=12 sm=4 lg='auto'}
                                        {block name='blog-overview-form-items'}
                                            {select
                                                name="{$oPagination->getId()}_nItemsPerPage"
                                                id="{$oPagination->getId()}_nItemsPerPage"
                                                class="onchangeSubmit custom-select"
                                                aria=["label"=>"{lang key='newsPerSite' section='news'}"]
                                            }
                                                <option value="-1" {if $oPagination->getItemsPerPage() == 0} selected{/if}>
                                                    {lang key='showAll'}
                                                </option>
                                                {foreach $oPagination->getItemsPerPageOptions() as $nItemsPerPageOption}
                                                    <option value="{$nItemsPerPageOption}"{if $oPagination->getItemsPerPage() == $nItemsPerPageOption} selected{/if}>
                                                        {$nItemsPerPageOption}
                                                    </option>
                                                {/foreach}
                                            {/select}
                                        {/block}
                                    {/col}
                                {/formrow}
                            {/formgroup}
                        {/form}
                    {/block}
                {/col}
                {col cols=12 sm="auto" class="blog-overview-pagination"}
                    {block name='blog-overview-include-pagination-top'}
                        {include file='snippets/pagination.tpl' oPagination=$oPagination cThisUrl='news.php' parts=['pagi'] noWrapper=true}
                    {/block}
                {/col}
            {/row}
            {block name='blog-overview-hr-top'}
                <hr class="blog-overview-hr">
            {/block}
        {/block}
        {block name='blog-overview-category'}
            {if $noarchiv === 1}
                {block name='blog-overview-alert-no-archive'}
                    {alert variant="info"}{lang key='noNewsArchiv' section='news'}{/alert}
                {/block}
            {elseif !empty($newsItems)}
                <div id="newsContent" itemprop="mainEntity" itemscope itemtype="https://schema.org/Blog">
                    {if $oNewsCat->getID() > 0}
                        {block name='blog-overview-subheading'}
                            {opcMountPoint id='opc_before_news_category_heading'}
                            <h2>{$oNewsCat->getName()}</h2>
                        {/block}
                        {block name='blog-overview-preview-image'}
                            {row}
                                {if !empty($oNewsCat->getPreviewImage())}
                                    {col cols=12 sm=8}
                                        {$oNewsCat->getDescription()}
                                    {/col}
                                    {col cols=12 sm=4}
                                        {include file='snippets/image.tpl' item=$oNewsCat square=false center=true}
                                    {/col}
                                {else}
                                    {col sm=12}{$oNewsCat->getDescription()}{/col}
                                {/if}
                            {/row}
                        {/block}
                    {/if}
                    {opcMountPoint id='opc_before_news_list'}
                    {block name='blog-overview-previews'}
                        {row class="blog-overview-preview"}
                            {foreach $newsItems as $newsItem}
                                {col cols=12 md=6 lg=4 class="blog-overview-preview-item"}
                                    {block name='blog-overview-include-preview'}
                                        {include file='blog/preview.tpl'}
                                    {/block}
                                {/col}
                            {/foreach}
                        {/row}
                    {/block}
                </div>
                {opcMountPoint id='opc_after_news_list'}
                {block name='blog-overview-include-pagination-bottom'}
                    {include file='snippets/pagination.tpl' oPagination=$oPagination cThisUrl='news.php' parts=['pagi']}
                {/block}
            {/if}
        {/block}
    {/container}
{/block}
