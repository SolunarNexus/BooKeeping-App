// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edition_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditionListResult _$EditionListResultFromJson(Map<String, dynamic> json) =>
    EditionListResult(
      docs: (json['docs'] as List<dynamic>)
          .map((e) => KeyResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EditionListResultToJson(EditionListResult instance) =>
    <String, dynamic>{
      'docs': instance.docs,
    };
