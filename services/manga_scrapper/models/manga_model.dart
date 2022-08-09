class MangaModel {
  final String? title;
  final String? image;
  final String? status;
  final String? lastUpdated;
  final String? synopsis;
  final List<GenreModel> genres;
  final List<ChapterModel> chapters;

  MangaModel({
    required this.title,
    required this.image,
    required this.lastUpdated,
    required this.synopsis,
    required this.genres,
    required this.chapters,
    this.status,
  });
}

class ChapterModel {
  final String? title;
  final String? uploadedDate;
  final String link;

  ChapterModel({
    required this.title,
    required this.uploadedDate,
    required this.link,
  });
}

class GenreModel {
  final String name;

  GenreModel({required this.name});
}
