{block name='snippets-product-slider'}
    {strip}
    {$isOPC=$isOPC|default:false}
    {if $productlist|@count > 0}
        {if !isset($tplscope)}
            {assign var=tplscope value='slider'}
        {/if}

        {if $tplscope === 'box'}
            {block name='snippets-product-slider-box'}
                {card class="{if $tplscope === 'box'} box box-slider{/if}{if isset($class) && $class|strlen > 0} {$class}{/if}" id="{if isset($id) && $id|strlen > 0}{$id}{/if}"}
                    {if !empty($title)}
                        {block name='snippets-product-slider-box-title'}
                            <div class="productlist-filter-headline">
                                {$title}
                                {if !empty($moreLink)}
                                    {link class="more float-right" href=$moreLink title=$moreTitle data-toggle="tooltip" data=["placement"=>"auto right"] aria=["label"=>"{$moreTitle}"]}
                                        <i class="fa fa-arrow-circle-right"></i>
                                    {/link}
                                {/if}
                            </div>
                        {/block}
                    {/if}
                    {block name='snippets-product-slider-box-products'}
                        <div class="slick-slider-mb slick-smooth-loading carousel carousel-arrows-inside slick-lazy slick-type-box {if $productlist|count < 3}slider-no-preview{/if}"
                            data-slick-type="{block name='product-box-slider-class'}box-slider{/block}">
                            {include file='snippets/slider_items.tpl' items=$productlist type='product'}
                        </div>
                    {/block}
                {/card}
            {/block}
        {else}
            {block name='snippets-product-slider-other'}
                <div class="slick-slider-other{if !$isOPC} is-not-opc{/if}{if isset($class) && $class|strlen > 0} {$class}{/if}"{if isset($id) && $id|strlen > 0} id="{$id}"{/if}>
                    {if !empty($title)}
                        {block name='snippets-product-slider-other-title'}
                            {if $titleContainer|default:false}<div class="container slick-slider-other-container">{/if}
                                <div class="hr-sect h2">
                                    {if !empty($moreLink)}
                                        {link class="text-decoration-none-util" href=$moreLink title=$moreTitle data-toggle="tooltip" data=["placement"=>"auto right"] aria=["label"=>$moreTitle]}
                                            {$title}
                                        {/link}
                                    {else}
                                        {$title}
                                    {/if}
                                </div>
                        {if $titleContainer|default:false}</div>{/if}
                        {/block}
                    {/if}
                    {block name='snippets-product-slider-other-products'}
                        {row class="slick-lazy slick-smooth-loading carousel carousel-arrows-inside {if $tplscope === 'half'}slick-type-half{else}slick-type-product{/if} {if $productlist|count < 3}slider-no-preview{/if}"
                            data=["slick-type"=>"{block name='product-slider-class'}{if $tplscope === 'half'}slider-half{else}product-slider{/if}{/block}"]}
                            {include file='snippets/slider_items.tpl' items=$productlist type='product'}
                        {/row}
                    {/block}
                </div>
            {/block}
        {/if}
    {/if}
    {/strip}
{/block}
