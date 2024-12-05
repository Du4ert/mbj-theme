{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showGalleyLinks bool Show galley links to users without access?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}
{assign var=articlePath value=$article->getBestArticleId($currentJournal)}
{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
    {assign var="showAuthor" value=true}
{/if}

<div class="article-summary media">
    {if $article->getLocalizedData('coverImage')}
        <div class="cover media-left">
    {* <a href="{url page="article" op="view" path=$articlePath}" class="file"> *}
    <a href="{if $journal}{url journal=$journal->getPath() page=$articlePath op="view" path=$articlePath}{else}{url page="article" op="view" path=$articlePath}{/if}" class="file">
                <img class="media-object" src="{$article->getLocalizedCoverImageUrl()|escape}">
            </a>
        </div>
    {/if}

    <div class="row">
        <div class="col-md-10">


            <h3 class="media-heading">
                {* <a href="{url page="article" op="view" path=$articlePath}"> *}
            <a href="{if $journal}{url journal=$journal->getPath() page="article" op="view" path=$articlePath}{else}{url page="article" op="view" path=$articlePath}{/if}">
                    {$article->getLocalizedTitle()|strip_unsafe_html}
                    {if $article->getLocalizedSubtitle()}
                        <p>
                            <small>{$article->getLocalizedSubtitle()|escape}</small>
                        </p>
                    {/if}
                </a>
            </h3>
            {if $showAuthor}
                <div class="meta">
                        <div class="authors">
                            {$article->getCurrentPublication()->getAuthorString($authorUserGroups)|escape}
                        </div>
                </div>
            {/if}

            {if $journal}
                <h5 class="meta">
                    {$journal->getLocalizedName()|escape}
                </h5>
            {/if}

            {* Page numbers for this article *}
            {if $article->getPages()}
                <p class="pages">
                    {translate key="plugins.themes.ibsscustom.issue.summary.pages"}:
                    {$article->getPages()|replace: '-' : '–'|escape}
                </p>
            {/if}

            {if $issue}
                <a href="{if $journal}{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId($journal)|escape}{else}{url|escape page=" issue" op="view"
                path=$issue->getBestIssueId($journal)|escape}{/if}" class="title">
                    {$issue->getIssueSeries()|escape}
                </a>
            {/if}

        </div>

        <div class="col-md-2">

            {if $showAuthor || $article->getPages()}

            {/if}
            {if !$hideGalleys && $article->getGalleys()}
                <div class="btn-group" role="group">
                    {foreach from=$article->getGalleys() item=galley}
                        {assign var="isSupplementary" value=false}
                            {if $galley->getLabel() !== "fulltext"}
                                {assign var="isSupplementary" value=true}
                            {/if}
                       
                        {assign var="hasArticleAccess" value=$hasAccess}
                        {if ($article->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN)}
                            {assign var="hasArticleAccess" value=1}
                        {/if}
                        {if !$isSupplementary}
                            {include file="frontend/objects/galley_link.tpl" summary=true parent=$article journalOverride=$journal hasAccess=$hasArticleAccess isSupplementary=$isSupplementary}
                        {/if}
                    {/foreach}
                </div>
            {/if}

        </div>
    </div>




    {call_hook name="Templates::Issue::Issue::Article"}
</div><!-- .article-summary -->