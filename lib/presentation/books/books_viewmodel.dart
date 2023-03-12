import 'dart:async';
import 'dart:ffi';
import 'dart:math';

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
    (await _newReleaseUseCase.execute(Void)).fold((failure) {}, (bookStore) {
      inputBooksData.add(BooksViewObject(
          max(int.tryParse(bookStore.total) ?? 1, 1),
          int.tryParse(bookStore.page ?? ''),
          bookStore.books));
    });
  }

  @override
  search(String query) async {
    searchQuery = query;
    (await _searchUseCase.execute(query)).fold((failure) {}, (bookStore) {
      inputBooksData.add(BooksViewObject(
          max(int.tryParse(bookStore.total) ?? 1, 1),
          int.tryParse(bookStore.page ?? '1') ?? 1,
          bookStore.books));
    });
  }

  @override
  changePage(int page) async {
    if (searchQuery.isNotEmpty && this.page != page) {
      this.page = page;
      (await _paginatedSearchUseCase.execute(Query(searchQuery, page)))
          .fold((failure) {}, (bookStore) {
        inputBooksData.add(BooksViewObject(
            max(int.tryParse(bookStore.total) ?? 1, 1),
            int.tryParse(bookStore.page ?? '1') ?? 1,
            bookStore.books));
      });
    }
  }

  @override
  nextPage() async {
    if (searchQuery.isNotEmpty && page != null) {
      page = page! + 1;
      (await _paginatedSearchUseCase.execute(Query(searchQuery, page!)))
          .fold((failure) {}, (bookStore) {
        inputBooksData.add(BooksViewObject(
            max(int.tryParse(bookStore.total) ?? 1, 1),
            int.tryParse(bookStore.page ?? '1') ?? 1,
            bookStore.books));
      });
    }
  }

  @override
  previousPage() async {
    if (searchQuery.isNotEmpty && page != null) {
      page = min(page! - 1, 1);
      (await _paginatedSearchUseCase.execute(Query(searchQuery, page!)))
          .fold((failure) {}, (bookStore) {
        inputBooksData.add(BooksViewObject(
            max(int.tryParse(bookStore.total) ?? 1, 1),
            int.tryParse(bookStore.page ?? '1') ?? 1,
            bookStore.books));
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
  previousPage();
  nextPage();
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
