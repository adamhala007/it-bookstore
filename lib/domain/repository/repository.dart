import 'package:dartz/dartz.dart';
import 'package:it_bookstore/data/network/failure.dart';
import 'package:it_bookstore/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, BookStore>> search(String query);
  Future<Either<Failure, BookStore>> paginatedSearch(String query, int page);
  Future<Either<Failure, BookStore>> searchNewReleases();
  Future<Either<Failure, Book>> getBookDetail(String isbn13);
}
