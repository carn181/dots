config.load_autoconfig()
c.url.searchengines = {"DEFAULT": "https://searx.tuxcloud.net/?q={}", 
                       "wa": "https://wiki.archlinux.org/?search={}", 
                       "aur":"https://aur.archlinux.org/packages/?O=0&K={}", 
                       "4":  "https://4chan.org/{}", 
                      "yt": "https://au.ytprivate.com/search?q={}",
#                       "yt": "https://youtube.com/results?search_query={}",
                       "r":  "https://reddit.com/r/{}",
                       "pb": "https://pirateproxy.surf/search.php?q={}",
                       "gh": "https://github.com/{}",
                       "gl": "https://gitlab.com/{}"}
c.url.start_pages = "https://searx.tuxcloud.net"

c.content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt",
        "https://easylist.to/easylist/easyprivacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"]

c.colors.webpage.prefers_color_scheme_dark = True
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"

c.url.default_page = "https://searx.tuxcloud.net/"
config.source("gruvbox.py")
# Bindings for cycling through CSS stylesheets from Solarized Everything CSS:
# https://github.com/alphapapa/solarized-everything-css
config.bind(',ap', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/apprentice/apprentice-all-sites.css ""')
config.bind(',dr', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/darculized/darculized-all-sites.css ""')
config.bind(',gr', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/gruvbox/gruvbox-all-sites.css ""')
config.bind(',sd', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ""')
config.bind(',sl', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-light/solarized-light-all-sites.css ""')

config.bind(';m', 'set downloads.location.directory /mnt/ext/Media/Pix/memes/ ;; hint links download')
config.bind(',g', 'spawn --userscript greentext')
config.bind(',m', 'hint links spawn mpv {hint-url}')
