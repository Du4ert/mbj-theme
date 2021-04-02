{**
* templates/frontend/components/authorSummary.tpl
*
* @uses $authors
*}
<li class="article-meta-item authors-short">
    <strong>{capture assign=authors}{translate key="article.authors"}{/capture}{translate
        key="semicolon" label=$authors}</strong>
    {assign var="affiliations" value=[] }
    {foreach from=$article->getAuthors() item=author key=myId}
        {assign var="multiAffiliations" value=($author->getLocalizedAffiliation()|explode:" / ")}
        {foreach from=$multiAffiliations item=item}
            {if !$item|@in_array:$affiliations}
                {$affiliations[] = $item}
            {/if}
        {/foreach}
    {/foreach}

    {foreach from=$article->getAuthors() item=author key=myId}
        {assign var="affiliationNumber" value=''}
        {assign var="multiAffiliations" value=($author->getLocalizedAffiliation()|explode:" / ")}
        {if $affiliations|@count > 1}
        
            {foreach from=$multiAffiliations item=item key=key name=name}
                {assign var="position" value=($item|@array_search:$affiliations)}
                {if $position === false }
                    {* {$affiliations[] = $item} *}
                    {$position = $affiliations|@count -1}
                {else}
                {/if}
                {$position = $position + 1}
                {if $affiliationNumber}
                    {$affiliationNumber = $affiliationNumber|cat:","}
                {/if}
                {$affiliationNumber = $affiliationNumber|cat:$position}
            {/foreach}
        {/if}
        <span class="author-short">
            {assign var="authorFullName" value=($author->getFullName()|replace:' ':'&nbsp;')}
            {$authorFullName}<sup>{$affiliationNumber}</sup></span>{($article->getAuthors()|@count -1 !== $myId)?',':''}
    {/foreach}
</li>

{if $affiliations[0]}
    <li class="article-meta-item authors-short-affiliation">
        <strong>{capture assign=affiliation}{translate key="plugins.themes.ibsscustom.article.affiliations"}{/capture}{translate key="semicolon"
            label=$affiliation}</strong>
        <ol class="affiliations-list">
            {foreach from=$affiliations item=item}
                <li>
                    {$item}
                </li>
            {/foreach}
        </ol>
    </li>
{/if}