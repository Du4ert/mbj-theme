{**
* templates/frontend/components/galleyModal.tpl
*
* @uses $galley
* @uses $type
*}

{if $type === 'image'}
    <div class="modal fade modal-img" id="{$galley->getId()}galleyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">{$galley->getLocalizedName()|escape}</h4>
                </div>
                <div class="modal-body">
                    <img class="modal-img" src="/{$filePath|escape}">
                </div>
                <div class="modal-footer">
                    <button class="modal-resize close"><span class="glyphicon glyphicon-fullscreen aria-hidden=" true"></span></button>
                    <a class="modal-download" href="{url|escape page=$page op=" view"
                            path=$parentId|to_array:$galley->getBestGalleyId($currentJournal)}">
                        <span class="modal-download-text">{translate
                            key="plugins.themes.mbj.article.galley.download"}</span>
                        <span class="modal-download-button glyphicon glyphicon-download-alt"></span>
                    </a>
                </div>
            </div>
        </div>
    </div>
{elseif $type === 'video'}
    <div class="modal fade modal-video" id="{$galley->getId()}galleyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">{$galley->getLocalizedName()|escape}</h4>
                </div>
                <div class="modal-body">
                     <video class="modal-video" controls poster="/plugins/themes/{$contextSettings.themePluginPath}/img/video-error.jpg">
                        <source src="/{$filePath|escape}#t=0.1" type="{$galley->getFileType()}" />
                    </video>
                </div>
                <div class="modal-footer">
                    <a class="modal-download" href="{url|escape page=$page op=" view"
                        path=$parentId|to_array:$galley->getBestGalleyId($currentJournal)}">
                        <span class="modal-download-text">{translate
                            key="plugins.themes.mbj.article.galley.download"}</span>
                        <span class="modal-download-button glyphicon glyphicon-download-alt"></span>
                    </a>
                </div>
            </div>
        </div>
    </div>
{/if}