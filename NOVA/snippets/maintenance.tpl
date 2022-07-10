{block name='snippets-maintenance'}
    {block name='snippets-maintenance-header-doctype'}<!DOCTYPE html>{/block}
    <html {block name='snippets-maintenance-header-html-attributes'}lang="{$meta_language}" itemscope {if $nSeitenTyp === $smarty.const.URLART_ARTIKEL}itemtype="https://schema.org/ItemPage"
          {elseif $nSeitenTyp === $smarty.const.URLART_KATEGORIE}itemtype="https://schema.org/CollectionPage"
          {else}itemtype="https://schema.org/WebPage"{/if}{/block}>
    {block name='snippets-maintenance-header-head'}
        <head>
            {block name='snippets-maintenance-header-head-meta'}
                <meta http-equiv="content-type" content="text/html; charset={$smarty.const.JTL_CHARSET}">
                <meta name="description" itemprop="description" content={block name='snippets-maintenance-header-head-meta-description'}"{$meta_description|truncate:1000:"":true}{/block}">
                {if !empty($meta_keywords)}
                    <meta name="keywords" itemprop="keywords" content="{block name='snippets-maintenance-header-head-meta-keywords'}{$meta_keywords|truncate:255:'':true}{/block}">
                {/if}
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="robots" content="{if $robotsContent}{$robotsContent}{elseif $bNoIndex === true  || (isset($Link) && $Link->getNoFollow() === true)}noindex{else}index, follow{/if}">

                <meta itemprop="url" content="{$cCanonicalURL}"/>
                <meta property="og:type" content="website" />
                <meta property="og:site_name" content="{$meta_title}" />
                <meta property="og:title" content="{$meta_title}" />
                <meta property="og:description" content="{$meta_description|truncate:1000:"":true}" />
                <meta property="og:url" content="{$cCanonicalURL}"/>

                {if $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && !empty($Artikel->Bilder)}
                    <meta itemprop="image" content="{$Artikel->Bilder[0]->cURLGross}" />
                    <meta property="og:image" content="{$Artikel->Bilder[0]->cURLGross}">
                {elseif $nSeitenTyp === $smarty.const.PAGE_NEWSDETAIL && !empty($newsItem->getPreviewImage())}
                    <meta itemprop="image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}" />
                    <meta property="og:image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}" />
                {else}
                    <meta itemprop="image" content="{$ShopLogoURL}" />
                    <meta property="og:image" content="{$ShopLogoURL}" />
                {/if}

            {/block}
            <title itemprop="name">{block name='snippets-maintenance-header-head-title'}{$meta_title}{/block}</title>

            {if !empty($cCanonicalURL)}
                <link rel="canonical" href="{$cCanonicalURL}">
            {/if}

            {block name='snippets-maintenance-header-head-icons'}
                <link type="image/x-icon" href="{$shopFaviconURL}" rel="icon">
            {/block}

            {block name='snippets-maintenance-header-head-resources'}
                {if empty($parentTemplateDir)}
                    {$templateDir = $currentTemplateDir}
                {else}
                    {$templateDir = $parentTemplateDir}
                {/if}
                <style id="criticalCSS">
                    {file_get_contents("{$currentThemeDir}{$Einstellungen.template.theme.theme_default}_crit.css")}
                </style>
                {* css *}
                {if $Einstellungen.template.general.use_minify === 'N'}
                    {foreach $cCSS_arr as $cCSS}
                        <link rel="stylesheet" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}">
                    {/foreach}
                    <noscript>
                        {foreach $cCSS_arr as $cCSS}
                            <link rel="stylesheet" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}">
                        {/foreach}
                        {if isset($cPluginCss_arr)}
                            {foreach $cPluginCss_arr as $cCSS}
                                <link href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" rel="stylesheet">
                            {/foreach}
                        {/if}
                    </noscript>
                {else}
                    <link rel="stylesheet" href="{$ShopURL}/{$combinedCSS}" type="text/css" >
                    <noscript>
                        <link href="{$ShopURL}/{$combinedCSS}" rel="stylesheet">
                    </noscript>
                {/if}

                {if !empty($smarty.session.Sprachen) && count($smarty.session.Sprachen) > 1}
                    {foreach $smarty.session.Sprachen as $language}
                        <link rel="alternate" hreflang="{$language->getIso639()}" href="{$language->getUrl()}">
                    {/foreach}
                {/if}
                <script src="{$ShopURL}/{$templateDir}js/jquery-3.5.1.min.js"></script>
                <script defer src="{$ShopURL}/{$templateDir}js/bootstrap.bundle.js"></script>
            {/block}
        </head>
    {/block}
        {block name='snippets-maintenance-content'}
        <body id="main-wrapper" class="maintenance-main-wrapper text-center-util font-size-1.5x vh-100">
            {container class="maintenance-main" fluid=true}
                {block name='snippets-maintenance-content-language'}
                    {row}
                        {col class="maintenance-main-item" cols=12 md=6 offset-md=3}
                        {strip}
                            {nav tag='ul' class='nav-dividers'}
                                {block name='snippets-maintenance-content-include-language-dropdown'}
                                    {include file='snippets/language_dropdown.tpl' dropdownClass='mx-auto'}
                                {/block}
                            {/nav}
                        {/strip}
                        {/col}
                    {/row}
                {/block}
                {block name='snippets-maintenance-content-maintenance'}
                     {row}
                        {col class="maintenance-main-item" cols=12 md=6 offset-md=3}
                            {block name='snippets-maintenance-content-maintenance-logo'}
                                {if isset($ShopLogoURL)}
                                    {image src=$ShopLogoURL
                                        alt=$Einstellungen.global.global_shopname
                                        class="maintenance-main-image"
                                        style="{if $ShopLogoURL|strpos:'.svg' !== false}height: 100px;{/if}"}
                                {else}
                                    <span class="h1">{$Einstellungen.global.global_shopname}</span>
                                {/if}
                            {/block}
                            {block name='snippets-maintenance-content-maintenance-heading'}
                                <h1 class="maintenance-main-heading">{lang key='maintainance'}</h1>
                            {/block}
                            {block name='snippets-maintenance-content-maintenance-notice'}
                                <div class="maintenance-main-notice">
                                    <p>{lang key='maintenanceModeActive'}</p>
                                </div>
                            {/block}
                        {/col}
                    {/row}
                {/block}
                {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_IMPRESSUM])}
                {block name='snippets-maintenance-content-imprint'}
                    {row id="footer" class="flex-grow-1"}
                        {col cols=12 class="small" md=6 offset-md=3}
                            <h2 class="mt-2">{$oSpezialseiten_arr[$smarty.const.LINKTYP_IMPRESSUM]->getTitle()}</h2>
                            <p>{$oSpezialseiten_arr[$smarty.const.LINKTYP_IMPRESSUM]->getContent()}</p>
                        {/col}
                    {/row}
                {/block}
                {/if}
            {/container}
        </body>
        {/block}
    </html>
{/block}
