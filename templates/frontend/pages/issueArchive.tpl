{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of recent issues.
 *
 * @uses $issues Array Collection of issues to display
 * @uses $prevPage int The previous page number
 * @uses $nextPage int The next page number
 * @uses $showingStart int The number of the first item on this page
 * @uses $showingEnd int The number of the last item on this page
 * @uses $total int Count of all published monographs
 *}
 {capture assign="pageTitle"}
  {if $prevPage}
    {translate key="archive.archivesPageNumber" pageNumber=$prevPage+1}
  {else}
    {translate key="archive.archives"}
  {/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}

<div id="main-content" class="page page_issue_archive">
  {include file="frontend/components/breadcrumbs.tpl" currentTitle=$pageTitle}

  {if $journals < 2}
    {* No issues have been published *}
      {include file="frontend/objects/issues.tpl" issues=$issues journal=$currentJournal}
      {else}
        {foreach from=$journals|@array_reverse item="journal"}
          {capture assign="url"}{url journal=$journal->getPath()}{/capture}
					{assign var="thumb" value=$journal->getLocalizedSetting('journalThumbnail')}
						<div class="archive-journal">
            {* <div class="d-none d-sm-block col-md-3 col-sm-4"> *}
            {if $thumb}
              <div class="journal-thumbnail">
                <a href="{$url|escape}">
                  <img src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $thumb.altText} alt="{$thumb.altText|escape|default:''}"{/if}>
                </a>
              </div>
            {/if}
          {* </div> *}
          {* <div class="col-md-9 col-sm-8 col-xs-12"> *}
            <div class="journal-data">
              <div class="journal-title"><a href="{$url|escape}" rel="bookmark">{$journal->getLocalizedName()}</a></div>
              <div class="journal-issues">{include file="frontend/objects/issues.tpl" issues=$allIssues[$journal->getId()] journal=$journal}</div>
            </div>
          {* </div> *}
           </div>
        {/foreach}
  {/if}
</div>

  {* Pagination *}
  {if $prevPage > 1}
    {capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$prevPage}{/capture}
  {elseif $prevPage === 1}
    {capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}{/capture}
  {/if}
  {if $nextPage}
    {capture assign=nextUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$nextPage}{/capture}
  {/if}

  {include
      file="frontend/components/pagination.tpl"
      prevUrl=$prevUrl
      nextUrl=$nextUrl
      showingStart=$showingStart
      showingEnd=$showingEnd
      total=$total
    }

  {include file="common/frontend/footer.tpl"}