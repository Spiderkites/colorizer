{block name='snippets-notification'}
    {card no-body=true class="snippets-notification clearfix {if isset($inline)} m-0{/if}"}
        {if isset($title)}
            {cardheader}
                {block name='snippets-notification-title'}
                    {$title}
                {/block}
            {/cardheader}
        {/if}

        {cardbody class="notification-alert bg-{if isset($type)}{$type}{else}info{/if}"}
            {block name='snippets-notification-body'}
                {$body}
            {/block}
        {/cardbody}

        {if isset($buttons)}
            {cardfooter}
                {block name='snippets-notification-footer'}
                    {buttongroup class="d-block"}
                        {foreach $buttons as $button}
                            {link
                                href="{get_static_route id=$button->href}"
                                class="btn{if isset($button->primary) && $button->primary} btn-primary{else} btn-outline-primary{/if}"
                                data=["dismiss"=>"{if isset($button->dismiss)}{$button->dismiss}{/if}"]
                                aria=["label"=>"{if isset($button->dismiss)}Close{/if}"]
                            }
                                {block name='snippets-notification-footer-button'}
                                    {if isset($button->fa)}<i class="fa {$button->fa}"></i>{/if}
                                    {$button->title}
                                {/block}
                            {/link}
                        {/foreach}
                    {/buttongroup}
                {/block}
            {/cardfooter}
        {/if}
    {/card}
{/block}
