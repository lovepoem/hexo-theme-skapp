{% if config.baidu_statistic|default(theme.baidu_statistic) || config.google_statistic|default(theme.google_statistic) || config.vercel_speed_insights %}
<script>
(function () {
    var initialized = false;
    var connection = navigator.connection || navigator.mozConnection || navigator.webkitConnection;
    var effectiveType = connection && connection.effectiveType ? String(connection.effectiveType) : '';
    var isConstrainedConnection = !!(connection && (connection.saveData || /(slow-2g|2g|3g)/i.test(effectiveType)));
    var isMobileViewport = window.matchMedia && window.matchMedia('(max-width: 767px)').matches;
    var delayNonCriticalBoot = isConstrainedConnection || isMobileViewport;

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
        if (!delayNonCriticalBoot && !(connection && connection.saveData)) {
            var speedInsights = document.createElement('script');
            speedInsights.type = 'module';
            speedInsights.textContent = 'import { injectSpeedInsights } from "https://cdn.jsdelivr.net/npm/@vercel/speed-insights/+esm"; injectSpeedInsights();';
            document.head.appendChild(speedInsights);
        }
        {% endif %}
    }

    function scheduleBoot() {
        if (delayNonCriticalBoot) {
            var booted = false;

            function bootWhenPossible() {
                if (booted) {
                    return;
                }

                booted = true;
                onIdle(boot);
            }

            window.addEventListener('pointerdown', bootWhenPossible, { once: true, passive: true });
            window.addEventListener('keydown', bootWhenPossible, { once: true });
            window.addEventListener('touchstart', bootWhenPossible, { once: true, passive: true });
            window.setTimeout(bootWhenPossible, 5000);
            return;
        }

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
