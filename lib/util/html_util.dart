import 'package:html/parser.dart' show parse;

class HtmlUtil {
  static String? getInnerText(String html) {
    final document = parse(html);
    return document.body?.text;
  }
}
