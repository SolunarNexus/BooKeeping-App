// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookResult _$BookResultFromJson(Map<String, dynamic> json) => BookResult(
      publishers: (json['publishers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      authors: (json['authors'] as List<dynamic>)
          .map((e) => AuthorKeyResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      publishDate: json['publish_date'] as String,
      numberOfPages: json['number_of_pages'] as int?,
      languages: (json['languages'] as List<dynamic>)
          .map((e) => LanguageResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects:
          (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
      isbn: (json['isbn_10'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BookResultToJson(BookResult instance) =>
    <String, dynamic>{
      'publishers': instance.publishers,
      'description': instance.description,
      'authors': instance.authors,
      'publish_date': instance.publishDate,
      'number_of_pages': instance.numberOfPages,
      'languages': instance.languages,
      'subjects': instance.subjects,
      'isbn_10': instance.isbn,
    };
