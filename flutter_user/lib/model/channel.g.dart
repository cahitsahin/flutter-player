// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Channel _$_$_ChannelFromJson(Map<String, dynamic> json) {
  return _$_Channel(
    name: json['name'] as String,
    url: json['url'] as String,
    createdAt: json['createdAt'] as String,
    id: json['id'] as int,
    updatedAt: json['updatedAt'] as String,
    template: json['template'] as String,
    lang: json['lang'] as String,
  );
}

Map<String, dynamic> _$_$_ChannelToJson(_$_Channel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'url': instance.url,
      'lang': instance.lang,
      'template': instance.template
    };
