import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class ScrapUtils {
  static Future<dom.Document> scrapePage(url) async {
    final pageUri= Uri.parse(url);
    final page = await http.get(pageUri);

    final scrappedPage = dom.Document.html(page.body);
    return scrappedPage;
  }
}
