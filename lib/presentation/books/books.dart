import 'package:flutter/material.dart';
import 'package:it_bookstore/app/di.dart';
import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/presentation/books/books_viewmodel.dart';
import 'package:it_bookstore/resources/color_manager.dart';
import 'package:it_bookstore/resources/font_manager.dart';
import 'package:it_bookstore/resources/routes_manager.dart';
import 'package:it_bookstore/resources/styles_manager.dart';
import 'package:it_bookstore/resources/values_manager.dart';
import 'package:number_paginator/number_paginator.dart';

class BooksView extends StatefulWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  State<BooksView> createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  BooksViewModel _viewModel = instance<BooksViewModel>();
  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IT Bookstore',
                style: getBoldStyle(
                    color: ColorManager.black, fontSize: FontSize.s20),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: searchController,
                  style: getRegularStyle(
                      color: ColorManager.black, fontSize: FontSize.s13),
                  decoration: InputDecoration(
                    hintText: 'Hľadať knihu podľa názvu, autora, ISBN',
                    suffixIcon: InkWell(
                      onTap: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          _viewModel.search(searchController.text);
                        }
                      },
                      child: Icon(
                        Icons.search,
                        color: ColorManager.orange,
                        size: AppSize.s20,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 2) {
                      return 'Minimána dĺžka slova 2 znaky.';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Expanded(
                child: ListView(
                  children: _scrollWidgets(viewObject),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _scrollWidgets(BooksViewObject? viewObject) {
    List<Widget> widgets = [];
    if (viewObject != null) {
      widgets.addAll(_bookCards(viewObject.books));
    }

    widgets.add(
      NumberPaginator(
        initialPage: 0,
        numberPages: viewObject?.page != null ? viewObject?.total ?? 1 : 1,
        onPageChange: (int index) {
          _viewModel.changePage(index);
        },
        config: NumberPaginatorUIConfig(
          buttonSelectedBackgroundColor: ColorManager.orange,
          buttonUnselectedForegroundColor: ColorManager.black,
        ),
      ),
    );
    return widgets;
  }

  List<Widget> _bookCards(List<Book>? books) {
    if (books == null) {
      return [];
    }

    return books.map((book) => _getBookWidget(book)).toList();
  }

  Widget _getBookWidget(Book book) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.bookDetailsRoute,
            arguments: book.isbn13);
      },
      child: Container(
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
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
