# YouTube Keyboard Navigation Browser Extension

[![Build Status][travis_badge]][travis_repo]
[![CodeFactor][codefactor_badge]][codefactor_repo]
[![Buy Me A Coffee][buy_me_a_coffee_badge]][buy_me_a_coffee_donation]

[codefactor_badge]: https://www.codefactor.io/repository/github/fanaroengineering/youtube_kbd_nav/badge/master
[codefactor_repo]: https://www.codefactor.io/repository/github/fanaroengineering/youtube_kbd_nav/overview/master
[travis_badge]: https://travis-ci.com/FanaroEngineering/youtube_kbd_nav.svg?branch=master
[travis_repo]: https://travis-ci.com/github/FanaroEngineering/youtube_kbd_nav
[buy_me_a_coffee_badge]: https://img.shields.io/badge/donate-buy%20me%20a%20coffee-orange
[buy_me_a_coffee_donation]: https://www.buymeacoffee.com/psygo

## 1. For the User

An extension to make navigating possible with only the keyboard.

> Much of the inspiration for this extension comes from the [`web-search-navigator`][web_search_navigator] extension. Though not that well-known, the [`web-search-navigator`][web_search_navigator] is probably the most useful extension I have. The [`web-search-navigator`][web_search_navigator] extension does offer some of this extension's features, but not all &mdash; and anything beyond Google is experimental there.

Do you have any complaints? Or suggestions for improvements? Then [create an issue for this project][issue_page]. Don't forget that YouTube, like Twitter, Reddit and others, already offers some shortcuts. Just press <kbd>Shift</kbd> + <kbd>?</kbd> on YouTube to check out all of the native shortcuts.


[issue_page]: https://github.com/FanaroEngineering/youtube_kbd_nav/issues
[web_search_navigator]: https://github.com/infokiller/web-search-navigator

### 1.1. Releases

Currently, this extension is in its *alpha* stage. Basically, only the first sketch is available to a small amount of users. I expect that, in 1-2 weeks, we will be able to enter a *beta*; and, hopefully, in a month, a first public release on the Chrome Firefox and Edge's extension stores.

You can directly download this extension's files from the [Releases][release_link] page.


[release_link]: https://github.com/FanaroEngineering/youtube_kbd_nav/releases

### 1.2. How to install it with a zip file

#### 1.2.1. Chrome

1. Unzip the extension in a local folder.
1. Go to [chrome://extensions/][chrome_extensions]
1. Activate <kbd>Developer mode</kbd> on the upper-right corner.
1. Click on <kbd>Load unpacked</kbd> and choose the folder where you unzipped the extension.


[chrome_extensions]: chrome://extensions/

#### 1.2.2. Firefox

1. Go to [about:debugging][about_debugging]
1. Click on <kbd>This Firefox</kbd>.
1. Click on <kbd>Load Temporary Add-on...</kbd> and load the zip file directly.


[about_debugging]: about:debugging

#### 1.2.3. Microsoft Edge

1. Unzip the extension in a local folder.
1. Go to [edge://extensions][edge_extensions]
1. Activate <kbd>Developer mode</kbd> on the lower-left corner.
1. Click on <kbd>Load unpacked</kbd> and choose the folder where you unzipped the extension.


[edge_extensions]: edge://extensions/

### 1.3. Available Shortcuts

If you're a Mac user, replace <kbd>Ctrl</kbd> by <kbd>&#8984;</kbd> &mdash; i.e. <kbd>command</kbd>.

| Shortcut                           | Action                                            |
|------------------------------------|---------------------------------------------------|
| <kbd>z</kbd>                       | Cycle forwards on the thumbnails                  |
| <kbd>x</kbd>                       | Cycle backwards on the thumbnails                 |
| <kbd>Enter</kbd>                   | Navigate to the selected thumbnail                |
| <kbd>Ctrl</kbd> + <kbd>Enter</kbd> | Open a new tab for the selected thumbnail         |
| <kbd>q</kbd>                       | YouTube Home                                      |
| <kbd>Ctrl</kbd> + <kbd>q</kbd>     | New Tab to YouTube Home                           |
| <kbd>h</kbd>                       | YouTube History                                   |
| <kbd>Ctrl</kbd> + <kbd>h</kbd>     | New Tab to YouTube History                        |
| <kbd>e</kbd>                       | Subscribe to the channel<sup>1</sup>              |
| <kbd>v</kbd>                       | Like the video<sup>1</sup>                        |
| <kbd>n</kbd>                       | Dislike the video<sup>1</sup>                     |
| <kbd>b</kbd>                       | Copies the shortened URL of the video<sup>2</sup> |
| <kbd>y</kbd>                       | Opens the notification pop-up                     |

<sub>`1`: Only works when signed-in and on a video page.</sub> \
<sub>`2`: Only works when on a video page.</sub>

## 2. For the Developer

### 2.1. Future Improvements (Development)

- [ ] Add driver tests to the `Kbd` class.
    - The [webdriver package][webdriver] will probably be necessary.


[webdriver]: https://pub.dev/packages/webdriver

### 2.2. Building with `dart2js`

Originally, I was using the [webdev][webdev_docs] with the discontinued [webext][webext_github], but they both add way too much stuff to something that should be way simpler.

> If you have uploaded a local zip of a build to Firefox, rebuilding will probably give back an error because Firefox will deny overwrites or deletions of the previous build.

Basically, [a JS browser extension consists of very few specific JS files][mdn_ext_docs], so, when using Dart, the only things you will end up needing to do are:

1. Use `dart2js` to convert Dart to JS.
    - For example:
        ```sh
        dart2js --csp -On -o build/content.dart.js web/content.dart
        ```
        - The `-O{0|1|2|3|4}` argument refers to the optimizations `dart2js` is allowed to do. The higher the more aggressive &mdash; which might cause problems. Refer to [`dart2js` docs][dart2js_docs] for more info.
        - The `--csp` option: *disables dynamic generation of code in the generated output. This is necessary to satisfy CSP restrictions*. Check out the [`dart2js` docs][dart2js_docs] for more info.
1. Pack it into a zip file.
    - For example, in Powershell:
        ```ps1
        $compress = @{
            Path = "build/*"
            CompressionLevel = "Fastest"
            DestinationPath = "build/build.zip"
        }
        Compress-Archive @compress
        ```

The script(s) to create the build are all in the [`tool`][tool_folder] folder<sup>*</sup>.

---

<sub>\* : The shell (`build.sh`) version hasn't yet been tested.</sub>


[dart2js_docs]: https://dart.dev/tools/dart2js
[mdn_ext_docs]: https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions
[tool_folder]: https://github.com/FanaroEngineering/youtube_kbd_nav/tree/master/tool
[webdev_docs]: https://dart.dev/tools/webdev
[webext_github]: https://github.com/dart-browser/webext

### 2.3. Visualizing the Extension's Design with UML

The UML diagram at the root of the project has been generated with the the help of the &mdash; great &mdash; [`dcdg`][dcdg_on_pub] Dart package. The standard output is based on the PlantUML standard and, if you use VS Code, you can visualize it by installing [GraphViz][graphviz_download] and the [PlantUML VS Code Extension][plantuml_vscode].

Activate `dcdg` with:

```sh
pub global activate dcdg # only necessary once
```

Then generate the UML diagram with:

```sh
pub global run dcdg -o uml.puml
```


[dcdg_on_pub]: https://pub.dev/packages/dcdg/install
[graphviz_download]: https://graphviz.gitlab.io/download/
[plantuml_vscode]: https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml
