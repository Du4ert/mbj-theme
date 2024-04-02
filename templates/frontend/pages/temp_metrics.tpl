{assign var='metrics' value = array('elibrary','scopus','scimago')}
{foreach $metrics as $metric}
    {assign var="link" value=$activeTheme->getOption("`$metric`MetricLink")|escape}
    {if $link}
        <div class="metric metric-{$metric}">
            <div class="metric-title">
                {$metric|capitalize}:
            </div>
            <div class="metric-values">
                {assign var="i" value=0}
                {for $i=1 to 5}
                    {assign var="optionName" value="`$metric``$i`"}
                    {assign var="optionValue" value=$activeTheme->getOption($optionName)|escape}
                    {if $optionValue == false}
                        {break}
                    {/if}
                    <a href="{$link}">
                        <span class="badge badge-{$metric}">{$optionValue}</span>
                    </a>
                {/for}
            </div>
        </div>
    {/if}
{{/foreach}}