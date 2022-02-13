import 'package:flutter_user/model/channel.dart';

abstract class ChannelState {
  const ChannelState();
}

class ChannelInitialState extends ChannelState {
  const ChannelInitialState();
}

class ChannelLoadingState extends ChannelState {
  final String message;

  const ChannelLoadingState({
    required this.message,
  });
}

class ChannelSuccessState extends ChannelState {
  final List<Channel> channels;

  const ChannelSuccessState({
    required this.channels,
  });
}

class ChannelErrorState extends ChannelState {
  final String error;

  const ChannelErrorState({
    required this.error,
  });
}
