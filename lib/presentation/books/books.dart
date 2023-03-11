import 'package:flutter/material.dart';
import 'package:it_bookstore/app/di.dart';
import 'package:it_bookstore/presentation/books/books_viewmodel.dart';

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
    return Scaffold(
      body: StreamBuilder<BooksViewObject>(
        stream: _viewModel.outputBooksData,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        },
      ),
    );
  }

  Widget _getContentWidget(BooksViewObject? viewObject) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${viewObject ?? 'No data loaded.'}',
            style: TextStyle(color: Colors.black),
          ),
          TextButton(
            onPressed: () {
              _viewModel.searchNewReleases();
            },
            child: Text('Load'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
