import 'package:it_bookstore/app/extension.dart';
import 'package:it_bookstore/data/responses/responses.dart';
import 'package:it_bookstore/domain/model/model.dart';

const EMPTY_LIST = [];
const EMPTY_STRING = "";
const ZERO = 0;

extension BookStoreResponseMapper on BookStoreResponse? {
  BookStore toDomain() {
    //print(this?.books.orEmpty() ?? 'No total :(');
    return BookStore(
        this?.total?.orEmpty() ?? EMPTY_STRING,
        this?.page?.orEmpty() ?? EMPTY_STRING,
        (this?.books?.map((bookResponse) => bookResponse.toDomain()).toList())
                as List<Book>? ??
            (EMPTY_LIST as List<Book>));
  }
}

extension BookResponseMapper on BookResponse? {
  Book toDomain() {
    return Book(
        this?.error?.orEmpty() ?? EMPTY_STRING,
        this?.title?.orEmpty() ?? EMPTY_STRING,
        this?.subtitle?.orEmpty() ?? EMPTY_STRING,
        this?.authors?.orEmpty() ?? EMPTY_STRING,
        this?.publisher?.orEmpty() ?? EMPTY_STRING,
        this?.isbn10?.orEmpty() ?? EMPTY_STRING,
        this?.isbn13?.orEmpty() ?? EMPTY_STRING,
        this?.pages?.orEmpty() ?? EMPTY_STRING,
        this?.year?.orEmpty() ?? EMPTY_STRING,
        this?.rating?.orEmpty() ?? EMPTY_STRING,
        this?.desc?.orEmpty() ?? EMPTY_STRING,
        this?.price?.orEmpty() ?? EMPTY_STRING,
        this?.image?.orEmpty() ?? EMPTY_STRING,
        this?.url?.orEmpty() ?? EMPTY_STRING,
        this?.pdf);
  }
}
