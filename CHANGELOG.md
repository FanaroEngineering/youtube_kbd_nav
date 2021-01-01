## 1.0.2

- More comprehensive fix to shortcuts still working when typing in an input field.
- Explicitly Excluded YouTube Studio from this extension.
- Now we can also unsubscribe from the channel.
- Playlists are also scrollable through the extension.
- Add videos to the Watch Later Playlist with <kbd>Ctrl</kbd> + <kbd>y</kbd>.
    - Access the Watch Later playlist through <kbd>Ctrl</kbd> + <kbd>.</kbd>.
- Global switch for the whole extension.
- Now the extension logo appears right next to the YouTube logo, signaling that the extension is on.

## 1.0.1

- Added a shortcut for *Picture-in-Picture* (PIP) (fixes #36).
- Separated player-related stuff into another object (`Player`) (fixes #66).
- Added interoperability with JS (`lib/src/utils/player_interop.dart`).
- Now going in or out of fullscreen toggles the active video element.

## 1.0.0

Hopefully this doesn't have any hidden bugs. All of the major core features have now been included. Take a look a previous (pre-)releases for more info on the history of development.

Some added features from the last beta version are:

- Now YouTube's video element has a decoration at the bottom for when it is or isn't the active HTML element.
    - This will help the user know when his keys will act on the document or the video element.
- Focusing on the comment box now uses <kbd>Ctrl</kbd> + <kbd>[</kbd> instead of <kbd>Ctrl</kbd> + <kbd>m</kbd>, which would conflict with muting the video.
    - <kbd>Ctrl</kbd> + <kbd>[</kbd> conflicts with a spherical video shortcut, but that will be solved in the future with #55.
- Added a shortcut for toggling the expansion of the description.
- Better, more performant event handling in page transitions.
- Better code overall.
- Documentation minor improvements.

## 0.1.0-beta

- New shortcuts, such as:
    - <kbd>Ctrl</kbd> + <kbd>m</kbd>: Focusing on the comment box.
    - <kbd>;</kbd>: Go to channel's page.
    - <kbd>\\</kbd>: Go to video's channel's page.
- More performance and less redundancy.
- Better Code and *Object-Oriented Design*.
    - Also features *immutability* &mdash; though not complete so far.
- Better and more simplified TDD.
- More complete `README.md`.

## 0.0.3-alpha

Features added:

- More performance when cycling through the thumbnails.
- History shortcut.
- Navigating to YouTube Home, History or a new thumbnail now can be done either directly or through a new tab &mdash; just modify it with <kbd>Ctrl</kbd>.
- Fixed the bug of having to double-press like/dislike/subscribe initially.
- Fixed the bug of disabling the shortcuts when editing a comment.
- Mac users can use <kbd>⌘</kbd> instead of <kbd>Ctrl</kbd> as a modifier.

## 0.0.2-alpha

First functional sketch.