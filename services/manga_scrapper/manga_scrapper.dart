import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import 'models/manga_model.dart';
import '../../utils/scrape_page_util.dart';

class MangaScrapper {
  final String mangaPageLink;

  MangaScrapper({required this.mangaPageLink});

  Future<MangaModel> scrapeManga() async {
    final scrappedMangaPage = await ScrapUtils.scrapePage(mangaPageLink);
    final data = MangaModel(
      title: scrappedMangaPage.querySelector("h1.subtitles_menus")!.text,
      image: scrappedMangaPage
          .querySelector(".capaMangaInfo > a:nth-child(1) > img")
          ?.attributes["data-src"],
      lastUpdated: scrappedMangaPage
          .querySelector(
            "div.single-chapter:nth-child(1) > small:nth-child(2)",
          )
          ?.text,
      synopsis: scrappedMangaPage
          .querySelector(".boxAnimeSobreLast > p")
          ?.innerHtml
          .trim(),
      chapters: _getChapters(scrappedMangaPage),
      genres: _getGenres(scrappedMangaPage),
    );
    return data;
  }

  List<GenreModel> _getGenres(dom.Document scrappedPage) {
    final genreDivs =
        scrappedPage.querySelectorAll(".lancamento-list > li > a");

    final List<GenreModel> genres = [];
    genreDivs.forEach((element) {
      genres.add(GenreModel(name: element.innerHtml));
    });
    return genres;
  }

  List<ChapterModel> _getChapters(dom.Document scrappedPage) {
    final chapterDivs = scrappedPage.querySelectorAll("div.single-chapter");

    final List<ChapterModel> chapterList = [];
    chapterDivs.forEach((element) {
      chapterList.add(
        ChapterModel(
          title: element.querySelector('a')?.text,
          link:
              "https://muitomanga.com${element.querySelector('a')?.attributes['href']}",
          uploadedDate: element.querySelector("small")?.text,
        ),
      );
    });

    return chapterList;
  }
}
