{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}


{include file="frontend/components/header_head.tpl"}

<body
    class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}">
        {call_hook name="Themes::ibsscustom::custom"}
    <div class="pkp_structure_page">
        <nav id="accessibility-nav" class="sr-only" role="navigation" aria-labelled-by="accessible-menu-label">
            <div id="accessible-menu-label">
                {translate|escape key="plugins.themes.ibsscustom.accessible_menu.label"}
            </div>
            <ul>
                <li><a
                        href="#main-navigation">{translate|escape key="plugins.themes.ibsscustom.accessible_menu.main_navigation"}</a>
                </li>
                <li><a
                        href="#main-content">{translate|escape key="plugins.themes.ibsscustom.accessible_menu.main_content"}</a>
                </li>
                <li><a href="#sidebar">{translate|escape key="plugins.themes.ibsscustom.accessible_menu.sidebar"}</a>
                </li>
            </ul>
        </nav>

        {* Header *}
        <header class="header-custom navbar navbar-default" id="headerNavigationContainer" role="banner">
            {* User profile, login, etc, navigation menu*}
            <div class="container-fluid">
            <div class="row">
            <ul class="lightrope">
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-sm"></li>
                         <li class="hidden-xs"></li>
                         <li class="hidden-xs"></li>
                         <li class="hidden-xs"></li>
                         <li class="hidden-xs"></li>
                         <li class="hidden-xs"></li>
                         <li class="hidden-xs"></li>
                         <li class="hidden-xs"></li>
                         <li></li>
                         <li></li>
                         <li></li>
            </ul>
        </div>
                <div class="row">
                    <nav aria-label="{translate|escape key="common.navigation.user"}"
                        class="navbar navbar-default top-navigation">
                        {load_menu name="user" id="navigationUser" ulClass="nav nav-pills tab-list pull-right"}
                        <div class="block" id="sidebarLanguageToggle">
                            <span class="blockTitle" style="display:none;">{translate key="common.language"}</span>
                            <ul class="langul pull-right">

                                {assign 'languageToggleLocales' ['ru_RU'=> 'Русский', 'en_US' => 'English']}
                                {foreach from=$languageToggleLocales item=localeName key=localeKey}
                                    <li
                                        class="pull-left locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if} langli">
                                        <a
                                            href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$localeKey source=$smarty.server.REQUEST_URI}">
                                            <img title="{$localeName}"
                                                src="/plugins/themes/{$currentContext->getData('themePluginPath')}/locale/{$localeKey}/flag.png" />
                                        </a>
                                    </li>
                                {/foreach}
                            </ul>
                        </div>
                        <div class="pull-left leftTop">
                        {if $activeTheme->getOption('specialVisionOn')}
                            <div class="special">
                                <a id="specialButton" href="#"><img
                                        src="/plugins/themes/{$currentContext->getData('themePluginPath')}/img/special_white.png"
                                        alt="ВЕРСИЯ ДЛЯ СЛАБОВИДЯЩИХ" title="ВЕРСИЯ ДЛЯ СЛАБОВИДЯЩИХ" /></a>
                            </div>
                        {/if}
                            <div class="homeTopLink">
                                {capture assign="homeLinkUrl"}
                                    {if $currentJournal && $multipleContexts}
                                        {url page="index" router=$smarty.const.ROUTE_PAGE}
                                    {else}
                                        {url context="index" router=$smarty.const.ROUTE_PAGE}
                                    {/if}
                                {/capture}
                                    <a href="{$homeLinkUrl}" id="homeButton">
                                        <span class="glyphicon glyphicon-home" aria-hidden="true"></span>Home</a>
                            </div>
                        </div>
                    </nav>
                </div><!-- .row -->
            </div><!-- .container-fluid -->

            <div class="container">
                <div class="row">

                <div class="header-hero clearfix more-snow">
                   	 {* Logo or site title. Only use <h1> heading on the homepage.
						   Otherwise that should go to the page title. *}
                            {capture assign="homeUrl"}
                                {if $currentJournal && $multipleContexts}
                                    {url page="index" router=$smarty.const.ROUTE_PAGE}
                                {else}
                                    {url context="index" router=$smarty.const.ROUTE_PAGE}
                                {/if}
                            {/capture}
                            {if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
                                <a href="{$homeUrl}" class="hero-logo">
                                    <img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" class="hero-logo-img"
                                        {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
                                        {/if}>
                                        <span class="glyphicon glyphicon-tree-conifer christmas-tree" aria-hidden="true"></span>
                                </a>
                            {/if}
                            {if $displayPageHeaderTitle}
                                {if $requestedOp == 'index' }
                                    <h1 class="site-name">
                                {else}
                                    <div class="site-name">
                                {/if}
                                {if is_string($displayPageHeaderTitle)}
                                    <a href="{$homeUrl}" class="hero-title">
                                        {$displayPageHeaderTitle}
                                    </a>
                                    {elseif is_array($displayPageHeaderTitle)}
                                    <a href="{$homeUrl}" class="hero-logo-img">
                                            <img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}"
                                                alt="{$displayPageHeaderTitle.altText|escape}">
                                    </a>
                                {/if}
                                {if $requestedOp == 'index'}
                                    </h1> {* /h1.site-name *}
                                    {else}
                                    </div> {* /div.site-name *}
                                {/if}
                            {/if}
                            
                    </div> {* /.header-hero *}
                    </div> {* / .row*}
                </div> {*/ .container*}



		 <div class="container">
         <div class="row">
             <div class="main-navigation">
                         <div class="navbar-header">
                             {* Mobile hamburger menu *}
                             <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-menu"
                                 aria-expanded="false" aria-controls="navbar">
                                 <span class="sr-only">Toggle navigation</span>
                                 <span class="icon-bar"></span>
                                 <span class="icon-bar"></span>
                                 <span class="icon-bar"></span>
                             </button>
                         </div>
             
                         {* Primary site navigation *}
                         {capture assign="primaryMenu"}
                             {load_menu name="primary" id="main-navigation" ulClass="nav navbar-nav" liClass="main-navigation-item"}
                         {/capture}
             
                         {if !empty(trim($primaryMenu)) || !$noContextsConfigured}
                             <nav id="nav-menu" class="navbar-collapse collapse"
                                 aria-label="{translate|escape key="common.navigation.site"}">
                                 {* Primary navigation menu for current application *}
                                 {$primaryMenu}
             
                                 {* Search form *}
                                 {if !$noContextsConfigured}
                                     <div class="pull-md-right">
                                         {include file="frontend/components/searchForm_simple.tpl"}
                                     </div>
                                 {/if}
                             </nav>
                         {/if}
                     </div> {* /.main-navigation *}
                     </div> {* /.row *}
         </div> {* / .container*}
    </header><!-- .pkp_structure_head -->
	

    {* Wrapper for page content and sidebars *}
    <div class="pkp_structure_content container">
        <main class="pkp_structure_main col-xs-12 col-sm-9 col-md-9" role="main">