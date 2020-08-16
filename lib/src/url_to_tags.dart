class UrlToTags {
  final String _url;

  UrlToTags(String url) : _url = url ?? '';

  String get tags {
    if (_url.contains('watch')) {
      return 'ytd-compact-video-renderer, '
          'ytd-compact-radio-renderer, '
          'ytd-compact-playlist-renderer';
    } else if (_url.contains('youtube')) {
      return 'ytd-rich-item-renderer';
    } else {
      return 'p';
    }
  }
}
