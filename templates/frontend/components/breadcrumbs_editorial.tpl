{**
 * templates/frontend/components/breadcrumbs_issue.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item showing the current page. This basic
 *  version is for top-level pages which only need to show the Home link. For
 *  category- and series-specific breadcrumb generation, see
 *  templates/frontend/components/breadcrumbs_catalog.tpl.
 *
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 *}

<nav class="cmp_breadcrumbs" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
  <ol class="breadcrumb">
    <li>
      <a href="{url page="index" router=$smarty.const.ROUTE_PAGE}">
        {translate key="common.homepageNavigationLabel"}
      </a>
    </li>
    <li>
      <a href="{url router=$smarty.const.ROUTE_PAGE page="about" op="editorialTeam"}">
        {translate key="plugins.themes.ibsscustom.editorial.title"}
      </a>
    </li>
    <li class="active">
      {if $currentTitleKey}
        {translate key=$currentTitleKey}
      {else}
        {$currentTitle|escape}
      {/if}
    </li>
  </ol>
</nav>
