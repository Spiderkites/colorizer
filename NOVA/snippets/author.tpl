{block name='snippets-author'}
    {block name='snippets-author-content'}
        <div class="snippets-author" itemprop="author" itemscope itemtype="https://schema.org/Person">
            {block name='snippets-author-title'}
                {if $showModal|default:true}
                    {link class="author-modal snippets-author-link"
                        href="#"
                        title=$oAuthor->cName
                        data=["target"=>"#author-{$oAuthor->kContentAuthor}"]
                    }
                        <span itemprop="name">
                            {$oAuthor->cName}
                        </span>
                    {/link}
                {else}
                    <span itemprop="name">
                        {$oAuthor->cName}
                    </span>
                {/if}
                &nbsp;&ndash;&nbsp;
                {if isset($cDate)}
                    <span class="creation-date">{$cDate}</span>
                {/if}
            {/block}
            {block name='snippets-author-modal'}
                {if $showModal|default:true}
                    {if !empty($oAuthor->cAvatarImgSrcFull)}
                        {$title = "<img alt='{$oAuthor->cName}' src='{$oAuthor->cAvatarImgSrcFull}' height='80' class='rounded-circle' /><span itemprop='name' class='snippets-author-title'>{$oAuthor->cName}</span>"}
                    {else}
                        {$title = "<span itemprop='name' class='snippets-author-title'>"|cat:$oAuthor->cName|cat:'</span>'}
                    {/if}
                    <div id="author-{$oAuthor->kContentAuthor}" title="{$title}" class="d-none">
                        {block name='snippets-author-modal-content'}
                            {if !empty($oAuthor->cVitaShort)}
                                {if !empty($oAuthor->cAvatarImgSrcFull)}
                                    <meta itemprop="image" content="{$oAuthor->cAvatarImgSrcFull}">
                                {/if}
                                <div itemprop="description">
                                    {$oAuthor->cVitaShort}
                                </div>
                            {/if}
                        {/block}
                    </div>
                {/if}
            {/block}
        </div>
    {/block}
    {block name='snippets-author-publisher'}
        <div itemprop="publisher" itemscope itemtype="https://schema.org/Organization" class="d-none">
            <span itemprop="name">{$meta_publisher}</span>
            <meta itemprop="url" content="{$ShopURL}">
            <meta itemprop="logo" content="{$ShopLogoURL}">
        </div>
    {/block}
{/block}
