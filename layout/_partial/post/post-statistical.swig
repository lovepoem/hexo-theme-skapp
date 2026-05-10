<!-- 不蒜子统计 - 延迟加载优化 -->
<script>
(function () {
    var loaded = false;
    var connection = navigator.connection || navigator.mozConnection || navigator.webkitConnection;
    var effectiveType = connection && connection.effectiveType ? String(connection.effectiveType) : '';
    var isConstrainedConnection = !!(connection && (connection.saveData || /(slow-2g|2g|3g)/i.test(effectiveType)));
    var isMobileViewport = window.matchMedia && window.matchMedia('(max-width: 767px)').matches;
    var delayLoad = isConstrainedConnection || isMobileViewport;
    var targets = [
        document.getElementById('busuanzi_container_page_pv'),
        document.getElementById('busuanzi_container_site_pv')
    ].filter(Boolean);

    function loadBusuanzi() {
        if (loaded) {
            return;
        }

        loaded = true;

        var script = document.createElement('script');
        script.src = '//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js';
        script.async = true;
        document.head.appendChild(script);
    }

    function scheduleLoad() {
        if (!targets.length) {
            return;
        }

        if (!('IntersectionObserver' in window)) {
            window.setTimeout(loadBusuanzi, delayLoad ? 4500 : 1500);
            return;
        }

        var observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (!entry.isIntersecting) {
                    return;
                }

                observer.disconnect();

                if (delayLoad) {
                    window.setTimeout(loadBusuanzi, 2500);
                    return;
                }

                window.setTimeout(loadBusuanzi, 800);
            });
        }, {
            rootMargin: '160px 0px'
        });

        targets.forEach(function (target) {
            observer.observe(target);
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', scheduleLoad, { once: true });
        return;
    }

    scheduleLoad();
})();
</script>