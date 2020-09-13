class UrlHandler {
  static const String youtubeHome = 'https://www.youtube.com';
  static const String history = 'https://www.youtube.com/feed/history';

  static const String _watchTags = 'ytd-compact-video-renderer, '
      'ytd-compact-radio-renderer, '
      'ytd-compact-playlist-renderer';
  static const String _historyTags = 'ytd-video-renderer';
  static const String _resultsTags = 'ytd-video-renderer, '
      'ytd-radio-renderer, '
      'ytd-playlist-renderer, '
      'ytd-channel-renderer';
  static const String _homeTags = 'ytd-rich-item-renderer';
  static const String _channelTags = 'ytd-video-renderer, '
      'ytd-grid-video-renderer, '
      'ytd-channel-video-renderer, '
      'ytd-playlist-renderer, '
      'ytd-grid-channel-renderer';

  static String tags(String url) => url.contains('watch')
      ? _watchTags
      : url.contains('history')
          ? _historyTags
          : url.contains('results')
              ? _resultsTags
              : url.contains(RegExp('c|channel|user'))
                  ? _channelTags
                  : url.contains('youtube') ? _homeTags : 'p';

  static String prefixedLink(String url) =>
      url.startsWith('https://') ? url : youtubeHome + url;

  static String shortenLink(String url) {
    final List<String> splitLink = url.split('watch?v=');
    final String videoCode = splitLink[1];

    return 'https://youtu.be/$videoCode';
  }
}
