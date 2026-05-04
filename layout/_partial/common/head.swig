<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
<meta name="format-detection" content="telephone=no">
{% set meta_description = page.description|default(page.subtitle)|default(get_setting('description')) %}
<meta name="author" content="{{ get_setting('author').name }}" />
<meta name="designer" content="minfive" />
<meta name="keywords" content="{{ get_setting('keywords') }}"/>
<meta name="description" content="{{ meta_description }}" />
<meta property="og:type" content="{% if is_post() %}article{% else %}website{% endif %}" />
<meta property="og:title" content="{% if page.title %}{{ page.title }} - {% endif %}{{ config.seotitle|default(theme.seotitle) }}" />
<meta property="og:description" content="{{ meta_description }}" />
<meta property="og:url" content="{{ url }}" />
<meta property="og:image" content="{{ page.cover|default(get_setting('default_cover')) }}" />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="{% if page.title %}{{ page.title }} - {% endif %}{{ config.seotitle|default(theme.seotitle) }}" />
<meta name="twitter:description" content="{{ meta_description }}" />
<meta name="twitter:image" content="{{ page.cover|default(get_setting('default_cover')) }}" />

<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=yes" />
<meta name="mobile-web-app-capable" content="yes" />
<meta name="robots" content="all" />

<link rel="canonical" href="{{ url }}">

<link rel="icon" type="image/png" href="{{ get_setting('favicon_ico') }}" sizes="32x32">

{% if config.google_site_verification %}
  <meta name="google-site-verification" content="{{ config.google_site_verification }}" />
{% endif %}

{% if config.bing_site_verification %}
  <meta name="msvalidate.01" content="{{ config.bing_site_verification }}" />
{% endif %}

{% if config.yandex_site_verification %}
  <meta name="yandex-verification" content="{{ config.yandex_site_verification }}" />
{% endif %}


{% if config.baidu_site_verification %}
  <meta name="baidu-site-verification" content="{{ config.baidu_site_verification }}" />
{% endif %}


{% if config.qihu_site_verification %}
  <meta name="360-site-verification" content="{{ config.qihu_site_verification }}" />
{% endif %}


<!-- Prefetch -->
{% include './prefetch.swig' %}

<!-- CSS -->
{{ css('scss/base/index') }}

<!-- RSS -->
{{ feed_tag('atom.xml') }}

<!-- 统计 -->
{% include './analytics.swig' %}
