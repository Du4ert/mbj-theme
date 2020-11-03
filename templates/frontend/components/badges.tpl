{**
* templates/frontend/components/badges.tpl
*
* @uses $doi | string
* @uses $altmetricsHide | bool
*}

<div class="statistics-badge">
    <span class="__dimensions_badge_embed__" data-doi="{$doi}" data-legend="always" data-style="small_circle"></span>
    <script async src="https://badge.dimensions.ai/badge.js" charset="utf-8"></script>
</div>

<div class="statistics-badge">
    <script type='text/javascript' src='https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js'></script>
    <div data-badge-details="right" data-badge-type="donut" data-doi="{$doi}" data-hide-no-mentions="{$altmetricsHide}" class="altmetric-embed"></div>
</div>
<div class="statistics-badge">
    <script type="text/javascript" src="//cdn.plu.mx/widget-details.js"></script>
    <a href="https://plu.mx/plum/a/?doi={$doi}" class="plumx-details"></a>
</div>   