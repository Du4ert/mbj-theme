{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentJournal Journal The current journal
 * @uses $submissionChecklist array List of requirements for submissions
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div id="main-content" class="page page_submissions">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"}

	{* Page Title *}
	<div class="page-header">
		{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission"}
		<h1>{translate key="plugins.themes.ibsscustom.submissions.title"}</h1>
	</div>
	{* /Page Title *}

	{** Requires extraFields plugin *}
	{if $customGuidelines}
		<div class="alert alert-info submission-download">
			{$customGuidelines}
		</div>
	{/if}
	{* /Requires extraFields plugin *}


	{* Login/register prompt *}
	{assign var="contactEmail" value=$currentContext->getData('contactEmail')|escape}
	{if $isUserLoggedIn}
		{capture assign="newSubmission"}<a
			href="{url page="submission" op="wizard"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
		{capture assign="viewSubmissions"}<a
			href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
		<div class="alert alert-info">
			{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
		</div>
		<div class="alert alert-info">
			{translate key="plugins.themes.ibsscustom.submissions.registered.send"} <a
				href="mailto:{$contactEmail}">{$contactEmail}</a>.
		</div>

	{else}
		{if !$disableUserReg}
			{capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
			{capture assign="register"}<a
				href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
			<div class="alert alert-info">
				{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
			</div>
			<div class="alert alert-info">
				{translate key="plugins.themes.ibsscustom.submissions.registered.send"} <a
					href="mailto:{$contactEmail}">{$contactEmail}</a>.
			</div>
		{else}
			<div class="alert alert-info submission-email">
				{translate key="plugins.themes.ibsscustom.submissions.unregistered.send"} <a
					href="mailto:{$contactEmail}">{$contactEmail}</a>.
			</div>
		{/if}

	{/if}

	{* Submission Checklist *}
	{if $submissionChecklist}
		<div class="submission_checklist">
			<div class="page-header">
				<h2>
					{translate key="about.submissionPreparationChecklist"}
				</h2>
			</div>
			<p class="lead description submission-description-custom">
				{translate key="plugins.themes.ibsscustom.submissionPreparationChecklist.description"}
			</p>
			<ul class="list-group">
				{foreach from=$submissionChecklist item=checklistItem}
					<li class="list-group-item">
						<span class="glyphicon glyphicon-check" aria-hidden="true"></span>
						<span class="item-content">{$checklistItem.content|nl2br}</span>
					</li>
				{/foreach}
			</ul>

		</div>
	{/if}
	{* /Submission Checklist *}

	{* Author Guidelines *}
	{if $currentJournal->getLocalizedSetting('authorGuidelines')}
		<div class="author_guidelines" id="author_guidelines">
			<h2 class="page-header">
				{translate key="about.authorGuidelines"}
			</h2>
			{$currentJournal->getLocalizedSetting('authorGuidelines')}
		</div>
	{/if}
	{* /Author Guidelines *}

	{* Copyright Notice *}
	{if $currentJournal->getLocalizedSetting('copyrightNotice')}
		<div class="copyright-notice">
			<h2 class="page-header">
				{translate key="about.copyrightNotice"}
				</span>
			</h2>
			{$currentJournal->getLocalizedSetting('copyrightNotice')}
		</div>
	{/if}
	{* /Copyright Notice *}

</div><!-- .page -->

{include file="common/frontend/footer.tpl"}