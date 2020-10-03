import 'player_interop.dart' show exitPictureInPicture, requestPictureInPicture;

class Player {
  void reqPip() => requestPictureInPicture();

  void exitPip() => exitPictureInPicture();
}
