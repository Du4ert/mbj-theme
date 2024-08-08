{**
* templates/frontend/components/authorSummary.tpl
*
* @uses $authors
*}

<li class="article-meta-item authors-short">
    <strong>{capture assign=authors}{translate key="article.authors"}{/capture}{translate
        key="semicolon" label=$authors}</strong>
    {assign var="affiliations" value=[] }
    {foreach from=$publication->getData('authors') item=author key=myId}
        {if !$author->getLocalizedAffiliation()}
            {continue}
        {/if}
        {assign var="multiAffiliations" value=(explode(" / ", $author->getLocalizedAffiliation()|default:''))}
        {foreach from=$multiAffiliations item=item}
            {$item = trim($item)}
            {if !in_array($item, $affiliations)}
                {$affiliations[] = $item}
            {/if}
        {/foreach}
    {/foreach}

            {assign var='authorsCount' value=$publication->getData('authors')|@count}
            {assign var="currentIndex" value=0}
    {foreach from=$publication->getData('authors') item=author key=myId}
        {assign var='currentIndex' value=$currentIndex+1}
        {assign var="affiliationNumber" value=''}
        {assign var="multiAffiliations" value=(explode(" / ", $author->getLocalizedAffiliation()|default:''))}
        {if $affiliations|@count > 1}
        
            
            {foreach from=$multiAffiliations item=item key=key name=name}
                {$item = trim($item)}
                {assign var="position" value=(array_search($item, $affiliations))}
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
            {$authorFullName}<sup>{$affiliationNumber}</sup></span>{($currentIndex < $authorsCount)?', ':''}
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