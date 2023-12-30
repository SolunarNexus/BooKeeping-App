// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as String?,
      description: json['description'] as String?,
      imgUrl: json['imgUrl'] as String,
      publishDate: json['publishDate'] as String,
      publishers: (json['publishers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      pages: json['pages'] as int?,
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isbn: json['isbn'] as String,
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'authors': instance.authors,
      'imgUrl': instance.imgUrl,
      'publishDate': instance.publishDate,
      'publishers': instance.publishers,
      'pages': instance.pages,
      'languages': instance.languages,
      'categories': instance.categories,
      'isbn': instance.isbn,
    };
