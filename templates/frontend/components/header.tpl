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

{* Determine whether a logo or title string is being displayed *}
{assign var="showingLogo" value=true}
{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
	{assign var="showingLogo" value=false}
{/if}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<!-- Yandex.Metrika counter -->
<script type="text/javascript" >
    (function (d, w, c) {
        (w[c] = w[c] || []).push(function() {
            try {
                w.yaCounter47688874 = new Ya.Metrika({
                    id:47688874,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true
                });
            } catch(e) { }
        });

        var n = d.getElementsByTagName("script")[0],
            s = d.createElement("script"),
            f = function () { n.parentNode.insertBefore(s, n); };
        s.type = "text/javascript";
        s.async = true;
        s.src = "https://mc.yandex.ru/metrika/watch.js";

        if (w.opera == "[object Opera]") {
            d.addEventListener("DOMContentLoaded", f, false);
        } else { f(); }
    })(document, window, "yandex_metrika_callbacks");
</script>

{* Версия для слабовидящих *}
<script src="https://lidrekon.ru/slep/js/jquery.js"></script>
<script src="https://lidrekon.ru/slep/js/uhpv-full.min.js"></script>

<noscript><div><img src="https://mc.yandex.ru/watch/47688874" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}">
	<div class="pkp_structure_page">
		<nav id="accessibility-nav" class="sr-only" role="navigation" aria-labelled-by="accessible-menu-label">
			<div id="accessible-menu-label">
				{translate|escape key="plugins.themes.bootstrap3.accessible_menu.label"}
			</div>
			<ul>
			  <li><a href="#main-navigation">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.main_navigation"}</a></li>
			  <li><a href="#main-content">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.main_content"}</a></li>
			  <li><a href="#sidebar">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.sidebar"}</a></li>
			</ul>
		</nav>

		{* Header *}
		<header class="navbar navbar-default" id="headerNavigationContainer" role="banner">
			{* User profile, login, etc, navigation menu*}
			<div class="container-fluid">
				<div class="row">
					<nav aria-label="{translate|escape key="common.navigation.user"}">
					
						{load_menu name="user" id="navigationUser" ulClass="nav nav-pills tab-list pull-right"}
						<div class="block" id="sidebarLanguageToggle">
						<span class="blockTitle" style="display:none;">{translate key="common.language"}</span>
						<ul class="langul pull-right">
						
							{assign 'languageToggleLocales' ['ru_RU'=> 'Русский', 'en_US' => 'English']}
								{foreach from=$languageToggleLocales item=localeName key=localeKey}
									<li class="pull-left locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if} langli">
										<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$localeKey source=$smarty.server.REQUEST_URI}">
											<img title="{$localeName}" src="/plugins/themes/{$contextSettings.themePluginPath}/locale/{$localeKey}/flag.png" />
										</a>
									</li>
								{/foreach}
						</ul>
					</div>
					<div class="special">
						<a id="specialButton" href="#"><img src="/plugins/themes/{$contextSettings.themePluginPath}/img/special_white.png" alt="ВЕРСИЯ ДЛЯ СЛАБОВИДЯЩИХ" title="ВЕРСИЯ ДЛЯ СЛАБОВИДЯЩИХ" /></a>
					</div>
					</nav>
				</div><!-- .row -->
			</div><!-- .container-fluid -->

			<div class="container-fluid">

				<div class="navbar-header">

					{* Mobile hamburger menu *}
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-menu" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>

					{* Logo or site title. Only use <h1> heading on the homepage.
					   Otherwise that should go to the page title. *}
					{if $requestedOp == 'index'}
						<h1 class="site-name">
					{else}
						<div class="site-name">
					{/if}
						{capture assign="homeUrl"}
							{if $currentJournal && $multipleContexts}
								{url page="index" router=$smarty.const.ROUTE_PAGE}
							{else}
								{url context="index" router=$smarty.const.ROUTE_PAGE}
							{/if}
						{/capture}
						{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
							<a href="{$homeUrl}" class="navbar-brand navbar-brand-logo">
								<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{/if}>
							</a>
						{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
							<a href="{$homeUrl}" class="navbar-brand">{$displayPageHeaderTitle}</a>
						{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
							<a href="{$homeUrl}" class="navbar-brand navbar-brand-logo">
								<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" alt="{$displayPageHeaderTitle.altText|escape}">
							</a>
						{else}
							<a href="{$homeUrl}" class="navbar-brand">
								<img src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}" title="{$applicationName|escape}" />
							</a>
						{/if}
					{if $requestedOp == 'index'}
						</h1>
					{else}
						</div>
					{/if}

				</div>

				{* Primary site navigation *}
				{capture assign="primaryMenu"}
					{load_menu name="primary" id="main-navigation" ulClass="nav navbar-nav"}
				{/capture}

				{if !empty(trim($primaryMenu)) || !$noContextsConfigured}
					<nav id="nav-menu" class="navbar-collapse collapse" aria-label="{translate|escape key="common.navigation.site"}">
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

			</div><!-- .pkp_head_wrapper -->
		</header><!-- .pkp_structure_head -->

		{* Wrapper for page content and sidebars *}
		<div class="pkp_structure_content container">
			<main class="pkp_structure_main col-xs-12 col-sm-9 col-md-9" role="main">
