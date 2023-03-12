// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookStoreResponse _$BookStoreResponseFromJson(Map<String, dynamic> json) =>
    BookStoreResponse(
      json['total'] as String?,
      json['page'] as String?,
      (json['books'] as List<dynamic>?)
          ?.map((e) => BookResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookStoreResponseToJson(BookStoreResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'books': instance.books,
    };

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) => BookResponse(
      json['error'] as String?,
      json['title'] as String?,
      json['subtitle'] as String?,
      json['authors'] as String?,
      json['publisher'] as String?,
      json['isbn10'] as String?,
      json['isbn13'] as String?,
      json['pages'] as String?,
      json['year'] as String?,
      json['rating'] as String?,
      json['desc'] as String?,
      json['price'] as String?,
      json['image'] as String?,
      json['url'] as String?,
      (json['pdf'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$BookResponseToJson(BookResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'isbn10': instance.isbn10,
      'isbn13': instance.isbn13,
      'pages': instance.pages,
      'year': instance.year,
      'rating': instance.rating,
      'desc': instance.desc,
      'price': instance.price,
      'image': instance.image,
      'url': instance.url,
      'pdf': instance.pdf,
    };
