import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../../utils/scrape_page_util.dart';
import 'models/single_manga_model.dart';

class MangasScrapper {
  Future<List<SingleMangaModel>> scrapeMangas({
    String? genre,
    String? orderBy,
  }) async {
    final url = this._createUrl(genre: genre, orderBy: orderBy);
    final scrappedPage = await ScrapUtils.scrapePage(url);

    final mangasDiv = scrappedPage.querySelectorAll("div.postagem_manga");
    List<SingleMangaModel> mangas = [];
    
    mangasDiv.forEach((manga) {
      manga = manga.querySelector("div:nth-child(1) > a:nth-child(1)")!;
      mangas.add(
        SingleMangaModel(
          title: manga.attributes["title"],
          image: manga
              .querySelector("div:nth-child(1) > img")
              ?.attributes["data-src"],
          url: "https://muitomanga.com${manga.attributes['href']}",
        ),
      );
    });
    return mangas;
  }

  String _createUrl({required String? genre, required String? orderBy}) {
    const mainUrl = "https://muitomanga.com/lista-de-mangas";
    String url = mainUrl;

    if (genre != null) {
      url = "${mainUrl}/genero/${genre}";
    }

    if (orderBy != null) {
      url = "${mainUrl}/${orderBy}";
    }

    return url;
  }
}
