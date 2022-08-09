import 'services/chapter_scrapper/chapter_scrapper.dart';
import 'services/manga_scrapper/manga_scrapper.dart';
import 'services/mangas_scrapper/mangas_scrapper.dart';

void main() {
}

testMangasScrapper() {
  final mangasScrapper = MangasScrapper();
  mangasScrapper.scrapeMangas(genre: "artes-marciais").then((mangas) => {
        mangas.forEach((manga) {
          print(manga.title);
          print(manga.image);
          print(manga.url);
        })
      });
}

testMangaScrapper() {
  final mangaScrapper = MangaScrapper(
    mangaPageLink: 'https://muitomanga.com/manga/solo-leveling',
  );
  mangaScrapper.scrapeManga().then((manga) => {
        print(manga.title),
        print(manga.image),
        print(manga.lastUpdated),
        print(manga.synopsis),
        manga.chapters.forEach((chapter) {
          print(chapter.title);
          print(chapter.link);
          print(chapter.uploadedDate);
        }),
        manga.genres.forEach((genre) {
          print(genre.name);
        })
      });
}

testChapterScrapper() {
  final chapterScrapper = ChapterScrapper(
      chapterPageLink: 'https://muitomanga.com/ler/solo-leveling/capitulo-179');
  chapterScrapper
      .createChapterLinks()
      .then((chapterLinks) => chapterLinks.forEach((link) {
            print(link);
          }));
}
