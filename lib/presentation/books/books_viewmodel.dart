import 'dart:async';
import 'dart:ffi';

import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/usecase/new_releases_usecase.dart';
import 'package:it_bookstore/presentation/base/base_viewmodel.dart';

class BooksViewModel extends BaseViewModel
    with BooksViewModelInputs, BooksViewModelOutputs {
  NewReleaseUseCase _newReleaseUseCase;

  final StreamController _streamController =
      StreamController<BooksViewObject>.broadcast();

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
  searchNewReleases() async {
    (await _newReleaseUseCase.execute(Void)).fold((failure) {
      print('failure');
    }, (bookStore) {
      print('success');
      inputBooksData.add(
          BooksViewObject(bookStore.total, bookStore.page, bookStore.books));
    });
  }

  @override
  search(String query) async {
    (await _newReleaseUseCase.execute(query)).fold((failure) {
      print('failure');
    }, (bookStore) {
      print('success');
      inputBooksData.add(
          BooksViewObject(bookStore.total, bookStore.page, bookStore.books));
    });
  }

  @override
  Sink get inputBooksData => _streamController.sink;

  @override
  Stream<BooksViewObject> get outputBooksData =>
      _streamController.stream.map((booksViewObject) => booksViewObject);
}

abstract class BooksViewModelInputs {
  Sink get inputBooksData;

  search(String query);
  searchNewReleases();
}

abstract class BooksViewModelOutputs {
  Stream<BooksViewObject> get outputBooksData;
}

class BooksViewObject {
  String total;
  String? page;
  List<Book> books;

  BooksViewObject(this.total, this.page, this.books);
}
