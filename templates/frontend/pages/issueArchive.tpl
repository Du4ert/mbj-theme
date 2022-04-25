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

  {* <div class="page-header">
    <h1>
     {translate key="archive.archives"}
    </h1>
  </div> *}

  {* Just accepted functional *}
  {assign var="just_accepted" value=null}

  {* No issues have been published *}
  {if empty($issues)}
    <div class="alert alert-info" role="alert">
      {translate key="current.noCurrentIssueDesc"}
    </div>
  {else}

    {* List issues *}
    {assign var=currentYear value=''}
    <div class="issues media-list">
      <table class="issues-custom">
        <thead>
          <tr class="issues-head-custom">
            <td class="issues-year-custom">{translate key="plugins.themes.ibsscustom.issue.archive.year"}</td>
            <td class="issues-series-custom">{translate key="plugins.themes.ibsscustom.issue.archive.issue"}</td>
          </tr>
        </thead>
        <tbody class="issues-body-custom"> {assign var=first value=true}
          {* {foreach from=$issues|@array_reverse item="issue"}   обратная нумерация выпусков*}
            {foreach from=$issues item="issue"}
              {assign var=year value=$issue->_data.year}
              {assign var=vol value=$issue->_data.volume}
              {assign var=num value=$issue->_data.number}
              {if !$year && !$vol && !$num && $issue->getData('urlPath') === 'just_accepted'}
                {$just_accepted = $issue}
                {continue}
              {/if}

              {capture assign="numPrint"}
                {if $num}
                  {translate key="plugins.themes.ibsscustom.issue.archive.number"} {$num}
                {/if}
              {/capture}
              {capture assign="volPrint"}
                {if $vol && $issue->getData('showVolume')}
                  {translate key="plugins.themes.ibsscustom.issue.archive.vol"} {$vol}
                {/if}
              {/capture}

              {if $first}
                <tr>
                {/if}
                {if $year!=$currentYear}
                  {assign var=first value=false}
                  </td>
                </tr>
                {assign var=currentYear value=$year}
                <td class="issues-year-custom">{$currentYear}</td>
                <td class="issues-series-custom"><a
                    href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$volPrint} {$numPrint}</a>
                {else}
                  <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$volPrint} {$numPrint}</a>
                {/if}

              {/foreach}
            </td>
            </tr>
          </tbody>
        </table>

        {if !!$just_accepted}
          <div class="just-accepted"><a class="btn btn-primary"
              href="{url op="view" path=$just_accepted->getBestIssueId($currentJournal)}">{$just_accepted->getLocalizedTitle()|escape}</a>
          </div>
        {/if}
      </div>

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