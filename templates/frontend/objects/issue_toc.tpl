{**
* templates/frontend/objects/issue_toc.tpl
*
* Copyright (c) 2014-2017 Simon Fraser University Library
* Copyright (c) 2003-2017 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* @brief View of an Issue which displays a full table of contents.
*
* @uses $issue Issue The issue
* @uses $issueTitle string Title of the issue. May be empty
* @uses $issueSeries string Vol/No/Year string for the issue
* @uses $issueGalleys array Galleys for the entire issue
* @uses $hasAccess bool Can this user access galleys for this context?
* @uses $showGalleyLinks bool Show galley links to users without access?
* @uses $page string to display current site page
*}
<div class="issue-toc">
	{* Indicate if this is only a preview *}
	{if !$issue->getPublished()}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
	{/if}

	{* Issue introduction area above articles *}
	{* Issue cover image and description*}
	{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
	{assign var="issueDetailsCol" value="8"}
	{if $issueCover && $page!=="index"}
		<div class="heading row">
			<div class="col-md-4 col-xs-12 issue-cover">


				<img class="img-responsive modal-thumbnail issue-cover-img" src="{$issueCover|escape}"
					{if $issue->getLocalizedCoverImageAltText() !=''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"
					{/if} data-toggle="modal" data-target="#issueCover">


				{* Image cover modal *}
				<div class="modal fade modal-img" id="issueCover" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
										aria-hidden="true">&times;</span></button>
								<h4 class="modal-title" id="myModalLabel">{$issue->getIssueSeries()|escape}</h4>
							</div>
							<div class="modal-body">
								<img class="modal-img" src="{$issueCover|escape}"
									{if $issue->getLocalizedCoverImageAltText() !=''}
									alt="{$issue->getLocalizedCoverImageAltText()|escape}" {/if}>
							</div>
							<div class="modal-footer">
								<button class="modal-resize close"><span class="glyphicon glyphicon-fullscreen aria-hidden="
										true"></span></button>
						</div>
					</div>
				</div>
			</div>

		</div> {* /.col *}

		<div class="issue-details col-md-{$issueDetailsCol} col-xs-12">
			
			{* Published date *}
			{if $issue->getDatePublished() && $page!=="index" && $issue->getData('urlPath') !== 'just_accepted'}
			<p class="series">{$issueSeries|escape}</p>
			<p class="published">

				{translate key="plugins.themes.ibsscustom.submissions.published"}:

				{$issue->getDatePublished()|escape|date_format:$dateFormatShort}
			</p>
			{/if}

			{if $issue->hasDescription() && $page!=="index"}
			<div class="description">
				{$issue->getLocalizedDescription()|strip_unsafe_html}
			</div>
			{/if}

			{* PUb IDs (eg - DOI) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
			{if $issue->getPublished()}
			{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
			{else}
			{assign var=pubId value=$pubIdPlugin->getPubId($issue)}{* Preview pubId *}
			{/if}
			{if $pubId}
			{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
			<p class="pub_id {$pubIdPlugin->getPubIdType()|escape}">
				<strong>
					{$pubIdPlugin->getPubIdDisplayType()|escape}:
				</strong>
				{if $doiUrl}
				<a href="{$doiUrl|escape}">
					{$doiUrl}
				</a>
				{else}
				{$pubId}
				{/if}
			</p>
			{/if}
			{/foreach}
		</div>
	</div>
	{/if}

	{* Full-issue galleys *}
	{if $issueGalleys}
	<div class="galleys">
		<div class="page-header">
			<h2>
				<small>{translate key="plugins.themes.ibsscustom.issue.fullIssue"}</small>
			</h2>
		</div>
		<div class="btn-group" role="group">
			{foreach from=$issueGalleys item=galley}
			{include file="frontend/objects/galley_link.tpl" parent=$issue
			purchaseFee=$currentJournal->getSetting('purchaseIssueFee')
			purchaseCurrency=$currentJournal->getSetting('currency')}
			{/foreach}
		</div>
	</div>
	{/if}

	{* Articles *}
	<div class="sections">
		{foreach name=sections from=$publishedSubmissions item=section}
		<section class="section">
			{if $section.articles}
			{if $section.title}
			<div class="page-header">
				<h2 class="section-title">
					<small>{$section.title|escape}</small>
				</h2>
			</div>
			{/if}
			<div class="">
				{foreach from=$section.articles item=article}
				{include file="frontend/objects/article_summary.tpl"}
				{/foreach}
			</div>
			{/if}
		</section>
		{/foreach}
	</div><!-- .sections -->
</div><!-- .issue-toc -->