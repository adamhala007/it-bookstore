import 'package:it_bookstore/app/extension.dart';
import 'package:it_bookstore/data/responses/responses.dart';
import 'package:it_bookstore/data/util/bookstore_util.dart';
import 'package:it_bookstore/domain/model/model.dart';

const emptyList = [];
const Map<String, String> emptyMap = {};
const emptyString = "";
const zero = 0;

extension BookStoreResponseMapper on BookStoreResponse? {
  BookStore toDomain() {
    return BookStore(
        BookStoreUtil.countMaxPage(this?.total),
        this?.page?.orEmpty() ?? emptyString,
        (this
                ?.books
                ?.map((bookResponse) => bookResponse.toDomain())
                .toList()) ??
            (emptyList as List<Book>));
  }
}

extension BookResponseMapper on BookResponse? {
  Book toDomain() {
    return Book(
        this?.error?.orEmpty() ?? emptyString,
        this?.title?.orEmpty() ?? emptyString,
        this?.subtitle?.orEmpty() ?? emptyString,
        this?.authors?.orEmpty() ?? emptyString,
        this?.publisher?.orEmpty() ?? emptyString,
        this?.isbn10?.orEmpty() ?? emptyString,
        this?.isbn13?.orEmpty() ?? emptyString,
        this?.pages?.orEmpty() ?? emptyString,
        this?.year?.orEmpty() ?? emptyString,
        this?.rating?.orEmpty() ?? emptyString,
        this?.desc?.orEmpty() ?? emptyString,
        this?.price?.orEmpty() ?? emptyString,
        this?.image?.orEmpty() ?? emptyString,
        this?.url?.orEmpty() ?? emptyString,
        this?.pdf ?? emptyMap);
  }
}
