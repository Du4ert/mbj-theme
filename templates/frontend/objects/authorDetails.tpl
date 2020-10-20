{**
* templates/frontend/components/authorDetails.tpl
*
* @uses $author
*}

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