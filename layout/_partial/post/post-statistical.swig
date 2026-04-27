<!-- 不蒜子统计 - 延迟加载优化 -->
<script>
// 延迟加载不蒜子统计脚本
function loadBusuanzi() {
    var script = document.createElement('script');
    script.src = '//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js';
    script.async = true;
    document.head.appendChild(script);
}

// 页面加载完成后延迟加载
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(loadBusuanzi, 1000);
    });
} else {
    setTimeout(loadBusuanzi, 1000);
}
</script>