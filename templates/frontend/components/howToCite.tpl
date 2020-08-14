{**
* templates/frontend/components/rss.tpl
*
* @uses $citationStyles plugin how to cite 
* @uses $citationDownloads plugin how to cite option
* @uses $citation
*}
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
						<button  id="citation-button" class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">{translate key="plugins.themes.mbj.submissions.cite"} (<span class="citation-style"> {$primaryCite} </span>)
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