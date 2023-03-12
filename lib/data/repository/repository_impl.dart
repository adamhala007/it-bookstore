import 'package:dartz/dartz.dart';
import 'package:it_bookstore/data/data_source/remote_data_soruce.dart';
import 'package:it_bookstore/data/mapper/mapper.dart';
import 'package:it_bookstore/data/network/error_handler.dart';
import 'package:it_bookstore/data/network/failure.dart';
import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Book>> getBookDetail(String isbn13) async {
    try {
      final response = await _remoteDataSource.getBookDetail(isbn13);
      return Right(response.toDomain());
    } catch (error) {
      return Left(
          Failure(ResponseCode.loadDataFailed, ResponseMessage.loadDataFailed));
    }
  }

  @override
  Future<Either<Failure, BookStore>> paginatedSearch(
      String query, int page) async {
    try {
      final response = await _remoteDataSource.paginatedSearch(query, page);
      return Right(response.toDomain());
    } catch (error) {
      return Left(
          Failure(ResponseCode.loadDataFailed, ResponseMessage.loadDataFailed));
    }
  }

  @override
  Future<Either<Failure, BookStore>> search(String query) async {
    try {
      final response = await _remoteDataSource.search(query);
      return Right(response.toDomain());
    } catch (error) {
      return Left(
          Failure(ResponseCode.loadDataFailed, ResponseMessage.loadDataFailed));
    }
  }

  @override
  Future<Either<Failure, BookStore>> searchNewReleases() async {
    try {
      final response = await _remoteDataSource.searchNewReleases();
      return Right(response.toDomain());
    } catch (error) {
      return Left(
          Failure(ResponseCode.loadDataFailed, ResponseMessage.loadDataFailed));
    }
  }
}
