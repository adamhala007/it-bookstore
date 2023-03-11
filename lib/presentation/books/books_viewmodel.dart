import 'dart:async';
import 'dart:ffi';

import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/usecase/new_releases_usecase.dart';
import 'package:it_bookstore/presentation/base/base_viewmodel.dart';

class BooksViewModel extends BaseViewModel
    with BooksViewModelInputs, BooksViewModelOutputs {
  NewReleaseUseCase _newReleaseUseCase;

  final StreamController _streamController =
      StreamController<BooksViewObject>();

  BooksViewModel(this._newReleaseUseCase);

  @override
  void start() {
    searchNewReleases();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  Sink get inputBooksData => _streamController.sink;

  @override
  Stream<BooksViewObject> get outputBooksData =>
      _streamController.stream.map((booksViewObject) => booksViewObject);

  @override
  searchNewReleases() async {
    (await _newReleaseUseCase.execute(Void)).fold((failure) {
      print('failure');
    }, (bookStore) {
      print('success');
      inputBooksData.add(BooksViewObject(bookStore));
    });
  }
}

abstract class BooksViewModelInputs {
  Sink get inputBooksData;

  searchNewReleases();
}

abstract class BooksViewModelOutputs {
  Stream<BooksViewObject> get outputBooksData;
}

class BooksViewObject {
  BookStore bookStore;

  BooksViewObject(this.bookStore);

  @override
  String toString() {
    return 'BooksViewObject{bookStore: $bookStore}';
  }
}
