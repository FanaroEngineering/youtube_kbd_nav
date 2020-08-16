class UrlHandler {
  static String tags(String url) {
    if (url.contains('watch')) {
      return 'ytd-compact-video-renderer, '
          'ytd-compact-radio-renderer, '
          'ytd-compact-playlist-renderer';
    } else if (url.contains('youtube')) {
      return 'ytd-rich-item-renderer';
    } else {
      return 'p';
    }
  }
}
