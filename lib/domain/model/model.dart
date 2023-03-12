class Book {
  String error;
  String title;
  String subtitle;
  String authors;
  String publisher;
  String isbn10;
  String isbn13;
  String pages;
  String year;
  String rating;
  String desc;
  String price;
  String image;
  String url;
  Map<String, String> pdf;

  Book(
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

  @override
  String toString() {
    return 'Book{error: $error, title: $title, subtitle: $subtitle, authors: $authors, publisher: $publisher, isbn10: $isbn10, isbn13: $isbn13, pages: $pages, year: $year, rating: $rating, desc: $desc, price: $price, image: $image, url: $url, pdf: $pdf}';
  }
}

class BookStore {
  String total;
  String? page;
  List<Book> books;

  BookStore(this.total, this.page, this.books);

  @override
  String toString() {
    return 'BookStore{total: $total, page: $page, books: $books}';
  }
}
