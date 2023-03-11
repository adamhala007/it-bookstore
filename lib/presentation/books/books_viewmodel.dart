import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/usecase/new_releases_usecase.dart';
import 'package:it_bookstore/domain/usecase/search_usecase.dart';
import 'package:it_bookstore/presentation/base/base_viewmodel.dart';

class BooksViewModel extends BaseViewModel
    with BooksViewModelInputs, BooksViewModelOutputs {
  NewReleaseUseCase _newReleaseUseCase;
  SearchUseCase _searchUseCase;

  final StreamController _streamController =
      StreamController<BooksViewObject>.broadcast();

  BooksViewModel(this._newReleaseUseCase, this._searchUseCase);

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
      inputBooksData.add(BooksViewObject(
          max(int.tryParse(bookStore.total) ?? 1, 1),
          int.tryParse(bookStore.page ?? ''),
          bookStore.books));
    });
  }

  @override
  search(String query) async {
    (await _searchUseCase.execute(query)).fold((failure) {
      print('failure');
    }, (bookStore) {
      print('${bookStore.page}/${bookStore.total}');
      inputBooksData.add(BooksViewObject(
          max(int.tryParse(bookStore.total) ?? 1, 1),
          int.tryParse(bookStore.page ?? '1') ?? 1,
          bookStore.books));
    });
  }

  @override
  Sink get inputBooksData => _streamController.sink;

  @override
  Stream<BooksViewObject> get outputBooksData =>
      _streamController.stream.map((booksViewObject) => booksViewObject);

  @override
  changePage(int page) {}
}

abstract class BooksViewModelInputs {
  Sink get inputBooksData;

  changePage(int page);
  search(String query);
  searchNewReleases();
}

abstract class BooksViewModelOutputs {
  Stream<BooksViewObject> get outputBooksData;
}

class BooksViewObject {
  int total;
  int? page;
  List<Book> books;

  BooksViewObject(this.total, this.page, this.books);
}
