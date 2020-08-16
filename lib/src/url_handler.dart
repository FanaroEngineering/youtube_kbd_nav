class UrlHandler {
  static String tags(String url) {
    if (url.contains('watch')) {
      return 'ytd-compact-video-renderer, '
          'ytd-compact-radio-renderer, '
          'ytd-compact-playlist-renderer';
    } else if (url.contains('results')) {
      return 'ytd-video-renderer, '
          'ytd-radio-renderer, '
          'ytd-playlist-renderer';
    } else if (url.contains('youtube')) {
      return 'ytd-rich-item-renderer';
    } else {
      return 'p';
    }
  }

  static String prefixedLink(String url) =>
      url.startsWith('https://') ? url : 'https://www.youtube.com' + url;
}
