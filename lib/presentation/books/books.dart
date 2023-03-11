import 'package:flutter/material.dart';
import 'package:it_bookstore/app/di.dart';
import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/presentation/books/books_viewmodel.dart';
import 'package:it_bookstore/resources/color_manager.dart';
import 'package:it_bookstore/resources/styles_manager.dart';
import 'package:it_bookstore/resources/values_manager.dart';

class BooksView extends StatefulWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  State<BooksView> createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  BooksViewModel _viewModel = instance<BooksViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BooksViewObject>(
      stream: _viewModel.outputBooksData,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(BooksViewObject? viewObject) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.lightGray,
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Hľadať knihu podľa názvu, autora, ISBN',
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    _viewModel.searchNewReleases();
                  } else {
                    _viewModel.search(value);
                  }
                },
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Expanded(
                child: ListView(
                  children: _bookCards(viewObject?.books),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _bookCards(List<Book>? books) {
    if (books == null) {
      return [];
    }

    return books.map((book) => _getBookWidget(book)).toList();
  }

  Widget _getBookWidget(Book book) {
    return Container(
      height: 180,
      child: Card(
        child: Row(
          children: [
            Expanded(flex: 2, child: Image.network(book.image)),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(
                  AppPadding.p8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Text(
                        book.title,
                        style: getBoldStyle(color: Colors.black),
                      ),
                    ),
                    Text(
                      book.subtitle,
                      style: getItalicStyle(color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          book.price,
                          style: getSemiBoldStyle(color: Colors.black),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart,
                            color: ColorManager.orange,
                            size: AppSize.s20,
                          ),
                          label: Text(
                            'Kúpiť',
                            style: getMediumStyle(color: ColorManager.orange),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
