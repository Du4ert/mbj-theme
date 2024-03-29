{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * UPDATED/CHANGED/MODIFIED: Marc Behiels - marc@elemental.ca - 250416
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div id="main-content" class="page_index_journal" role="content">
	{include file="frontend/components/editLink.tpl" page="management" op="settings" path="" anchor="" sectionTitleKey=""}

	{call_hook name="Templates::Index::journal"}
<div class="row journal-description journal-description-main">
	<div class="col-md-3 col-sm-3 col-xs-12">

	</div>
	<div class="col-xs-12">
		{if $homepageImage}
			<div class="homepage-image pull-right col-xs-hidden">
				<img class="img-responsive" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
			</div>
		{/if}

		{if $journalDescription}
			<h1 class="journal-description-title">
				{if $displayPageHeaderTitle}
					{$displayPageHeaderTitle}
					<hr />
				{/if}
			</h1>
			<div class="journal-description-content">
				{$journalDescription}
			</div>
		{/if}


		{if $additionalHomeContent}
			<section class="additional_content">
				{$additionalHomeContent}
			</section>
		{/if}
		
	</div>
</div>

	{* Announcements *}
	{if $numAnnouncementsHomepage && $announcements|count}
		<section class="cmp_announcements media">
			<div class="page-header">
				<h2>
					{translate key="announcement.announcements"}
				</h2>
			</div>
			<div class="media-list">
				{foreach name=announcements from=$announcements item=announcement}
					{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
						{break}
					{/if}
					{include file="frontend/objects/announcement_summary.tpl" heading="h3"}
				{/foreach}
			</div>
		</section>
	{/if}


	{* Latest issue *}
	{if $issue}
		<section id="current_issue" class="current_issue">
			<div class="page-header">
				<h2>
				{translate key="journal.currentIssue"}
				</h2>
			</div>
			<p class="current_issue_title lead">
				<a href="{url|escape op="view" page="issue" path=$issue->getBestIssueId()}">
					{$issue->getIssueIdentification()|strip_unsafe_html}
				</a>
			</p>
			{include file="frontend/objects/issue_toc.tpl" page="index"}
			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}" class="btn btn-primary read-more">
				{translate key="journal.viewAllIssues"}
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</section>
	{/if}

	{* Additional Homepage Content *}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
