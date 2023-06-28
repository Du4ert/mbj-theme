{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}

	</main>

	{* Sidebars *}
	{if empty($isFullWidth)}
	{include file="frontend/components/sidebar.tpl"}
	{/if}

	
	</div><!-- pkp_structure_content -->

	<footer class="footer" role="contentinfo">

		<div class="container">

			<div class="row">
				{if $pageFooter}
				<div class="col-md-12 text-center">
					{$pageFooter}
					{if $activeTheme->getOption('yandexMetricOn') && $activeTheme->getOption('yandexMetricId')}
						{assign var="yandexMetricId" value=$activeTheme->getOption('yandexMetricId')}

						<noscript><div><img src="https://mc.yandex.ru/watch/{$yandexMetricId}" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
					 <!-- Yandex.Metrika informer -->
					 <a href="https://metrika.yandex.ru/stat/?id={$yandexMetricId}&amp;from=informer"
					 target="_blank" rel="nofollow"><img src="https://informer.yandex.ru/informer/{$yandexMetricId}/3_1_EEEEEEFF_EEEEEEFF_0_pageviews"
					 style="width:88px; height:31px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры, визиты и уникальные посетители)" class="ym-advanced-informer" data-cid="{$yandexMetricId}" data-lang="ru" /></a>
					 <!-- /Yandex.Metrika informer -->
					{/if}
				  {include file="frontend/components/rss.tpl"}
				 
				</div>
				{/if}

			</div> <!-- .row -->
		</div><!-- .container -->
	</footer>
</div><!-- pkp_structure_page -->

{load_script context="frontend" scripts=$scripts}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
