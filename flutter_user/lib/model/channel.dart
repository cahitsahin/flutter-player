import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel.freezed.dart';
part 'channel.g.dart';

@freezed
class Channel with _$Channel {
  // 5. define a factory constructor
  factory Channel({
    // 6. list all the arguments/properties
    required int id,
    required String name,
    required String lang,
    required String url,
    required String template,
    required String createdAt,
    required String updatedAt,
    // 7. assign it with the `_Review` class constructor
  }) = _Channel;

  // 8. define another factory constructor to parse from json
  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}
