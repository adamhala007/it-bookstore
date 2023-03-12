import 'package:dartz/dartz.dart';
import 'package:it_bookstore/data/network/failure.dart';
import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/repository/repository.dart';
import 'package:it_bookstore/domain/usecase/base_usecase.dart';

class PaginatedSearchUseCase implements BaseUseCase<Query, BookStore> {
  final Repository _repository;

  PaginatedSearchUseCase(this._repository);

  @override
  Future<Either<Failure, BookStore>> execute(Query input) async {
    return await _repository.paginatedSearch(input.query, input.page);
  }
}
