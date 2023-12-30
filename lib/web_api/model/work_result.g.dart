// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkResult _$WorkResultFromJson(Map<String, dynamic> json) => WorkResult(
      title: json['title'] as String,
      authorName: (json['author_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      editions:
          EditionListResult.fromJson(json['editions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkResultToJson(WorkResult instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author_name': instance.authorName,
      'editions': instance.editions,
    };
