import 'package:webext/webext.dart';

Future<void> main() async {
  await BrowserAction.instance.setBadgeText('42');
}
