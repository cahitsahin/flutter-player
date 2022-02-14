abstract class ChannelEvent {
  const ChannelEvent();
}

class ChannelFetchEvent extends ChannelEvent {
  final String token;
  const ChannelFetchEvent(this.token);
}
