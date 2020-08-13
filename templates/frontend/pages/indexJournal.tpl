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
	<div class="col-md-5 col-sm-4">
		{call_hook name="Templates::Index::journal"}

		{if $homepageImage}
			<div class="homepage-image">
				<img class="img-responsive" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
			</div>
		{/if}

		{if $additionalHomeContent}
			<section class="additional_content">
				{$additionalHomeContent}
			</section>
		{/if}

	</div>
	<div class="col-md-7 col-sm-8">
		{if $journalDescription}
			<div class="">
				{$journalDescription}
			</div>
		{/if}
	</div>
</div>

	{* Announcements *}
	{if $numAnnouncementsHomepage && $announcements|count}
		<section class="cmp_announcements media">
			<header class="page-header">
				<h2>
					{translate key="announcement.announcements"}
				</h2>
			</header>
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
		<section class="current_issue">
			<header class="page-header">
				<h2>
				{translate key="journal.currentIssue"}
				</h2>
			</header>
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
