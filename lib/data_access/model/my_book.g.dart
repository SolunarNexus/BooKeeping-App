// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBook _$MyBookFromJson(Map<String, dynamic> json) => MyBook(
      id: json['id'] as String?,
      readState: $enumDecode(_$ReadStateEnumMap, json['readState']),
      userId: json['userId'] as String,
      bookId: json['bookId'] as String,
    );

Map<String, dynamic> _$MyBookToJson(MyBook instance) => <String, dynamic>{
      'id': instance.id,
      'readState': _$ReadStateEnumMap[instance.readState]!,
      'userId': instance.userId,
      'bookId': instance.bookId,
    };

const _$ReadStateEnumMap = {
  ReadState.reading: 'reading',
  ReadState.completed: 'completed',
  ReadState.planToRead: 'planToRead',
};
