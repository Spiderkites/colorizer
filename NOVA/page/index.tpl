{block name='page-index'}
    {block name='page-index-include-selection-wizard'}
        {include file='selectionwizard/index.tpl'}
    {/block}

    {if isset($StartseiteBoxen) && $StartseiteBoxen|@count > 0}
        {assign var=moreLink value=null}
        {assign var=moreTitle value=null}

        {opcMountPoint id='opc_before_boxes' inContainer=false}

        {block name='page-index-boxes'}
            {foreach $StartseiteBoxen as $Box}
                {if isset($Box->Artikel->elemente) && count($Box->Artikel->elemente) > 0 && isset($Box->cURL)}
                    {if $Box->name === 'TopAngebot'}
                        {lang key='topOffer' assign='title'}
                        {lang key='showAllTopOffers' assign='moreTitle'}
                    {elseif $Box->name === 'Sonderangebote'}
                        {lang key='specialOffer' assign='title'}
                        {lang key='showAllSpecialOffers' assign='moreTitle'}
                    {elseif $Box->name === 'NeuImSortiment'}
                        {lang key='newProducts' assign='title'}
                        {lang key='showAllNewProducts'  assign='moreTitle'}
                    {elseif $Box->name === 'Bestseller'}
                        {lang key='bestsellers' assign='title'}
                        {lang key='showAllBestsellers' assign='moreTitle'}
                    {/if}
                    {assign var=moreLink value=$Box->cURL}
                    {block name='page-index-include-product-slider'}
                        {container class="product-slider-wrapper product-slider-{$Box->name} {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}" fluid=true}
                            {include file='snippets/product_slider.tpl'
                                productlist=$Box->Artikel->elemente
                                title=$title
                                hideOverlays=true
                                moreLink=$moreLink
                                moreTitle=$moreTitle
                                titleContainer=true}
                        {/container}
                    {/block}
                {/if}
            {/foreach}
        {/block}
    {/if}

    {block name='page-index-additional-content'}
        {if isset($oNews_arr) && $oNews_arr|@count > 0}

            {opcMountPoint id='opc_before_news' inContainer=false}

            <section class="index-news-wrapper">
                {container fluid=true class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                    {block name='page-index-subheading-news'}
                        <div class="blog-header">
                            <div class="hr-sect h2">
                                {link href="{get_static_route id='news.php'}"}{lang key='news' section='news'}{/link}
                            </div>
                        </div>
                    {/block}
                    {block name='page-index-news'}
                        {row itemprop="about"
                             itemscope=true
                             itemtype="https://schema.org/Blog"
                             class="slick-smooth-loading carousel carousel-arrows-inside slick-lazy slick-type-news {if $oNews_arr|count < 3}slider-no-preview{/if}"
                             data=["slick-type"=>"news-slider"]}
                            {include file='snippets/slider_items.tpl' items=$oNews_arr type='news'}
                        {/row}
                    {/block}
                {/container}
            </section>
        {/if}
    {/block}
{/block}
