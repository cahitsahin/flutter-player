import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user/blocs/channel/channel_event.dart';
import 'package:flutter_user/blocs/channel/channel_state.dart';
import 'package:flutter_user/data/repository.dart';
import 'package:flutter_user/model/channel.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final Repository repo;
  bool isFetching = false;

  ChannelBloc(this.repo) : super(const ChannelInitialState()) {
    on<ChannelFetchEvent>(
        (event, emit) async => await _fetchChannels(emit, event.token));
  }

  Future<void> _fetchChannels(Emitter<ChannelState> emit, String token) async {
    emit(const ChannelLoadingState(message: 'Loading Channels'));
    final response = await repo.fetchChannels(token);
    if (response.statusCode == 200) {
      final channels = (jsonDecode(response.body) as List)
          .map((e) => Channel.fromJson(e))
          .toList();
      emit(ChannelSuccessState(channels: channels));
    } else {
      emit(ChannelErrorState(
          error: response.body.toString() + response.statusCode.toString()));
    }
  }
}
