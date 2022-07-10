{block name='snippets-extension'}
    {assign var=isFluidBanner value=$Einstellungen.template.theme.banner_full_width === 'Y' && isset($oImageMap)}
    {if !$isFluidBanner}
        {block name='snippets-extension-include-banner'}
            {include file='snippets/banner.tpl' isFluid=false}
        {/block}
    {/if}

    {assign var=isFluidSlider value=$Einstellungen.template.theme.slider_full_width === 'Y' && isset($oSlider) && count($oSlider->getSlides()) > 0}
    {if !$isFluidSlider}
        {block name='snippets-extension-include-slider'}
            {include file='snippets/slider.tpl' isFluid=false}
        {/block}
    {/if}
{/block}
