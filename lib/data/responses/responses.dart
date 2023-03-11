import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BookStoreResponse {
  @JsonKey(name: 'total')
  String? total;
  @JsonKey(name: 'page')
  String? page;
  @JsonKey(name: 'books')
  List<BookResponse>? books;

  BookStoreResponse(this.total, this.page, this.books);

  Map<String, dynamic> toJson() => _$BookStoreResponseToJson(this);

  factory BookStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$BookStoreResponseFromJson(json);

  @override
  String toString() {
    return 'BookStoreResponse{total: $total, page: $page, books: $books}';
  }
}

@JsonSerializable()
class BookResponse {
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'subtitle')
  String? subtitle;
  @JsonKey(name: 'authors')
  String? authors;
  @JsonKey(name: 'publisher')
  String? publisher;
  @JsonKey(name: 'isbn10')
  String? isbn10;
  @JsonKey(name: 'isbn13')
  String? isbn13;
  @JsonKey(name: 'pages')
  String? pages;
  @JsonKey(name: 'year')
  String? year;
  @JsonKey(name: 'rating')
  String? rating;
  @JsonKey(name: 'desc')
  String? desc;
  @JsonKey(name: 'price')
  String? price;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'pdf')
  dynamic pdf;

  BookResponse(
      this.error,
      this.title,
      this.subtitle,
      this.authors,
      this.publisher,
      this.isbn10,
      this.isbn13,
      this.pages,
      this.year,
      this.rating,
      this.desc,
      this.price,
      this.image,
      this.url,
      this.pdf);

  Map<String, dynamic> toJson() => _$BookResponseToJson(this);

  factory BookResponse.fromJson(Map<String, dynamic> json) =>
      _$BookResponseFromJson(json);

  @override
  String toString() {
    return 'BookResponse{error: $error, title: $title, subtitle: $subtitle, authors: $authors, publisher: $publisher, isbn10: $isbn10, isbn13: $isbn13, pages: $pages, year: $year, rating: $rating, desc: $desc, price: $price, image: $image, url: $url, pdf: $pdf}';
  }
}
