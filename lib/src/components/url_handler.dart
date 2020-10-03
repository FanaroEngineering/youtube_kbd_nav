class UrlHandler {
  static const String youtubeHome = 'https://www.youtube.com',
      history = 'https://www.youtube.com/feed/history',
      _watchTags = 'ytd-compact-video-renderer, '
          'ytd-compact-radio-renderer, '
          'ytd-compact-playlist-renderer, '
          'ytd-compact-movie-renderer',
      _historyTags = 'ytd-video-renderer',
      _resultsTags = 'ytd-video-renderer, '
          'ytd-radio-renderer, '
          'ytd-playlist-renderer, '
          'ytd-channel-renderer',
      _homeTags = 'ytd-rich-item-renderer',
      _channelTags = 'ytd-video-renderer, '
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
              : url.contains(RegExp('/c|/channel|/user'))
                  ? _channelTags
                  : _homeTags;

  static String prefixedLink(String url) =>
      url.startsWith('https://') ? url : youtubeHome + url;

  static String shortenLink(String url) {
    final List<String> splitLink = url.split('watch?v=');
    final String videoCode = splitLink[1];

    return 'https://youtu.be/$videoCode';
  }
}
