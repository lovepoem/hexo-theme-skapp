{% if config.baidu_statistic|default(theme.baidu_statistic) || config.google_statistic|default(theme.google_statistic) || config.vercel_speed_insights %}
<script>
(function () {
    var initialized = false;

    function onIdle(callback) {
        if ('requestIdleCallback' in window) {
            window.requestIdleCallback(callback, { timeout: 2500 });
            return;
        }

        window.setTimeout(callback, 1500);
    }

    function appendScript(src, options) {
        if (!src || document.querySelector('script[src="' + src + '"]')) {
            return;
        }

        var script = document.createElement('script');
        script.src = src;
        script.async = true;

        if (options && options.defer) {
            script.defer = true;
        }

        document.head.appendChild(script);
    }

    function boot() {
        if (initialized) {
            return;
        }

        initialized = true;

        {% if config.baidu_statistic|default(theme.baidu_statistic) %}
        window._hmt = window._hmt || [];
        appendScript('https://hm.baidu.com/hm.js?{{ config.baidu_statistic|default(theme.baidu_statistic) }}');
        {% endif %}

        {% if config.google_statistic|default(theme.google_statistic) %}
        window.dataLayer = window.dataLayer || [];
        window.gtag = window.gtag || function(){ window.dataLayer.push(arguments); };
        window.gtag('js', new Date());
        window.gtag('config', '{{ config.google_statistic|default(theme.google_statistic) }}');
        appendScript('https://www.googletagmanager.com/gtag/js?id={{ config.google_statistic|default(theme.google_statistic) }}');
        {% endif %}

        {% if config.vercel_speed_insights %}
        if (!(navigator.connection && navigator.connection.saveData)) {
            var speedInsights = document.createElement('script');
            speedInsights.type = 'module';
            speedInsights.textContent = 'import { injectSpeedInsights } from "https://cdn.jsdelivr.net/npm/@vercel/speed-insights/+esm"; injectSpeedInsights();';
            document.head.appendChild(speedInsights);
        }
        {% endif %}
    }

    function scheduleBoot() {
        onIdle(boot);
    }

    if (document.readyState === 'complete') {
        scheduleBoot();
        return;
    }

    window.addEventListener('load', scheduleBoot, { once: true });
})();
</script>
{% endif %}
