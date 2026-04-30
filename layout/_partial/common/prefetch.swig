{% if is_home() %}
    {% set arr = num_toArray(page.total) %}
    {% for p in arr %}
        {% if p > 1 %}
        <link rel="prefetch" href="{{ url_for(config.pagination_dir + '/' + p + '/') }}" />
        {% endif %}
    {% endfor %}
{% endif %}

{% if is_category() %}
    {% set arr = num_toArray(page.total) %}
    {% for p in arr %}
        {% if p > 1 %}
        <link rel="prefetch" href="{{ url_for(config.category_dir + '/' + page.category + '/' + p + '/') }}" />
        {% endif %}
    {% endfor %}
{% endif %}

{% if is_tag() %}
    {% set arr = num_toArray(page.total) %}
    {% for p in arr %}
        {% if p > 1 %}
        <link rel="prefetch" href="{{ url_for(config.tag_dir + '/' + page.tag + '/' + p + '/') }}" />
        {% endif %}
    {% endfor %}
{% endif %}

<!-- 文章页面性能优化 -->
{% if is_post() %}
    <!-- 预加载关键CSS -->
    <link rel="preload" href="{{ url_for('scss/base/index.css') }}" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <link rel="preload" href="{{ url_for('scss/views/page/post.css') }}" as="style" onload="this.onload=null;this.rel='stylesheet'">
    
    <!-- 预加载关键字体 -->
    {# icon font preload removed: font is not used in initial render on many pages and triggers preload warning #}

    <!-- DNS预解析 -->
    <link rel="dns-prefetch" href="//busuanzi.ibruce.info">
    <link rel="dns-prefetch" href="//hm.baidu.com">
    
    <!-- 预连接重要的第三方域名 -->
    <link rel="preconnect" href="//busuanzi.ibruce.info" crossorigin>
    <link rel="preconnect" href="//hm.baidu.com" crossorigin>
{% endif %}