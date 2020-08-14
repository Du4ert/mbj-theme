{**
 * templates/frontend/components/rss.tpl
 *
 *}
<div class="rss">
	<a href="{url router=$smarty.const.ROUTE_PAGE page=" gateway" op="plugin" path="WebFeedGatewayPlugin"|to_array:"atom"}">
		<img src="{$baseUrl}/lib/pkp/templates/images/atom.svg" alt="{translate key="plugins.generic.webfeed.atom.altText"}">
	</a>
	<a href="{url router=$smarty.const.ROUTE_PAGE page=" gateway" op="plugin" path="WebFeedGatewayPlugin"|to_array:"rss2"}">
		<img src="{$baseUrl}/lib/pkp/templates/images/rss20_logo.svg" alt="{translate key="plugins.generic.webfeed.rss2.altText"}">
	</a>
	<a href="{url router=$smarty.const.ROUTE_PAGE page=" gateway" op="plugin" path="WebFeedGatewayPlugin"|to_array:"rss"}">
		<img src="{$baseUrl}/lib/pkp/templates/images/rss10_logo.svg" alt="{translate key="plugins.generic.webfeed.rss1.altText"}">
	</a>
</div>
