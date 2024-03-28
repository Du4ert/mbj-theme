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
					<img class="img-responsive" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}"
						alt="{$homepageImageAltText|escape}">
					<div class="metrics">
					{* <h4>Основные показатели:</h4> *}
						<div class="metric metric-elibrary">
							<div class="metric-title">
								Elibrary:
							</div>
							<div class="metric-values">
								<a href="https://elibrary.ru/title_profile.asp?id=58449">
									<span class="badge badge-elibrary">Sc Index: 783</span>
								</a>
								<a href="https://www.scimagojr.com/journalsearch.php?q=21100944725&tip=sid&exact=no">
									<span class="badge badge-elibrary">Percentile: 20</span>
								</a>
							</div>
						</div>
						<div class="metric metric-scopus">
							<div class="metric-title">
								Scopus:
							</div>
							<div class="metric-values">
								<a href="https://www.scopus.com/sourceid/21100944725">
									<span class="badge badge-scopus">CiteScore: 0.9</span>
								</a>
								<a href="https://www.scopus.com/sourceid/21100944725">
									<span class="badge badge-scopus">SJR: 0.288</span>
								</a>
							</div>
						</div>
						<div class="metric metric-scimago">
							<div class="metric-title">
								Scimago:
							</div>
							<div class="metric-values">
								<a href="https://www.scimagojr.com/journalsearch.php?q=21100944725&tip=sid&exact=no">
									<span class="badge badge-scimago">H-index: 7</span>
								</a>
								<a href="https://www.scimagojr.com/journalsearch.php?q=21100944725&tip=sid&exact=no">
									<span class="badge badge-scimago">SJR: 0.29</span>
								</a>
							</div>
						</div>
					</div>
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