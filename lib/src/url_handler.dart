class UrlHandler {
  static const String youtubeHome = 'https://www.youtube.com';
  static const String history = 'https://www.youtube.com/feed/history';

  static String tags(String url) {
    if (url.contains('watch')) {
      return 'ytd-compact-video-renderer, '
          'ytd-compact-radio-renderer, '
          'ytd-compact-playlist-renderer';
    } else if (url.contains('results') || url.contains('history')) {
      return 'ytd-video-renderer, '
          'ytd-radio-renderer, '
          'ytd-playlist-renderer, '
          'ytd-channel-renderer';
    } else if (url.contains('youtube')) {
      return 'ytd-rich-item-renderer';
    } else {
      return 'p';
    }
  }

  static String prefixedLink(String url) =>
      url.startsWith('https://') ? url : youtubeHome + url;

  static String shortenLink(String url) {
    final List<String> splitLink = url.split('watch?v=');
    final String videoCode = splitLink[1];

    return 'https://youtu.be/$videoCode';
  }
}
