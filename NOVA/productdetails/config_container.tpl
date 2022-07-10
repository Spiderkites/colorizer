{block name='productdetails-config-container'}
    {block name='productdetails-config-container-main'}
        {modal id="cfg-container" size="xl" title="{lang key="configure"}"}
            <div class="tab-content" id="cfg-container-tab-panes">
                <div class="tab-pane fade show active" id="cfg-tab-pane-options" role="tabpanel" aria-labelledby="cfg-tab-options">
                    {block name='productdetails-config-container-options'}
                        {include file='productdetails/config_options.tpl'}
                    {/block}
                </div>
                <div class="tab-pane fade" id="cfg-tab-pane-summary" role="tabpanel" aria-labelledby="cfg-tab-summary">
                    {block name='productdetails-config-container-include-config-sidebar'}
                        {include file='productdetails/config_sidebar.tpl'}
                    {/block}
                </div>
            </div>


            {nav id="cfg-modal-tabs" pills=true fill=true role="tablist"}
                {navitem id="cfg-tab-options" active=true
                    href="#cfg-tab-pane-options" role="tab" router-data=["toggle"=>"pill"]
                    router-aria=["controls"=>"cfg-tab-pane-options", "selected"=>"true"]
                }
                    <i class="fas fa-cogs"></i> <span class="nav-link-text">{lang key='configComponents' section='productDetails'}</span>
                {/navitem}
                {navitem id="cfg-tab-summary"
                    href="#cfg-tab-pane-summary" role="tab" router-data=["toggle"=>"pill"]
                    router-aria=["controls"=>"cfg-tab-pane-summary", "selected"=>"false"]
                }
                    <i class="fas fa-cart-plus"></i> <span class="nav-link-text">{lang key='yourConfiguration'}</span>
                {/navitem}
                {navitem href="#" disabled=true class="cfg-tab-total"}
                    <strong id="cfg-price" class="price"></strong>&nbsp;<span class="footnote-reference">*</span>
                {/navitem}
            {/nav}
            <div class="cfg-footnote small">
                <span class="footnote-reference">*</span>{include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}
            </div>
        {/modal}
    {/block}
    {block name='productdetails-config-container-script'}
        {if isset($kEditKonfig) && !isset($bWarenkorbHinzugefuegt)}
            {inline_script}<script>
                $('#cfg-container').modal('show');
            </script>{/inline_script}
        {/if}
    {/block}
{/block}
