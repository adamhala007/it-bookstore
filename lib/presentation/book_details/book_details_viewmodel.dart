import 'dart:async';

import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/domain/usecase/load_book_details_usecase.dart';
import 'package:it_bookstore/presentation/base/base_viewmodel.dart';

class BookDetailsViewModel extends BaseViewModel
    with BookDetailsViewModelInputs, BookDetailsViewModelOutputs {
  LoadBookDetailsUseCase _loadBookDetailsUseCase;

  final StreamController _streamController =
      StreamController<BookDetailsViewObject>.broadcast();

  BookDetailsViewModel(this._loadBookDetailsUseCase);

  @override
  void start() {}

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  loadDetails(String isbn13) async {
    (await _loadBookDetailsUseCase.execute(isbn13)).fold((failure) {}, (book) {
      inputBookDetailsData.add(BookDetailsViewObject(book));
    });
  }

  @override
  Sink get inputBookDetailsData => _streamController.sink;

  @override
  Stream<BookDetailsViewObject> get outputBookDetailsData =>
      _streamController.stream
          .map((bookDetailsViewObject) => bookDetailsViewObject);
}

abstract class BookDetailsViewModelInputs {
  Sink get inputBookDetailsData;

  loadDetails(String isbn13);
}

abstract class BookDetailsViewModelOutputs {
  Stream<BookDetailsViewObject> get outputBookDetailsData;
}

class BookDetailsViewObject {
  Book book;

  BookDetailsViewObject(this.book);
}
