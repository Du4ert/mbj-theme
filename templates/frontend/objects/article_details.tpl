{**
* templates/frontend/objects/article_details.tpl
*
* Copyright (c) 2014-2017 Simon Fraser University Library
* Copyright (c) 2003-2017 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* @brief View of an Article which displays all details about the article.
* Expected to be primary object on the page.
*
* @uses $article Article This article
* @uses $issue Issue The issue this article is assigned to
* @uses $section Section The journal section this article is assigned to
* @uses $keywords array List of keywords assigned to this article
* @uses $citationFactory @todo
* @uses $pubIdPlugins @todo
*}
<article class="article-details">
	<header>
		<h1 class="page-header">
			{$article->getLocalizedTitle()|escape}
			{if $article->getLocalizedSubtitle()}
			<small>
				{$article->getLocalizedSubtitle()|escape}
			</small>
			{/if}
		</h1>
		{include file="frontend/components/editLink.tpl" page="workflow" op="index"
		path=$article->getBestArticleId($currentJournal) anchor="" sectionTitleKey="about.authorGuidelines"}
	</header>

	<div class="row">

		<section class="article-sidebar col-md-2 col-sm-2 hidden-sm hidden-xs hidden-md">
			{* Article/Issue cover image *}
			{if $article->getLocalizedCoverImage() || $issue->getLocalizedCoverImage()}
			<div class="cover-image">
				{if $article->getLocalizedCoverImage()}
				<img class="img-responsive" src="{$article->getLocalizedCoverImageUrl()|escape}" {if
					$article->getLocalizedCoverImageAltText()}
				alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
				{else}
				<a href="{url page=" issue" op="view" path=$issue->getBestIssueId()}">
					<img class="img-responsive" src="{$issue->getLocalizedCoverImageUrl()|escape}" {if
						$issue->getLocalizedCoverImageAltText()}
					alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
				</a>
				{/if}
			</div>
			{/if}
		</section>





		<section class="article-main col-md-7 col-lg-7 col-md-8">
			{* Screen-reader heading for easier navigation jumps *}
			<h2 class="sr-only">{translate key="plugins.themes.bootstrap3.article.main"}</h2>

			<ul class="article-meta-list">
				{* Authors *}
				{if $article->getAuthors()}
					<li class="article-meta-item authors-short">
				<strong>{capture assign=authors}{translate key="article.authors"}{/capture}{translate key="semicolon" label=$authors}</strong>
					{assign var="affiliations" value=[] }
						{foreach from=$article->getAuthors() item=author key=myId}
							{assign var="affiliationNumber" value=''}
							{assign var="multiAffiliations" value=($author->getLocalizedAffiliation()|explode:" / ")}
							{foreach from=$multiAffiliations item=item key=key name=name}
								{assign var="position" value=($item|@array_search:$affiliations)}
								{if $position === false }
									{$affiliations[] = $item}
									{$position = $affiliations|@count -1}
									{else}
								{/if}
								{$position = $position + 1}
								{if $affiliationNumber}
									{$affiliationNumber = $affiliationNumber|cat:","}
								{/if}
								{$affiliationNumber = $affiliationNumber|cat:$position}
							{/foreach}
							<span class="author-short">
							{$author->getFullName()|escape}<sup>{$affiliationNumber}</sup></span>{($article->getAuthors()|@count -1 !== $myId)?',':''}
						{/foreach}
					</li>
					
					<li class="article-meta-item authors-short-affiliation">
				<strong>{capture assign=affiliation}{translate key="plugins.themes.mbj.article.affiliations"}{/capture}{translate key="semicolon" label=$affiliation}</strong>
						<ol class="affiliations-list">
							{foreach from=$affiliations item=item}
							<li>
								{$item}
							</li>
						{/foreach}
						</ol>
					</li>

					{/if}

				{* Issue *}
				<li class="article-meta-item issue-series">
					{capture assign=translatedIssueSeries}{translate
					key="plugins.themes.mbj.issue.archive.issue"}{/capture}
					<strong>{translate key="semicolon" label=$translatedIssueSeries}</strong>
					<a class="title" href="{url|escape page=" issue" op="view"
						path=$issue->getBestIssueId($currentJournal)}">
						{$issue->getIssueSeries()|escape}
					</a>
				</li>

				{* Published date *}
				{if $article->getDatePublished()}
				<li class="article-meta-item date-published">
					{capture assign=translatedDatePublished}{translate
					key="plugins.themes.mbj.submission.published"}{/capture}
					<strong>{translate key="semicolon" label=$translatedDatePublished}</strong>
					{$article->getDatePublished()|date_format}
				</li>
				{/if}

				{* DOI (requires plugin) *}
				{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() != 'doi'}
				{continue}
				{/if}
				{if $issue->getPublished()}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{else}
				{assign var=pubId value=$pubIdPlugin->getPubId($article)}{* Preview pubId *}
				{/if}
				{if $pubId}
				{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
				<li class="article-meta-item doi">
					{capture assign=translatedDoi}{translate key="plugins.pubIds.doi.readerDisplayName"}{/capture}
					<strong>{translate key="semicolon" label=$translatedDoi}</strong>
					<a href="{$doiUrl}">
						{$doiUrl|substr:16}
					</a>
				</li>
				{/if}
				{/foreach}
				<li class="article-meta-item pages">
					<strong>{translate key="plugins.themes.mbj.issue.summary.pages"}:</strong>
					{$article->getStartingPage()|escape}–{$article->getEndingPage()|escape}
				</li>
				<li class="article-meta-item article-views">
					<strong>{translate key="plugins.themes.mbj.article.views"}:</strong> {$article->getViews()|escape}
					<strong>{translate key="plugins.themes.mbj.article.downloads"}:</strong> {if $fullTextDownloads} 
					$fullTextDownloads 
					{else}
					0
				{/if}
				</li>
			{* Keywords *}
			
			{if !empty($keywords[$currentLocale])}
			<li class="article-meta-item keywords">
			<strong>{capture assign=keywordsHead}{translate key="article.subject"}{/capture}{translate key="semicolon" label=$keywordsHead}</strong>
					<span class="value">
						{foreach from=$keywords item=keyword}
							{foreach name=keywords from=$keyword item=keywordItem}
								{$keywordItem|escape}{if !$smarty.foreach.keywords.last}, {/if}
							{/foreach}
						{/foreach}
					</span>
				</li>
			{/if}

			{* Article Subject *}
				{if $article->getLocalizedSubject()}
				<div class="panel panel-default subject">
					<div class="panel-heading">
						{translate key="article.subject"}
					</div>
					<div class="panel-body">
						{$article->getLocalizedSubject()|escape}
					</div>
				</div>
				{/if}
			</ul><!-- /list-group -->
			{call_hook name="Templates::Article::Main"}
		</section><!-- .article-main -->

		<section class="article-sidebar article-meta col-lg-3 col-md-5">
			<div class="list-group">
				{* Article Galleys *}
				{if $primaryGalleys || $supplementaryGalleys}
				<div class="download list-group-item">
					{assign var="fullTextDownloads" value=0}
					{if $primaryGalleys}
					{foreach from=$primaryGalleys item=galley}
					{include file="frontend/objects/galley_link.tpl" parent=$article
					purchaseFee=$currentJournal->getSetting('purchaseArticleFee')
					purchaseCurrency=$currentJournal->getSetting('currency')}
					{assign var='fullTextDownloads' value=$galley->getViews()}
					{/foreach}
					{/if}
				</div>
				{/if}
			</div>
			
		</section><!-- /article-meta -->


	</div><!-- /row -->
	<div class="row">
		<section class="col-md-10 col-sm-10 col-xs-12 col-lg-9">
			{* How to cite *}
			{if $citation}
			{include file="frontend/components/howToCite.tpl"}
			{/if}
		</section>
	</div>

	<div class="row">
		<section class="article-more-details col-xs-12">
			<ul class="nav panel nav-tabs ">
				<li role="presentation" class="active"><a href="#summary" aria-controls="summary" role="tab"
						data-toggle="tab">Abstract</a></li>
						{if $article->getAuthors()}<li role="presentation"><a href="#authors" aria-controls="authors" role="tab"
						data-toggle="tab">Authors</a></li>{/if}
						{if $article->getCitations()}<li role="presentation"><a href="#references" aria-controls="references" role="tab"
						data-toggle="tab">References</a></li>{/if}
						{if $supplementaryGalleys}<li role="presentation"><a href="#supplementary" aria-controls="howToCite" role="tab"
						data-toggle="tab">Supplementary</a></li>{/if}
			</ul>

			<div class="tab-content">
				{* Screen-reader heading for easier navigation jumps *}
				<h2 class="sr-only">{translate key="plugins.themes.bootstrap3.article.details"}</h2>

				{* Article abstract *}
				<div class="tab-pane active" role="tabpanel" id="summary">
					{if $article->getLocalizedAbstract()}
					<div class="article-summary">
						<h2>{translate key="article.abstract"}</h2>
						<div class="article-abstract">
							{$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}
						</div>
					</div>
					{/if}
				</div>

				<div class="tab-pane" role="tabpanel" id="authors">
					{if $article->getAuthors()}
					<div class="authors">
						{foreach from=$article->getAuthors() item=author}
						<div class="author">
							<strong>{$author->getFullName()|escape}</strong>
							<div class="author-biography">{$author->getLocalizedBiography()}</div>
							{if $author->getLocalizedAffiliation()}
							<div class="article-author-affilitation">
								{$author->getLocalizedAffiliation()|escape}
							</div>
							{/if}
							<div class="article-links-custom">
								{if $author->getOrcid()}
								<p class="orcid article-orcid-custom ">
									<a href="{$author->getOrcid()|escape}" target="_blank">
										{$author->getOrcid()|escape}
									</a>
								</p>
								{/if}
								{if $author->getUrl()}
								<p class="url article-rinc-custom">
									<a href="{$author->getUrl()|escape}" target="_blank">
										{$author->getUrl()|escape}
									</a>
								</p>
								{/if}
							</div>
						</div>
						{/foreach}
					</div>
					{/if}
				</div>


				{* References *}
				<div class="tab-pane" role="tabpanel" id="references">
					{if $article->getCitations()}
					<div class="article-references">
						<h2>{translate key="submission.citations"}</h2>
						<div class="article-references-content">
							{$article->getCitations()|nl2br}
						</div>
					</div>
					{/if}
				</div>

				{* PubIds (requires plugins) *}
				{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() == 'doi'}
				{continue}
				{/if}
				{if $issue->getPublished()}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{else}
				{assign var=pubId value=$pubIdPlugin->getPubId($article)}{* Preview pubId *}
				{/if}
				{if $pubId}
				<div class="panel panel-default pub_ids">
					<div class="panel-heading">
						{$pubIdPlugin->getPubIdDisplayType()|escape}
					</div>
					<div class="panel-body">
						{if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
						<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}"
							href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">
							{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
						</a>
						{else}
						{$pubId|escape}
						{/if}
					</div>
				</div>
				{/if}
				{/foreach}

				<div class="tab-pane" role="tabpanel" id="supplementary">
				{* Supplementary *}
				{if $supplementaryGalleys}
				<div class="download list-group-item">
					
					{foreach from=$supplementaryGalleys item=galley}
					{include file="frontend/objects/galley_link.tpl" parent=$article isSupplementary="1"}
					{/foreach}
				</div>
				{/if}
				</div>
			
				{* Licensing info Спрятал лицензию V false ниже*}
				{if $copyright || $licenseUrl && false}
				<div class="panel panel-default copyright">
					<div class="panel-body">
						{if $licenseUrl}
						{if $ccLicenseBadge}
						{$ccLicenseBadge}
						{else}
						<a href="{$licenseUrl|escape}" class="copyright">
							{if $copyrightHolder}
							{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder
							copyrightYear=$copyrightYear}
							{else}
							{translate key="submission.license"}
							{/if}
						</a>
						{/if}
						{/if}
						{$copyright}
					</div>
				</div>
				{/if}

				

				{call_hook name="Templates::Article::Details"}
			</div>

		</section><!-- .article-details -->

	</div><!-- .row -->

</article>
