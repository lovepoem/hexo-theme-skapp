{% if !is_post() && !is_archive() && !is_category() && !is_tag() %}
<link rel="preload" href="{{ get_setting('header_cover_mobile')|default(get_setting('header_cover')) }}" as="image" media="(max-width: 767px)" fetchpriority="high" />
<link rel="preload" href="{{ get_setting('header_cover') }}" as="image" media="(min-width: 768px)" fetchpriority="high" />
{% endif %}

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
    <!-- 首屏文章封面优先加载 -->
    <link rel="preload" href="{{ page.cover|default(get_setting('default_cover')) }}" as="image" fetchpriority="high" />
{% endif %}