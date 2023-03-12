import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:it_bookstore/app/di.dart';
import 'package:it_bookstore/domain/model/model.dart';
import 'package:it_bookstore/presentation/book_details/book_details_viewmodel.dart';
import 'package:it_bookstore/resources/color_manager.dart';
import 'package:it_bookstore/resources/font_manager.dart';
import 'package:it_bookstore/resources/styles_manager.dart';
import 'package:it_bookstore/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

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
            backgroundColor: ColorManager.lightGray,
            body: _getContentWidget(snapshot.data),
          ));
        });
  }

  _getContentWidget(BookDetailsViewObject? viewObject) {
    if (viewObject == null) {
      return Container();
    }
    Book book = viewObject.book;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: AppSize.s170,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(book.image),
                              RatingBarIndicator(
                                itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: ColorManager.orange),
                                itemCount: 5,
                                itemSize: 15.0,
                                rating: double.tryParse(book.rating) ?? 0.0,
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book.title,
                                          style: getBoldStyle(
                                              color: Colors.black,
                                              fontSize: FontSize.s14),
                                        ),
                                        SizedBox(
                                          height: AppSize.s8,
                                        ),
                                        Text(
                                          book.authors,
                                          style: getSemiBoldStyle(
                                              color: ColorManager.darkGray),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                book.subtitle,
                                style: getItalicStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                  child: Divider(),
                ),
                Text(
                  'Popis',
                  style: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s14),
                ),
                SizedBox(
                  height: AppSize.s8,
                ),
                Text(
                  '${book.desc}',
                  style: getItalicStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s13,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Publisher:',
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${book.publisher}',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: FontSize.s13),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: AppPadding.p8,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Pages:',
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${book.pages}',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: FontSize.s13),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: AppPadding.p8,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Year:',
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${book.year}',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: FontSize.s13),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: AppPadding.p8,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'ISBN:',
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${book.isbn13}',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: FontSize.s13),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Divider(),
                Container(
                  color: ColorManager.white,
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${book.price}',
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16,
                              ),
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
                                style: getMediumStyle(
                                  color: ColorManager.orange,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: AppSize.s16,
                ),
                _getPdfSection(book.pdf),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getPdfSection(Map<String, String> pdf) {
    if (pdf.isEmpty) {
      return Container();
    }
    List<Widget> widgets = [];
    widgets.add(
      Text(
        'Ukážka',
        style:
            getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s14),
      ),
    );

    for (String key in pdf.keys) {
      widgets.add(
        TextButton(
          onPressed: () async {
            var uri = Uri.parse('${pdf[key]}');
            if (await canLaunchUrl(uri)) {
              await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );
            } else {
              throw 'Could not launch $uri';
            }
          },
          child: Text(
            key,
            style: getBoldStyle(color: ColorManager.orange),
          ),
        ),
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
