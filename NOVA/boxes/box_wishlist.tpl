{block name='boxes-box-wishlist'}
    {if $oBox->getItems()|count > 0}
        <div class="box box-wishlist box-normal" id="sidebox{$oBox->getID()}">
            {block name='boxes-box-wishlist-content'}
                {block name='boxes-box-wishlist-toggle-title'}
                    {link id="crd-hdr-{$oBox->getID()}"
                        href="#crd-cllps-{$oBox->getID()}"
                        data=["toggle"=>"collapse"]
                        role="button"
                        aria=["expanded"=>"false","controls"=>"crd-cllps-{$oBox->getID()}"]
                        class="box-normal-link dropdown-toggle"}
                        {lang key='wishlist'}
                    {/link}
                {/block}
                {block name='boxes-box-wishlist-title'}
                    <div class="productlist-filter-headline align-items-center-util d-none d-md-flex">
                        <i class='fa fa-heart icon-mr-2'></i>
                        {lang key='wishlist'}
                    </div>
                {/block}
                {block name='boxes-box-wishlist-collapse'}
                    {collapse
                        class="d-md-block"
                        visible=false
                        id="crd-cllps-{$oBox->getID()}"
                        aria=["labelledby"=>"crd-hdr-{$oBox->getID()}"]}
                            {assign var=maxItems value=$oBox->getItemCount()}
                        <table class="table table-vertical-middle table-striped table-img">
                            <tbody>
                                {block name='boxes-box-wishlist-wishlist-items'}
                                {foreach $oBox->getItems() as $wishlistItem}
                                        {if $wishlistItem@iteration > $maxItems}{break}{/if}
                                    <tr>
                                        <td class="w-100-util" data-id={$wishlistItem->kArtikel}>
                                            {block name='boxes-box-wishlist-dropdown-products-image-title'}
                                                {formrow class="align-items-center-util"}
                                                    {if $oBox->getShowImages()}
                                                        {col class="col-auto"}
                                                            {block name='boxes-box-wishlist-dropdown-products-image'}
                                                                {link href=$wishlistItem->Artikel->cURLFull title=$wishlistItem->cArtikelName|escape:'quotes'}
                                                                    {include file='snippets/image.tpl'
                                                                        item=$wishlistItem->Artikel
                                                                        square=false
                                                                        srcSize='xs'
                                                                        sizes='24px'}
                                                                {/link}
                                                            {/block}
                                                        {/col}
                                                    {/if}
                                                    {col}
                                                        {block name='boxes-box-wishlist-dropdown-products-title'}
                                                            {link href=$wishlistItem->Artikel->cURLFull title=$wishlistItem->cArtikelName|escape:'quotes'}
                                                                {$wishlistItem->fAnzahl|replace_delim} &times; {$wishlistItem->cArtikelName|truncate:40:'...'}
                                                            {/link}
                                                        {/block}
                                                    {/col}
                                                {/formrow}
                                            {/block}
                                        </td>
                                        <td class="box-delete-button">
                                            {block name='snippets-wishlist-dropdown-products-remove'}
                                                {link class="remove"
                                                    href=$wishlistItem->cURL
                                                    data=["name"=>"Wunschliste.remove",
                                                    "toggle"=>"product-actions",
                                                    "value"=>['a'=>$wishlistItem->kWunschlistePos]|json_encode|escape:'html'
                                                    ]
                                                    aria=["label"=>"{lang section='login' key='wishlistremoveItem'}"]}
                                                    <span class="fas fa-times"></span>
                                                {/link}
                                            {/block}
                                        </td>
                                {/foreach}
                                {/block}
                            </tbody>
                        </table>
                        {block name='boxes-box-wishlist-actions'}
                            <hr class="hr-no-top">
                            {link href="{get_static_route id='wunschliste.php'}?wl={$oBox->getWishListID()}" class="btn btn-outline-primary btn-block btn-sm"}
                                {lang key='goToWishlist'}
                            {/link}
                        {/block}
                    {/collapse}
                {/block}
            {/block}
            {block name='boxes-box-wishlist-hr-end'}
                <hr class="box-normal-hr">
            {/block}
        </div>
    {else}
        {block name='boxes-box-wishlist-no-items'}
            <section class="d-none box-wishlist" id="sidebox{$oBox->getID()}"></section>
        {/block}
    {/if}
{/block}
