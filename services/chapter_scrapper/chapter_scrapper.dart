import 'package:http/http.dart' as http;
import '../../utils/scrape_page_util.dart';

class ChapterScrapper {
  final String chapterPageLink;

  ChapterScrapper({
    required this.chapterPageLink,
  });

  Future<List<String>> createChapterLinks() async {
    final mangaName = this.chapterPageLink.split("ler/")[1].split("/")[0];
    final chapter = int.parse(this.chapterPageLink.split("capitulo-")[1]);
    final numberOfPages = await this._getNumberOfPages();

    if (this._isHostedInTheUsualHost(mangaName: mangaName, chapter: chapter)) {
      final List<String> chapterLinks = [];
      for (int pageNumber = 1; pageNumber <= numberOfPages; pageNumber++) {
        chapterLinks.add(
          "https://cdn.statically.io/img/imgs2.muitomanga.com/f=auto/imgs/${mangaName}/${chapter}/$pageNumber.jpg",
        );
      }
      return chapterLinks;
    }

    final List<String> chapterLinks = [];
    for (int pageNumber = 1; pageNumber <= numberOfPages; pageNumber++) {
      chapterLinks.add(
        "https://cdn.statically.io/img/imgs2.muitomanga.com/f=auto/imgs/${mangaName}/${chapter}/$pageNumber.jpg",
      );
    }
    return chapterLinks;
  }

  Future _getNumberOfPages() async {
    final scrappedChapterPage = await ScrapUtils.scrapePage(chapterPageLink);
    final numberOfPagesElement =
        scrappedChapterPage.querySelectorAll(".select_paged > option")[1];

    final numberOfPages = int.parse(numberOfPagesElement.text.split("/")[1]);
    return numberOfPages;
  }

  bool _isHostedInTheUsualHost({
    required String mangaName,
    required int chapter,
  }) {
    final usualHostUrl = Uri.parse(
      "https://cdn.statically.io/img/imgs2.muitomanga.com/f=auto/imgs/${mangaName}/${chapter}/1.jpg",
    );
    final statusCode =
        http.get(usualHostUrl).then((response) => response.statusCode);

    final isHostedInTheUsualHost = statusCode != 404 ? false : true;
    return isHostedInTheUsualHost;
  }
}
