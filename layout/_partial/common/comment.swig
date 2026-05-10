{% if page.comments && config.gitTalk %}
    <script>
        (function () {
            var container = document.getElementById('comment-container');
            var connection = navigator.connection || navigator.mozConnection || navigator.webkitConnection;
            var effectiveType = connection && connection.effectiveType ? String(connection.effectiveType) : '';
            var isConstrainedConnection = !!(connection && (connection.saveData || /(slow-2g|2g|3g)/i.test(effectiveType)));
            var isMobileViewport = window.matchMedia && window.matchMedia('(max-width: 767px)').matches;
            var shouldUseManualLoad = isConstrainedConnection || isMobileViewport;

            if (!container || container.dataset.loaded === 'true') {
                return;
            }

            var tags = [{% for tag in page.tags %}'{{ tag.name }}', {% endfor %}];

            function loadScript(src) {
                return new Promise(function (resolve, reject) {
                    var script = document.createElement('script');
                    script.src = src;
                    script.onload = resolve;
                    script.onerror = reject;
                    document.body.appendChild(script);
                });
            }

            function loadStyle(href) {
                if (document.querySelector('link[data-gitalk-style="true"]')) {
                    return;
                }

                var link = document.createElement('link');
                link.rel = 'stylesheet';
                link.href = href;
                link.dataset.gitalkStyle = 'true';
                document.head.appendChild(link);
            }

            function bootGitalk() {
                if (container.dataset.loaded === 'true') {
                    return;
                }

                container.dataset.loaded = 'true';
                container.classList.add('comment-container--loading');
                loadStyle('https://unpkg.com/gitalk/dist/gitalk.css');

                Promise.all([
                    loadScript('/js/md5.min.js'),
                    loadScript('https://unpkg.com/gitalk/dist/gitalk.min.js')
                ]).then(function () {
                    var gitalk = new Gitalk({
                        clientID: '{{ config.gitTalk.clientId }}',
                        clientSecret: '{{ config.gitTalk.clientSecret }}',
                        repo: '{{ config.gitTalk.repo }}',
                        owner: '{{ config.gitTalk.owner }}',
                        admin: [{% for item in config.gitTalk.admin %}'{{ item }}', {% endfor %}],
                        labels: tags,
                        id: md5(location.href)
                    });

                    container.classList.remove('comment-container--loading');
                    gitalk.render('comment-container');
                }).catch(function () {
                    container.dataset.loaded = 'false';
                    container.classList.remove('comment-container--loading');

                    if (container.querySelector('[data-comment-load-btn="true"]')) {
                        return;
                    }

                    renderManualLoader('评论加载失败，点击重试');
                });
            }

            function renderManualLoader(title) {
                container.innerHTML = '' +
                    '<div class="comment-container__placeholder">' +
                        '<p class="comment-container__title">' + (title || '评论按需加载，点击后再请求 Gitalk 资源') + '</p>' +
                        '<button class="comment-container__button" type="button" data-comment-load-btn="true">加载评论</button>' +
                    '</div>';

                var button = container.querySelector('[data-comment-load-btn="true"]');

                if (!button) {
                    return;
                }

                button.addEventListener('click', function () {
                    container.innerHTML = '';
                    bootGitalk();
                }, { once: true });
            }

            if (shouldUseManualLoad) {
                renderManualLoader();
                return;
            }

            if (!('IntersectionObserver' in window)) {
                bootGitalk();
                return;
            }

            var observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting) {
                        observer.disconnect();
                        bootGitalk();
                    }
                });
            }, {
                rootMargin: '300px 0px'
            });

            observer.observe(container);
        })();
    </script>
{% endif %}

{% if page.comments && config.disqus_shortname %}
    <script>
        var disqus_shortname = '{{ config.disqus_shortname }}';
        var disqus_config = function () {
            this.page.url = '{{ config.url }}/{{ page.path }}';
            this.page.identifier = '/{{ page.path }}';
            this.page.title = '{{ page.title }}';
        };

        (function() { // DON'T EDIT BELOW THIS LINE
        var d = document, s = d.createElement('script');
        s.src = 'https://' + disqus_shortname + '.disqus.com/embed.js';
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
        })();
    </script>
    <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
{% endif %}
