{block name='productdetails-config-sidebar'}
    <div id="product-configuration-sidebar">
        {block name='productdetails-config-sidebar-table'}
            <table id="configuration-table" class="table table-striped">
                <tbody class="summary"></tbody>
                <tfoot>
                <tr>
                    <td colspan="3" class="cfg-price">
                        <strong class="price"></strong>
                        <p class="vat_info">
                            {block name='productdetails-config-sidebar-include-shipping-tax-info'}
                                <small>{include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}</small>
                            {/block}
                        </p>
                    </td>
                </tr>
                </tfoot>
            </table>
        {/block}
        {*{button variant="primary" class="float-right mb-3 js-cfg-validate" data=["dismiss"=>"modal"] disabled=true}
            {lang key='applyConfiguration' section='productDetails'}
        {/button}*}
        {include file='productdetails/basket.tpl'}
        {if isset($kEditKonfig)}
            <input type="hidden" name="kEditKonfig" value="{$kEditKonfig}"/>
        {/if}
    </div>
{/block}
