@JS('document')
library youtube_kbd_nav.interop;

import 'package:js/js.dart';

@JS('querySelector(\'video\').requestPictureInPicture')
external void requestPictureInPicture();

@JS('exitPictureInPicture')
external void exitPictureInPicture();