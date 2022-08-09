import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import '../../utils/scrape_page_util.dart';
import 'models/search_manga_module.dart';

class SearchMangasScrapper {
  Future<List<SearchMangaModel>> scrapeSearchMangas({
    String? querySearch,
  }) async {
    final url = "https://muitomanga.com/buscar?q=$querySearch";
    final scrappedPage = await ScrapUtils.scrapePage(url);
    final searchMangaDivs = scrappedPage.querySelectorAll(
      "body > div.content > div > div.content_post > div",
    );
    List<SearchMangaModel> searchMangas  = [];

    searchMangaDivs.forEach((searchManga) {
      searchMangas.add(
        SearchMangaModel(
          image: searchManga
              .querySelector("div > div.capaMangaBusca > a > img")
              ?.attributes["src"],
          title: searchManga
              .querySelector("div > div.boxAnimeSobreLast > h3 > a")
              ?.text,
          url:
              'https://muitomanga.com/${searchManga.querySelector("div > div.boxAnimeSobreLast > h3 > a")?.attributes["href"]}',
        ),
      );
    });

    return searchMangas;
  }
}
