{**
 * templates/frontend/components/searchForm_simple.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Simple display of a search form with just text input and search button
 *
 * @uses $searchQuery string Previously input search query
 *}
{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
<form id="search" class="navbar-form navbar-left search-form" role="search" method="post" action="{url page="search" op="search"}">
  <div class="form-group search">
    <input class="form-control search-input" placeholder="{translate key="common.search"}..." name="query" value="{$searchQuery|escape}" type="text" aria-label="{translate|escape key="common.searchQuery"}" placeholder="">
    <span class="search-icon glyphicon glyphicon-search"></span>
  </div>
  
  {* <button type="submit" class="btn btn-primary"><span class="search-icon glyphicon glyphicon-search"></span></button> *}
  {* {translate key="common.search"} *}
</form>
{/if}
