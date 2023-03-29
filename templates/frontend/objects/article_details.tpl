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

{* Just accepted issue functionality *}
{assign var="just_accepted" value=false}
{if $issue->getData('urlPath') === 'just_accepted'}
    {$just_accepted = true}
{/if}
{*// Just accepted issue functionality *}

<article class="article-details">

{* Notification that this is an old version *}
{if $currentPublication->getId() !== $publication->getId()}
    <div class="alert alert-warning" role="alert">
        {capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
        {translate key="submission.outdatedVersion"
            datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
            urlRecentVersion=$latestVersionUrl|escape
        }
    </div>
{/if}

    <header>
        <h2 class="page-header">
            {$publication->getLocalizedTitle()|escape}
            {if $publication->getLocalizedData('subtitle')}
				<small>
					{$publication->getLocalizedData('subtitle')|escape}
				</small>
			{/if}
        </h2>
        {include file="frontend/components/editLink.tpl" page="workflow" op="index"
		path=$article->getBestArticleId($currentJournal) anchor="" sectionTitleKey="about.authorGuidelines"}
    </header>

    <div class="row article-main">

        <section class="article-sidebar col-md-2 col-sm-2 hidden-sm hidden-xs hidden-md">
{* Article/Issue cover image *}
{if $publication->getLocalizedData('coverImage') || ($issue && $issue->getLocalizedCoverImage())}
    <div class="cover-image">
        {if $publication->getLocalizedData('coverImage')}
            {assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
            <img
                class="img-responsive"
                src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
                alt="{$coverImage.altText|escape|default:''}"
            >
        {else}
            <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
                <img
                    class="img-responsive"
                    src="{$issue->getLocalizedCoverImageUrl()|escape}"
                    alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}"
                >
            </a>
        {/if}
    </div>
{/if}
            {* Versions *}
					{if count($article->getPublishedPublications()) > 1}
						<div class="list-group-item versions">
							<strong>{capture assign=translatedVersions}{translate key="submission.versions"}{/capture}
							{translate key="semicolon" label=$translatedVersions}</strong>
							{foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}
								{capture assign="name"}{translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}{/capture}
								<div>
									{if $iPublication->getId() === $publication->getId()}
										{$name}
									{elseif $iPublication->getId() === $currentPublication->getId()}
										<a href="{url page="article" op="view" path=$article->getBestId()}">{$name}</a>
									{else}
										<a href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">{$name}</a>
									{/if}
								</div>
							{/foreach}
						</div>
					{/if}
        </section>

        <section class="col-md-7 col-lg-7 col-md-8">
            {* Screen-reader heading for easier navigation jumps *}
            <h2 class="sr-only">{translate key="plugins.themes.bootstrap3.article.main"}</h2>

            <ul class="article-meta-list">
                {* Authors *}
                {if $publication->getData('authors') && !$section->getData('hideAuthor')}
                    {include file="frontend/objects/authorSummary.tpl"}
                {/if}

                {* Issue *}
                {if !$just_accepted}
                
                <li class="article-meta-item issue-series">
                    {capture assign=translatedIssueSeries}{translate
					key="plugins.themes.ibsscustom.issue.archive.issue"}{/capture}
                    <strong>{translate key="semicolon" label=$translatedIssueSeries}</strong>
                    <a class="title" href="{url|escape page=" issue" op="view"
						path=$issue->getBestIssueId($currentJournal)|escape}">
                        {$issue->getIssueSeries()|escape}
                    </a>
                </li>
                  {/if}

                {* Section *}
                {if $section && !$just_accepted}
                    <li class="article-meta-item section">
                        <strong>{capture assign=sectionHead}{translate key="section.section"}{/capture}{translate
        					key="semicolon" label=$sectionHead}</strong>
                        <span class="value">{$section->getLocalizedTitle()|escape}</span>
                    </li>
                {/if}

                {* Pages *}
                {if !$just_accepted}
                <li class="article-meta-item pages">
                    <strong>{translate key="plugins.themes.ibsscustom.issue.summary.pages"}:</strong>
                    {$article->getStartingPage()|escape}–{$article->getEndingPage()|escape}
                </li>
                {/if}

                {* Keywords *}
                {if !empty($keywords[$currentLocale])}
                    <li class="article-meta-item keywords">
                        <strong>{capture assign=keywordsHead}{translate key="article.subject"}{/capture}{translate
        						key="semicolon" label=$keywordsHead}</strong>
                        <span class="value">
                            {foreach name=arr from=$keywords[$currentLocale] item=keyword}
                                {* {foreach name=keyword from=$keyword item=keywordItem} *}
                                    {$keyword|escape}{if !$smarty.foreach.arr.last}, {/if}
                                {* {/foreach} *}
                            {/foreach}
                        </span>
                    </li>
                {/if}



                {* DOI (requires plugin) *}
                {foreach from=$pubIdPlugins item=pubIdPlugin}
                    {if $pubIdPlugin->getPubIdType() === 'doi'}
                        {* {continue} *}
                    
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
                    {elseif $pubIdPlugin->getPubIdType() === 'edn'}
                        {* EDN (requires plugin) *}
                        {if $issue->getPublished()}
                            {assign var=edn value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
                        {else}
                            {assign var=edn value=$pubIdPlugin->getPubId($article)}{* Preview pubId *}
                        {/if}
                        {if $edn}
                            {assign var="ednUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $edn|lower)|escape}
                            <li class="article-meta-item edn">
                                {capture assign=translatedEdn}{translate key="plugins.pubIds.edn.readerDisplayName"}{/capture}
                                <strong>{translate key="semicolon" label=$translatedEdn}</strong>
                                <a href="{$ednUrl}" target="_blank">
                                    {$edn|upper}
                                </a>
                            </li>
                        {/if}

                    {* UDC (requires plugin) *}
                    {elseif $pubIdPlugin->getPubIdType() === 'udc'}
                        {if $issue->getPublished()}
                            {assign var=udc value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
                        {else}
                            {assign var=udc value=$pubIdPlugin->getPubId($article)}{* Preview pubId *}
                        {/if}
                        {if $udc}
                            {assign var="udcUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $udc|lower)|escape}
                            <li class="article-meta-item udc">
                                {capture assign=translatedUdc}{translate key="plugins.pubIds.udc.readerDisplayName"}{/capture}
                                <strong>{translate key="semicolon" label=$translatedUdc}</strong>
                                    {$udc|upper}
                            </li>
                        {/if}
                    {/if}
                {/foreach}



                {* Published date *}
                {if $publication->getData('datePublished') && !$just_accepted}
                    <li class="article-meta-item date-published">
                        {capture assign=translatedDatePublished}{translate
        					key="plugins.themes.ibsscustom.submission.published"}{/capture}
                        <strong>{translate key="semicolon" label=$translatedDatePublished}</strong>
                        {$publication->getData('datePublished')|date_format}
                        {* If this is an updated version *}
                    </li>
                    {if $firstPublication->getID() !== $publication->getId()}
						<li class="article-meta-item date-updated">
							{capture assign=translatedUpdated}{translate key="common.updated"}{/capture}
							<strong>{translate key="semicolon" label=$translatedUpdated}</strong>
							{$publication->getData('datePublished')|date_format:$dateFormatShort}
						</li>
					{/if}
                {/if}

                {* Views *}
                {if !$just_accepted}
                
                <li class="article-meta-item article-views">
                    {if $primaryGalleys}
                        {assign var="fullTextDownloads" value=0}
                        {foreach from=$primaryGalleys item=galley}
                            {$fullTextDownloads = $fullTextDownloads + $galley->getViews()}
                            {* {assign var='fullTextDownloads' value=$galley->getViews()} *}
                        {/foreach}
                    {/if}
                    <strong>{translate key="plugins.themes.ibsscustom.article.views"}:</strong> {$article->getViews()|escape}
                    <strong>{translate key="plugins.themes.ibsscustom.article.downloads"}:</strong> {if $fullTextDownloads}
                        {$fullTextDownloads}
                    {else}
                        0
                    {/if}
                </li>
                {/if}

            </ul><!-- /list-group -->
        </section><!-- .article-main -->

        <section class="article-sidebar row col-lg-3 col-md-5">
            {* Article Galleys *}
            {if $primaryGalleys}
                <div class="article-sidebar-item galley-primary-list">
                    <div class="galley-primary-item">
                        {foreach from=$primaryGalleys item=galley}
                            {include file="frontend/objects/galley_link.tpl" parent=$article
                    					purchaseFee=$currentJournal->getSetting('purchaseArticleFee')
                    					purchaseCurrency=$currentJournal->getSetting('currency')}
                        {/foreach}
                    </div>
                </div>
            {/if}

            {if !$just_accepted}
            
            {* Google scholar *}
            {assign var="scholarQuery" value=''}
            {if $pubId}
                {$scholarQuery = $pubId}
            {else}
                {*?{$scholarQuery = $article->getTitle($article->getLocale())}   {*?   Article locale for google scholar search   *}
                {$scholarQuery = $article->getTitle($primaryLocale)}   {*?   Primary locale for google scholar search   *}
            {/if}
            <div class="article-sidebar-item googleScholar">
                <a class="google-scholar-link btn"
                    href='https://scholar.google.com/scholar?q="{$scholarQuery|urlencode}"' target="_blank"
                    rel="noreferrer">
                    <img class="google-scholar-img"
                        src="/plugins/themes/{$currentContext->getData('themePluginPath')}/img/scholar.png"
                        alt="Google Scholar" />
                    Google Scholar
                </a>
            </div>

            {* Crossmark *}
            {if $pubId}
                <div class="article-sidebar-item crossmark">
                    <script src="https://crossmark-cdn.crossref.org/widget/v2.0/widget.js"></script>
                    <a data-target="crossmark" class="btn"><img
                            src="https://crossmark-cdn.crossref.org/widget/v2.0/logos/CROSSMARK_Color_horizontal.svg"
                            width="150" /></a>
                </div>
            {/if}
            <!-- /crossmark -->

            <div class="article-sidebar-item ya-share">
                <script src="https://yastatic.net/share2/share.js"></script>
                <div class="ya-share2" data-curtain data-size="s" data-lang="en" data-shape="normal"
                    data-image="httpsgulp:{$issue->getLocalizedCoverImageUrl()|escape}"
                    data-services="vkontakte,twitter,facebook,odnoklassniki,telegram,viber,whatsapp"></div>
            </div>

            {/if}
        </section><!-- /article-meta -->

    </div><!-- /row -->

    {if !$just_accepted}
    <div class="row">
        <section class="col-md-10 col-sm-10 col-xs-12 col-lg-9">
            {* How to cite *}
            {if $citation && !$section->getData('hideAuthor')}
                {include file="frontend/components/howToCite.tpl"}
            {/if}
        </section>
    </div>
    {/if}

    <div class="row">
        <div class="col-xs-12">
            <section class="article-more panel panel-default">
                <ul class="nav panel-heading nav-tabs article-more-nav">
                    <li role="presentation" class="active"><a href="#summary" aria-controls="summary" role="tab"
                            data-toggle="tab">{translate key="article.abstract"}</a></li>
                    {if $publication->getData('authors') && !$section->getData('hideAuthor')}<li role="presentation"><a href="#authors" aria-controls="authors"
                            role="tab" data-toggle="tab">{translate key="article.authors"}</a></li>{/if}
                            {if $parsedCitations || $publication->getData('citationsRaw')}<li role="presentation"><a href="#references"
                                aria-controls="references" role="tab" data-toggle="tab">{translate
    							key="submission.citations"}</a></li>{/if}
                    {if $supplementaryGalleys}<li role="presentation"><a href="#supplementary"
                                aria-controls="supplementary" role="tab" data-toggle="tab">{translate
    							key="plugins.themes.ibsscustom.article.supplementaries"}</a></li>{/if}
                    <li role="presentation"><a href="#statistics" aria-controls="statistics" role="tab"
                            data-toggle="tab">{translate key="plugins.themes.ibsscustom.article.statistics"}</a></li>
                </ul>

                <div class="tab-content article-more-content panel-body">
                    {* Screen-reader heading for easier navigation jumps *}
                    <h2 class="sr-only article-more-title">{translate key="plugins.themes.bootstrap3.article.details"}
                    </h2>

                    {* Article abstract *}
                    {if $publication->getLocalizedData('abstract')}
                        <div class="tab-pane active" role="tabpanel" id="summary">
                            <h2 class="article-more-title">{translate key="article.abstract"}</h2>
                            <div class="article-summary">
                                <div class="article-abstract">
                                    {$publication->getLocalizedData('abstract')|strip_unsafe_html|nl2br}
                                </div>
                                {* Keywords *}
                                {if !empty($keywords[$currentLocale])}
                                    <div class="article-keywords">
                                        <strong>{capture assign=keywordsHead}{translate
                    									key="article.subject"}{/capture}{translate
                    									key="semicolon" label=$keywordsHead}</strong>
                                        <span class="value">
                                            {foreach name=arr from=$keywords[$currentLocale] item=keyword}
                                                {* {foreach name=keyword from=$keyword item=keywordItem} *}
                                                    {$keyword|escape}{if !$smarty.foreach.arr.last}, {/if}
                                                {* {/foreach} *}
                                            {/foreach}
                                        </span>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    {/if}

                    {* Authors *}
                    {if $publication->getData('authors') && !$section->getData('hideAuthor')} 
                        <div class="tab-pane" role="tabpanel" id="authors">

                            <h2 class="article-more-title">{translate key="article.authors"}</h2>
                            <div class="authors">
                                {foreach from=$publication->getData('authors') item=author}
                                    {include file="frontend/objects/authorDetails.tpl" author=$author}
                                {/foreach}
                            </div>
                        </div>
                    {/if}


                    {* References *}
                    {if $parsedCitations || $publication->getData('citationsRaw')}
                        <div class="tab-pane" role="tabpanel" id="references">
                            <h2 class="article-more-title">{translate key="submission.citations"}</h2>
                            <div class="article-references">
                                <div class="article-references-content">
                                {if $parsedCitations}
                                    {foreach from=$parsedCitations item="parsedCitation"}
                                        <p>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</p>
                                    {/foreach}
                                {else}
                                    {$publication->getData('citationsRaw')|nl2br}
                                {/if}
                                </div>
                            </div>
                        </div>
                    {/if}

                    {* Supplementary *}
                    {if $supplementaryGalleys}
                        <div class="tab-pane" role="tabpanel" id="supplementary">
                            <h2 class="article-more-title">{translate key="plugins.themes.ibsscustom.article.supplementaries"}</h2>
                            <div class="download">
                                {foreach from=$supplementaryGalleys item=galley}
                                    <div class="supplementary">
                                        {include file="frontend/objects/galley_link.tpl" parent=$article isSupplementary="1"}
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}

                    {* Statistics *}
                
                    <div class="tab-pane" role="tabpanel" id="statistics">
                        <h2 class="article-more-title">{translate key="plugins.themes.ibsscustom.article.statistics"}</h2>
                        <div class="statistics">
                            {if $pubId}
                                {include file="frontend/components/badges.tpl" doi=$pubId altmetricsHide="true"}
                            {/if}
                            <div class="statistics-more">
                                {* Graph *}
                                {call_hook name="Templates::Article::Details"}
                                {call_hook name="Templates::Article::Main"}
                            </div>
                        </div>
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

                    {* {call_hook name="Templates::Article::Details"} *}
                </div>

            </section><!-- .article-details -->
        </div>

    </div><!-- .row -->
    {* {call_hook name="Themes::mbj::custom"} *}
    {* {call_hook name="Templates::Article::Main"}
	{call_hook name="Templates::Article::Recommended"} *}

</article>