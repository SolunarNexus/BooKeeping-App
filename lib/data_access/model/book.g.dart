// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as String?,
      description: json['description'] as String,
      imgUrl: json['imgUrl'] as String,
      publishDate: DateTime.parse(json['publishDate'] as String),
      publisher: json['publisher'] as String,
      pages: json['pages'] as int,
      language: json['language'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isbn: json['isbn'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'imgUrl': instance.imgUrl,
      'publishDate': instance.publishDate.toIso8601String(),
      'publisher': instance.publisher,
      'pages': instance.pages,
      'language': instance.language,
      'categories': instance.categories,
      'isbn': instance.isbn,
    };
