import 'package:dartz/dartz.dart';
import 'package:it_bookstore/data/network/failure.dart';
import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/repository/repository.dart';
import 'package:it_bookstore/domain/usecase/base_usecase.dart';

class SearchUseCase implements BaseUseCase<String, BookStore> {
  final Repository _repository;

  SearchUseCase(this._repository);

  @override
  Future<Either<Failure, BookStore>> execute(String input) async {
    return await _repository.search(input);
  }
}
