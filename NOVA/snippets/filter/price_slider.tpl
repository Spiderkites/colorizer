{block name='snippets-filter-price-slider'}
    {block name='snippets-filter-price-slider-content'}
        {row no-gutters=true class="price-range-inputs"}
            {col cols=5}
                {inputgroup}
                    {input id="{$id}-from" class="price-range-input" placeholder=0 aria=["label" => {lang key='differentialPriceFrom' section='productOverview'}]}
                    {inputgroupaddon prepend=true}
                        {inputgrouptext}
                            {$smarty.session.Waehrung->getName()}
                        {/inputgrouptext}
                    {/inputgroupaddon}
                {/inputgroup}
            {/col}
            {col cols=5}
                {inputgroup}
                    {input id="{$id}-to" class="price-range-input"  placeholder=$priceRangeMax aria=["label" => {lang key='differentialPriceTo' section='productOverview'}]}
                    {inputgroupaddon prepend=true}
                        {inputgrouptext}
                            {$smarty.session.Waehrung->getName()}
                        {/inputgrouptext}
                    {/inputgroupaddon}
                {/inputgroup}
            {/col}
        {/row}
        {input data=['id'=>'js-price-range'] type="hidden" value="{$priceRange}"}
        {input data=['id'=>'js-price-range-max'] type="hidden" value="{$priceRangeMax}"}
        {input data=['id'=>'js-price-range-id'] type="hidden" value="{$id}"}
        <div id="{$id}" class="price-range-slide"></div>
    {/block}
    {block name='snippets-filter-price-slider-script'}
        {inline_script}<script>
            $(window).on('load', function() {
                $.evo.initPriceSlider($('.js-price-range-box'), $('#js-price-redirect').val() != 1);
            });
        </script>{/inline_script}
    {/block}
{/block}
