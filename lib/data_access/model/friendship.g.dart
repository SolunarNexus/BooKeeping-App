// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friendship _$FriendshipFromJson(Map<String, dynamic> json) => Friendship(
      id: json['id'] as String?,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      state: $enumDecode(_$FriendshipStateEnumMap, json['state']),
    );

Map<String, dynamic> _$FriendshipToJson(Friendship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'state': _$FriendshipStateEnumMap[instance.state]!,
    };

const _$FriendshipStateEnumMap = {
  FriendshipState.sent: 'sent',
  FriendshipState.accepted: 'accepted',
};
