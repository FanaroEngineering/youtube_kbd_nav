@JS('document')
library youtube_kbd_nav.interop;

import 'package:js/js.dart' show JS;

@JS('querySelector(\'video\').requestPictureInPicture')
external void requestPictureInPicture();

@JS('exitPictureInPicture')
external void exitPictureInPicture();

@JS('fullscreen')
external bool get isFullScreen;