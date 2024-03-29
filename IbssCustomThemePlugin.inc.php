<?php
import('lib.pkp.classes.plugins.ThemePlugin');
class IbsscustomThemePlugin extends ThemePlugin
{

	/**
	 * Load the custom styles for our theme
	 * @return null
	 */
	public function init()
	{
		// Options
		$this->addOption('yandexMetricOn', 'FieldOptions', [
			'label' => 'Метрики',
			'description' => 'Метрики подключающиеся в шапку и подвал темы',
			'options' => [
				[
					'value' => true,
					'label' => 'Яндекс метрика',
				],
			],
			'default' => false,
		]);

		$this->addOption('yandexMetricId', 'FieldText', [
			'label' => 'Yandex metric id',
			'default' => '',
			'showWhen' => 'yandexMetricOn'
		]);

		$this->addOption('specialVisionOn', 'FieldOptions', [
			'label' => 'Версия для слабовидящих:',
			'options' => [
				[
					'value' => true,
					'label' => 'включить',
				],
			],
			'default' => false,
		]);


		// Load jQuery from a CDN or, if CDNs are disabled, from a local copy.
		$min = Config::getVar('general', 'enable_minified') ? '.min' : '';
		$request = Application::get()->getRequest();
		if (Config::getVar('general', 'enable_cdn')) {
			$jquery = '//ajax.googleapis.com/ajax/libs/jquery/' . CDN_JQUERY_VERSION . '/jquery' . $min . '.js';
			$jqueryUI = '//ajax.googleapis.com/ajax/libs/jqueryui/' . CDN_JQUERY_UI_VERSION . '/jquery-ui' . $min . '.js';
		} else {
			// Use OJS's built-in jQuery files
			$jquery = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jquery/jquery' . $min . '.js';
			$jqueryUI = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jqueryui/jquery-ui' . $min . '.js';
		}
		// Use an empty `baseUrl` argument to prevent the theme from looking for
		// the files within the theme directory
		$this->addScript('jQuery', $jquery, array('baseUrl' => ''));
		$this->addScript('jQueryUI', $jqueryUI, array('baseUrl' => ''));
		$this->addScript('jQueryTagIt', $request->getBaseUrl() . '/lib/pkp/js/lib/jquery/plugins/jquery.tag-it.js', array('baseUrl' => ''));

		// Load Bootstrap
		$this->addScript('libs', 'js/libs.min.js');


		//! commented because of restriction
		// $this->addStyle('openSans', 'https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;1,300;1,400;1,600&display=swap', array('baseUrl' => ''));
		$this->addStyle('main', 'styles/main.css');
		$this->addScript('main', 'js/main.js');

		// Add navigation menu areas for this theme
		$this->addMenuArea(array('primary', 'user', 'sidebar'));


		// issueArchive page now contains all journals issues
		HookRegistry::register('TemplateManager::display', array($this, 'loadMultijournalArchive'));
	}

	public function customCallback($hookName, $args)
	{

		return false;
	}

	/**
	 * Get the display name of this theme
	 * @return string
	 */
	function getDisplayName()
	{
		return 'Ibss custom theme';
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription()
	{
		return 'An example theme for OJS or OMP built with our amazing documentation.';
	}

	public function loadMultijournalArchive($hookName, $args)
	{
		// Retrieve the TemplateManager
		$templateMgr = $args[0];
		$template = $args[1];

		// Don't do anything if we're not loading the right template
		if ($template != 'frontend/pages/issueArchive.tpl') {
			return;
		}

		$journalDao = DAORegistry::getDAO('JournalDAO');
		$journals = $journalDao->getAll(true)->toArray();
		$journalFilesPath = Application::get()->getRequest()->getBaseUrl() . '/' . Config::getVar('files', 'public_files_dir') . '/journals/';

		if (count($journals) < 2) {
			return false;
		}

		$allIssues = [];

		foreach ($journals as $journal) {
			$id = $journal->getId();
			$params = array(
				'contextId' => $id,
				'orderBy' => 'seq',
				'orderDirection' => 'ASC',
				'isPublished' => true,
			);
			$issues = iterator_to_array(Services::get('issue')->getMany($params));

			$allIssues[$id] = $issues;
		}

		$templateMgr->assign([
			'journals' => $journals,
			'allIssues' => $allIssues,
			'journalFilesPath' => $journalFilesPath,
		]);
	}
}
