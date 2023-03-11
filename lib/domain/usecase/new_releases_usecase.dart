import 'package:dartz/dartz.dart';
import 'package:it_bookstore/data/network/failure.dart';
import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/repository/repository.dart';
import 'package:it_bookstore/domain/usecase/base_usecase.dart';

class NewReleaseUseCase implements BaseUseCase<void, BookStore> {
  final Repository _repository;

  NewReleaseUseCase(this._repository);

  @override
  Future<Either<Failure, BookStore>> execute(void input) async {
    return await _repository.searchNewReleases();
  }
}
