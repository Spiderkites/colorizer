{block name='snippets-wishlist-dropdown'}
    {if $wishlists->isNotEmpty()}
        {block name='snippets-wishlist-dropdown-wishlists'}
            <div class="wishlist-dropdown-items table-responsive max-h-sm lg-max-h">
                <table class="table table-vertical-middle">
                    <tbody>
                        {foreach $wishlists as $wishlist}
                            <tr class="clickable-row cursor-pointer" data-href="{get_static_route id='wunschliste.php'}?wl={$wishlist->kWunschliste}">
                                <td>
                                    {block name='snippets-wishlist-dropdown-link'}
                                        {$wishlist->cName}<br />
                                    {/block}
                                    {block name='snippets-wishlist-dropdown-punlic'}
                                        <span data-switch-label-state="public-{$wishlist->kWunschliste}" class="small {if $wishlist->nOeffentlich != 1}d-none{/if}">
                                            {lang key='public'}
                                        </span>
                                    {/block}
                                    {block name='snippets-wishlist-dropdown-private'}
                                        <span data-switch-label-state="private-{$wishlist->kWunschliste}" class="small {if $wishlist->nOeffentlich == 1}d-none{/if}">
                                            {lang key='private'}
                                        </span>
                                    {/block}
                                </td>
                                {block name='snippets-wishlist-dropdown-count'}
                                    <td class="text-right-util text-nowrap-util">
                                        {$wishlist->productCount} {lang key='products'}
                                    </td>
                                {/block}
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        {/block}
    {/if}
    {block name='snippets-wishlist-dropdown-new-wl'}
        <div class="wishlist-dropdown-footer dropdown-body">
            {block name='snippets-wishlist-dropdown-new-wl-link'}
                {button variant="primary" type="link" block=true size="sm" href="{get_static_route id='wunschliste.php'}?newWL=1"}
                    {lang key='addNew' section='wishlist'}
                {/button}
            {/block}
        </div>
    {/block}
{/block}
