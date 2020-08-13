{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *  Expected to be primary object on the page.
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
		{include file="frontend/components/editLink.tpl" page="workflow" op="index" path=$article->getBestArticleId($currentJournal) anchor="" sectionTitleKey="about.authorGuidelines"}
	</header>

	<div class="row">

		<section class="article-sidebar col-md-4">

			{* Screen-reader heading for easier navigation jumps *}
			<h2 class="sr-only">{translate key="plugins.themes.bootstrap3.article.sidebar"}</h2>

			{* Article/Issue cover image *}
			{if $article->getLocalizedCoverImage() || $issue->getLocalizedCoverImage()}
				<div class="cover-image">
					{if $article->getLocalizedCoverImage()}
						<img class="img-responsive" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
					{else}
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							<img class="img-responsive" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					{/if}
				</div>
			{/if}

			<div class="list-group">


				{* Published date *}
				{if $article->getDatePublished()}
					<div class="list-group-item date-published">
						{capture assign=translatedDatePublished}{translate key="plugins.themes.bootstrapChild.submission.published"}{/capture}
						<strong>{translate key="semicolon" label=$translatedDatePublished}</strong>
						{$article->getDatePublished()|date_format}
					</div>
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
						<div class="list-group-item doi">
							{capture assign=translatedDoi}{translate key="plugins.pubIds.doi.readerDisplayName"}{/capture}
							<strong>{translate key="semicolon" label=$translatedDoi}</strong>
							<a href="{$doiUrl}">
								{$doiUrl|substr:16}
							</a>
						</div>
					{/if}
				{/foreach}
				<div class="list-group-item pages">
					<strong>{translate key="plugins.themes.bootstrapChild.issue.summary.pages"}:</strong>
					{$article->getStartingPage()|escape}–{$article->getEndingPage()|escape}
				</div>

				{* Article Galleys *}
				{if $primaryGalleys || $supplementaryGalleys}
					<div class="download list-group-item">
						{assign var="fullTextDownloads" value=0}
						{if $primaryGalleys}
							{foreach from=$primaryGalleys item=galley}
								{include file="frontend/objects/galley_link.tpl" parent=$article purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
								{assign var='fullTextDownloads' value=$galley->getViews()}
							{/foreach}
						{/if}
						{if $supplementaryGalleys}
							{foreach from=$supplementaryGalleys item=galley}
								{include file="frontend/objects/galley_link.tpl" parent=$article isSupplementary="1"}
							{/foreach}
						{/if}
					</div>
				{/if}
				<div class="list-group-item article-views">
					<strong>{translate key="plugins.themes.bootstrapChild.article.views"}:</strong> {$article->getViews()|escape}
					<strong>{translate key="plugins.themes.bootstrapChild.article.downloads"}:</strong>	{$fullTextDownloads}
				</div>


			</div>

		</section><!-- .article-sidebar -->
	<section class="article-main clearfix">
		<div class="col-md-8">


				{* Screen-reader heading for easier navigation jumps *}
				<h2 class="sr-only">{translate key="plugins.themes.bootstrap3.article.main"}</h2>

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
										<a  href="{$author->getUrl()|escape}" target="_blank">
											{$author->getUrl()|escape}
										</a>
									</p>
								{/if}
								</div>
							</div>
						{/foreach}
					</div>
				{/if}
		</div><!-- .col-md-8 -->


				{* Article abstract *}
				{if $article->getLocalizedAbstract()}
					<div class="article-summary" id="summary">
						<h2>{translate key="article.abstract"}</h2>
						<div class="article-abstract">
							{$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}
						</div>
					</div>
				{/if}

				{call_hook name="Templates::Article::Main"}

	</section><!-- .article-main -->

			<section class="article-more-details">

				{* Screen-reader heading for easier navigation jumps *}
				<h2 class="sr-only">{translate key="plugins.themes.bootstrap3.article.details"}</h2>

				{* How to cite *}
			{if $citation}
				<div class="panel panel-default citation_formats">
					<div class="panel-heading clearfix">
						{* {translate key="submission.howToCite"} *}
						<div class="float-right dropdown citation_format_options">
							{assign var="primaryCite" value=''}
							{foreach from=$citationStyles item=item}
								{if $item.isPrimary}
									{assign var="primaryCite" value=$item.title}
									{break}
								{/if}
							{/foreach}
						<button  id="citation-button" class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">{translate key="plugins.themes.bootstrapChild.submissions.cite"} (<span class="citation-style"> {$primaryCite} </span>)
						  <span class="caret"></span></button>
						  <div id="copy" title="Copy" onclick="false"></div>
						<ul class="dropdown-menu" role="menu">
                    {foreach from=$citationStyles item="citationStyle"}
                      <li>
                        <a onclick="if (this.closest('.dropdown').classList.contains('open')) this.closest('.dropdown').classList.remove('open'); document.getElementById('citation-button').querySelector('.citation-style').innerHTML = this.textContent"
                          aria-controls="citationOutput"
                          href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
                          data-load-citation
                          data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
                        >
                          {$citationStyle.title|escape}
                        </a>
                      </li>
                    {/foreach}
                    <li role="presentation" class="divider"></li>
                    {if count($citationDownloads)}
                    <li class="dropdown-header">{translate key="submission.howToCite.downloadCitation"}</li>
                      {foreach from=$citationDownloads item="citationDownload"}
                        <li>
                          <a class="lst-group-item" href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}"><span class="glyphicon
glyphicon glyphicon-download-alt" aria-hidden="true"></span>
                            {$citationDownload.title|escape}
                          </a>
                        </li>
                      {/foreach}
                  {/if}
                  </ul>
					</div>
					</div>

					{* Output list of all citation formats *}

					<div class="panel-body">
						{* Output the first citation format *}
							<div id="citationOutput" class="citation_output">
								{$citation}
							</div>
					</div>
				</div>
			{/if}

				{* Keywords *}
				{if !empty($keywords[$currentLocale])}
					<div class="panel panel-default keywords">
						<div class="panel-heading">
							{capture assign=translatedKeywords}{translate key="article.subject"}{/capture}
							{translate key="semicolon" label=$translatedKeywords}
						</div>
						<div class="panel-body">
								<span class="value">
									{foreach from=$keywords item=keyword}
										{foreach name=keywords from=$keyword item=keywordItem}
											{$keywordItem|escape}{if !$smarty.foreach.keywords.last}, {/if}
										{/foreach}
									{/foreach}
								</span>
						</div>
					</div>
				{/if}

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
									<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">
										{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
									</a>
								{else}
									{$pubId|escape}
								{/if}
							</div>
						</div>
					{/if}
				{/foreach}

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

				{* Issue article appears in *}
				<div class="panel panel-default issue">
					<div class="panel-heading">
						{translate key="issue.issue"}
					</div>
					<div class="panel-body">
						<a class="title" href="{url|escape page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">
							{$issue->getIssueIdentification()|escape}
						</a>

					</div>
				</div>

				{if $section}
					<div class="panel panel-default section">
						<div class="panel-heading">
							{translate key="section.section"}
						</div>
						<div class="panel-body">
							{$section->getLocalizedTitle()|escape}
						</div>
					</div>
				{/if}

				{* Licensing info  Спрятал лицензию V false ниже*}
				{if $copyright || $licenseUrl && false}
					<div class="panel panel-default copyright">
						<div class="panel-body">
							{if $licenseUrl}
								{if $ccLicenseBadge}
									{$ccLicenseBadge}
								{else}
									<a href="{$licenseUrl|escape}" class="copyright">
										{if $copyrightHolder}
											{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder copyrightYear=$copyrightYear}
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

				{* Author biographies *}
				{assign var="hasBiographies" value=0}
{* 				{foreach from=$article->getAuthors() item=author}
					{if $author->getLocalizedBiography()}
						{assign var="hasBiographies" value=$hasBiographies+1}
					{/if}
				{/foreach}
				{if $hasBiographies}
					<div class="panel panel-default author-bios">
						<div class="panel-heading">
							{if $hasBiographies > 1}
								{translate key="submission.authorBiographies"}
							{else}
								{translate key="submission.authorBiography"}
							{/if}
						</div>
						<div class="panel-body">
							{foreach from=$article->getAuthors() item=author}
								{if $author->getLocalizedBiography()}
									<div class="media biography">
										<div class="media-body">
											<h3 class="media-heading biography-author">
												{if $author->getLocalizedAffiliation()}
													{capture assign="authorName"}{$author->getFullName()|escape}{/capture}
													{capture assign="authorAffiliation"}<span class="affiliation">{$author->getLocalizedAffiliation()|escape}</span>{/capture}
													{translate key="submission.authorWithAffiliation" name=$authorName affiliation=$authorAffiliation}
												{else}
													{$author->getFullName()|escape}
												{/if}
											</h3>
											{$author->getLocalizedBiography()|strip_unsafe_html}
										</div>
									</div>
								{/if}
							{/foreach}
						</div>
					</div>
				{/if} *}

				{call_hook name="Templates::Article::Details"}

				{* References *}
				{if $article->getCitations()}
					<div class="article-references">
						<h2>{translate key="submission.citations"}</h2>
						<div class="article-references-content">
							{$article->getCitations()|nl2br}
						</div>
					</div>
				{/if}

			</section><!-- .article-details -->

	</div><!-- .row -->

</article>
