{**
 * templates/frontend/components/sidebar.tpl
 *}

{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
{if $sidebarCode}
    <aside id="sidebar" class="clearfix pkp_structure_sidebar left col-xs-12 col-sm-3 col-md-3" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
        <button id="sidebar-trigger" class="btn btn-primary sidebar-trigger"><span class="sidebar-trigger-icon glyphicon glyphicon-chevron-left"></span></button>
        <div class="sidebar-content">
            {load_menu name="sidebar" id="sidebar-nav" ulClass="sidebar-nav-list" liClass="sidebar-nav-item block_custom"}
            {$sidebarCode}
        </div>
    </aside><!-- pkp_sidebar.left -->
{/if}
