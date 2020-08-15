class UrlToTags {
  final String _url;

  UrlToTags(String url): _url = url;

  String get tags {
    if (_url.contains('watch')) {
      return 'ytd-compact-video-renderer, ytd-compact-radio-renderer';
    } else {
      return 'ytd-rich-item-renderer';
    }
  }
}