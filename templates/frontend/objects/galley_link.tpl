{**
 * templates/frontend/objects/galley_link.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of a galley object as a link to view or download the galley, to be used
 *  in a list of galleys.
 *
 * @uses $galley Galley
 * @uses $parent Issue|Article Object which these galleys are attached to
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $restrictOnlyPdf bool Is access only restricted to PDF galleys?
 * @uses $purchaseArticleEnabled bool Can this article be purchased?
 * @uses $currentJournal Journal The current journal context
 * @uses $journalOverride Journal An optional argument to override the current
 *       journal with a specific context
 *}


 {* DEBUG *}
 {* <button type="button" class="btn btn-info" data-toggle="modal" data-target="#{$galley->getLabel()}">
{$galley->getLabel()}
</button>

<div id="{$galley->getLabel()}" class="modal fade" role="dialog">
<div class="modal-dialog">

<!-- Modal content-->
<div class="modal-content">
 <div class="modal-header">
   <button type="button" class="close" data-dismiss="modal">&times;</button>
   <h4 class="modal-title">$galley</h4>
 </div>
 <div class="modal-body">
   <p>{$galley|@debug_print_var}</p>
 </div>
 <div class="modal-footer">
   <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
 </div>
</div>

</div>
</div> *}
 {* DEBUG *}



 
{* Override the $currentJournal context if desired *}
{if $journalOverride}
	{assign var="currentJournal" value=$journalOverride}
{/if}

{* Determine galley type and URL op *}
{if $galley->isPdfGalley()}
	{assign var="type" value="pdf"}
{else}
	{assign var="type" value="file"}
{/if}

{* Get page and parentId for URL *}
{if $parent instanceOf Issue}
	{assign var="page" value="issue"}
	{assign var="parentId" value=$parent->getBestIssueId()|escape}
{else}
	{assign var="page" value="article"}
	{assign var="parentId" value=$parent->getBestArticleId()|escape}
{/if}

{* Get user access flag *}
{if !$hasAccess}
	{if $restrictOnlyPdf && $type=="pdf"}
		{assign var=restricted value="1"}
	{elseif !$restrictOnlyPdf}
		{assign var=restricted value="1"}
	{/if}
{/if}

{* Galley locale *}
{assign var="lang" value=$galley->getLocale()}

{if !$isSupplementary}
	{* Primary galley *}
<a class="galley-link btn  btn-primary galley-primary {if !empty($lang) && $lang !== $currentLocale}{translate key="plugins.themes.mbj.article.{$lang}"}{/if} {$type}" role="button" href="{url|escape page=$page op="view" path=$parentId|to_array:$galley->getBestGalleyId($currentJournal)}">

	{* Add some screen reader text to indicate if a galley is restricted *}
	{if $restricted}
		{* <span class="glyphicon glyphicon-lock" aria-hidden="true"></span> *}
		<span class="sr-only">
			{if $purchaseArticleEnabled}
				{translate key="reader.subscriptionOrFeeAccess"}
			{else}
				{translate key="reader.subscriptionAccess"}
			{/if}
		</span>
	{/if}
	 {if !$summary}
		{translate key="plugins.themes.mbj.issue.fulltext"}
		{if !empty($lang) && $lang !== $currentLocale}
    	({translate key="plugins.themes.mbj.article.{$lang}"})
  		{/if}
		{else}
		{translate key="plugins.themes.mbj.article.{$lang}"}
	 {/if}

	{if $restricted && $purchaseFee && $purchaseCurrency}
		<span class="purchase-cost">
			{translate key="reader.purchasePrice" price=$purchaseFee currency=$purchaseCurrency}
		</span>
	{/if}
</a>

{* Supplementary galley *}
	{else}

{* 
<a class="galley-link btn  btn-default galley-supplementary {$type}" role="button" href="{url|escape page=$page op="view" path=$parentId|to_array:$galley->getBestGalleyId($currentJournal)}">

	{* Add some screen reader text to indicate if a galley is restricted
	{if $restricted}
		<span class="sr-only">
			{if $purchaseArticleEnabled}
				{translate key="reader.subscriptionOrFeeAccess"}
			{else}
				{translate key="reader.subscriptionAccess"}
			{/if}
		</span>
	{/if}
		{if $galley->getLabel() === 'supplementary'}
			{translate key="plugins.themes.mbj.article.supplementary"}
		{else}
				{$galley->getLabel()}
		{/if}

	{if $restricted && $purchaseFee && $purchaseCurrency}
		<span class="purchase-cost">
			{translate key="reader.purchasePrice" price=$purchaseFee currency=$purchaseCurrency}
		</span>
	{/if}
</a> *}

<a class="galley-link btn  btn-default galley-supplementary {$type}" role="button" href="{url|escape page=$page op="view" path=$parentId|to_array:$galley->getBestGalleyId($currentJournal)}">
{if $type === 'image/jpeg' || 'image/png'}
	<img src="" >	
{/if}

	{* Add some screen reader text to indicate if a galley is restricted *}
	{if $restricted}
		{* <span class="glyphicon glyphicon-lock" aria-hidden="true"></span> *}
		<span class="sr-only">
			{if $purchaseArticleEnabled}
				{translate key="reader.subscriptionOrFeeAccess"}
			{else}
				{translate key="reader.subscriptionAccess"}
			{/if}
		</span>
	{/if}
		{if $galley->getLabel() === 'supplementary'}
			{translate key="plugins.themes.mbj.article.supplementary"}
		{else}
				{$galley->getLabel()}
		{/if}

	{if $restricted && $purchaseFee && $purchaseCurrency}
		<span class="purchase-cost">
			{translate key="reader.purchasePrice" price=$purchaseFee currency=$purchaseCurrency}
		</span>
	{/if}
</a>
		
		
{/if}


