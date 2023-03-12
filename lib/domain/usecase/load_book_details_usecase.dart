import 'package:dartz/dartz.dart';
import 'package:it_bookstore/data/network/failure.dart';
import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/repository/repository.dart';
import 'package:it_bookstore/domain/usecase/base_usecase.dart';

class LoadBookDetailsUseCase implements BaseUseCase<String, Book> {
  final Repository _repository;

  LoadBookDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, Book>> execute(String input) async {
    return await _repository.getBookDetail(input);
  }
}
