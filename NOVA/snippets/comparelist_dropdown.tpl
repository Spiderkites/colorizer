{block name='snippets-comparelist-dropdown'}
    {block name='snippets-comparelist-dropdown-products'}
        <div class="comparelist-dropdown-table table-responsive max-h-sm lg-max-h">
            {if !empty($smarty.session.Vergleichsliste->oArtikel_arr)}
                <table class="table table-vertical-middle table-img">
                    <tbody>
                    {foreach $smarty.session.Vergleichsliste->oArtikel_arr as $product}
                        {block name='snippets-comparelist-dropdown-products-body'}
                            <tr>
                                <td class="w-100-util">
                                    {formrow class="align-items-center-util"}
                                        {col class="col-auto"}
                                            {block name='snippets-comparelist-dropdown-products-image'}
                                                {link href=$product->cURLFull}
                                                    {image lazy=true webp=true
                                                    src=$product->image->cURLMini
                                                    srcset="{$product->image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
                                                            {$product->image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
                                                            {$product->image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w"
                                                    sizes="45px"
                                                    alt=$product->cName
                                                    class="img-sm"}
                                                {/link}
                                            {/block}
                                        {/col}
                                        {col}
                                            {block name='snippets-comparelist-dropdown-products-title'}
                                                {link href=$product->cURLFull}{$product->cName}{/link}
                                            {/block}
                                        {/col}
                                    {/formrow}
                                </td>
                                <td  class="text-right-util text-nowrap-util">
                                    {block name='snippets-comparelist-dropdown-products-remove'}
                                        {link href="?vlplo={$product->kArtikel}" class="remove"
                                            title="{lang section="comparelist" key="removeFromCompareList"}"
                                            data=["name"=>"Vergleichsliste.remove",
                                                "toggle"=>"product-actions",
                                                "value"=>"{ldelim}{'"a"'|escape:'html'}:{$product->kArtikel}{rdelim}"
                                            ]
                                        }
                                            <i class="fas fa-times"></i>
                                        {/link}
                                    {/block}
                                </td>
                            </tr>
                        {/block}
                    {/foreach}
                    </tbody>
                </table>
            {/if}
        </div>
    {/block}
    {block name='snippets-comparelist-dropdown-hint'}
        <div class="comparelist-dropdown-table-body dropdown-body">
            {if !empty($smarty.session.Vergleichsliste->oArtikel_arr) && $smarty.session.Vergleichsliste->oArtikel_arr|@count <= 1}
                {block name='snippets-comparelist-dropdown-more-than-one'}
                    {lang key='productNumberHint' section='comparelist'}
                {/block}
            {else}
                {block name='snippets-comparelist-dropdown-hint-to-compare'}
                    {link class="comparelist-dropdown-table-body-button btn btn-block btn-primary btn-sm"
                        id='nav-comparelist-goto'
                        href="{get_static_route id='vergleichsliste.php'}"
                    }
                        {lang key='gotToCompare'}
                    {/link}
                {/block}
            {/if}
        </div>
    {/block}
{/block}
