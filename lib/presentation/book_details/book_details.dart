import 'package:flutter/material.dart';
import 'package:it_bookstore/app/di.dart';
import 'package:it_bookstore/presentation/book_details/book_details_viewmodel.dart';

class BookDetailsView extends StatefulWidget {
  String? isbn13;

  BookDetailsView({RouteSettings? routeSettings}) {
    if (routeSettings != null) {
      isbn13 = routeSettings.arguments as String?;
    }
  }

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  final BookDetailsViewModel _viewModel = instance<BookDetailsViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    if (widget.isbn13 != null) {
      _viewModel.loadDetails(widget.isbn13!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BookDetailsViewObject>(
        stream: _viewModel.outputBookDetailsData,
        builder: (context, snapshot) {
          return SafeArea(
              child: Scaffold(
            body: _getContentWidget(snapshot.data),
          ));
        });
  }

  _getContentWidget(BookDetailsViewObject? viewObject) {
    if (viewObject == null) {
      return Container();
    }
    return Container(
      child: Text('$viewObject'),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
