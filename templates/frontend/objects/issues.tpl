{if empty($issues)}
    <div class="alert alert-info" role="alert">
      {translate key="current.noCurrentIssueDesc"}
    </div>
  {else}
      {* Just accepted functional *}
      {assign var="just_accepted" value=null}
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
                      href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">{$volPrint} {$numPrint}</a>
                  {else}
                    <a href="{url journal=$journal->getPath()  page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">{$volPrint} {$numPrint}</a>
                  {/if}
  
                {/foreach}
              </td>
              </tr>
            </tbody>
          </table>
  
          {if !!$just_accepted}
            <div class="just-accepted"><a class="btn btn-primary"
                href="{url journal=$journal->getPath() page="issue" op="view"  path=$just_accepted->getBestIssueId($currentJournal)}">{$just_accepted->getLocalizedTitle()|escape}</a>
            </div>
          {/if}
        </div>
        {/if}
  