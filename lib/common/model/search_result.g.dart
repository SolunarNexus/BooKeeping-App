// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      docs: (json['docs'] as List<dynamic>)
          .map((e) => BookResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      numFound: json['numFound'] as int,
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'numFound': instance.numFound,
    };
