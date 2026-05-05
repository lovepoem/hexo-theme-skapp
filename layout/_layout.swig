<!DOCTYPE html>
<html lang="{{ config.language|default(theme.language) }}">
<head>
    <meta charset="utf-8" />
    {% block title %}
        <title>{% if page.title %}{{ page.title }} - {% endif %}{{ config.seotitle|default(theme.seotitle) }}</title>
    {% endblock %}

    {% include './_partial/common/head.swig' %}

    {% block pageCss %}
    {% endblock %}
</head>
<body ontouchstart>
    <div id="page" class="page">
        {% block header %}
            {% include './_partial/common/header.swig' %}
        {% endblock %}

        {% block main %}
        {% endblock %}

        {% block footer %}
            {% include './_partial/common/footer.swig' %}
        {% endblock %}

        {% block backTop %}
            {% include './_partial/common/back-top.swig' %}
        {% endblock %}
    </div>

    <!-- build:js /js/common.js -->
        <script type="text/javascript" src="{{ url_for('/js/common/utils.js') }}"></script>
        <script type="text/javascript" src="{{ url_for('/js/common/pack.js') }}"></script>
        <script type="text/javascript" src="{{ url_for('/js/common/animation.js') }}"></script>
        <script type="text/javascript" src="{{ url_for('/js/layout/header.js') }}"></script>
        <script type="text/javascript" src="{{ url_for('/js/layout/back-top.js') }}"></script>
        <script type="text/javascript" src="{{ url_for('/js/layout/post.js') }}"></script>
    <!-- endbuild -->

    {% block pagejs %}
    {% endblock %}

    {% block other %}
    {% endblock %}

    {% include './_partial/common/math.swig' %}
</body>
</html>
