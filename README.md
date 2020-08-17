# YouTube Keyboard Navigation Browser Extension

[![Build Status][travis_flag]][travis_page]

A keyboard navigation extension to make navigating YouTube easier and possible without the need of a mouse.


[travis_page]: https://travis-ci.com/github/FanaroEngineering/youtube_kbd_nav
[travis_flag]: https://travis-ci.com/FanaroEngineering/youtube_kbd_nav.svg?branch=master

## 1. Available Shortcuts

| Shortcut         | Action                                    |
|------------------|-------------------------------------------|
| <kbd>z</kbd>     | Cycle forwards on the thumbnails          |
| <kbd>x</kbd>     | Cycle backwards on the thumbnails         |
| <kbd>Enter</kbd> | Open a new tab for the selected thumbnail |

## 2. Future Improvements (Development)

- [ ] Reorient the design towards YouTube's `yt-navigate-start` events.
- [ ] No unit tests for the `KbdHandler`.
- [ ] The UI should probably be the one with the `Cycler` inside, not the `KbdHandler` class.