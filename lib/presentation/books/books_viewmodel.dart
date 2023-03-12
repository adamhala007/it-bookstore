import 'dart:async';
import 'dart:ffi';

import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/usecase/new_releases_usecase.dart';
import 'package:it_bookstore/domain/usecase/paginated_search_usecase.dart';
import 'package:it_bookstore/domain/usecase/search_usecase.dart';
import 'package:it_bookstore/presentation/base/base_viewmodel.dart';

class BooksViewModel extends BaseViewModel
    with BooksViewModelInputs, BooksViewModelOutputs {
  NewReleaseUseCase _newReleaseUseCase;
  SearchUseCase _searchUseCase;
  PaginatedSearchUseCase _paginatedSearchUseCase;

  final StreamController _streamController =
      StreamController<BooksViewObject>.broadcast();

  String searchQuery = '';
  int? page;

  BooksViewModel(this._newReleaseUseCase, this._searchUseCase,
      this._paginatedSearchUseCase);

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
      inputBooksData.add(BooksViewObject(1, 1, [],
          errorCode: failure.code, errorMsg: failure.message));
    }, (bookStore) {
      inputBooksData.add(BooksViewObject(bookStore.maxPage,
          int.tryParse(bookStore.page ?? ''), bookStore.books));
    });
  }

  @override
  search(String query) async {
    searchQuery = query;
    (await _searchUseCase.execute(query)).fold((failure) {
      inputBooksData.add(BooksViewObject(1, 1, [],
          errorCode: failure.code, errorMsg: failure.message));
    }, (bookStore) {
      inputBooksData.add(BooksViewObject(bookStore.maxPage,
          int.tryParse(bookStore.page ?? '1') ?? 1, bookStore.books));
    });
  }

  @override
  changePage(int page) async {
    if (searchQuery.isNotEmpty && this.page != page) {
      this.page = page;
      (await _paginatedSearchUseCase.execute(Query(searchQuery, page))).fold(
          (failure) {
        inputBooksData.add(BooksViewObject(1, 1, [],
            errorCode: failure.code, errorMsg: failure.message));
      }, (bookStore) {
        inputBooksData.add(BooksViewObject(bookStore.maxPage,
            int.tryParse(bookStore.page ?? '1') ?? 1, bookStore.books));
      });
    }
  }

  @override
  Sink get inputBooksData => _streamController.sink;

  @override
  Stream<BooksViewObject> get outputBooksData =>
      _streamController.stream.map((booksViewObject) => booksViewObject);
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
  int? errorCode;
  String? errorMsg;
  int? maxPage;
  int? page;
  List<Book> books;

  BooksViewObject(this.maxPage, this.page, this.books,
      {this.errorCode, this.errorMsg});
}
