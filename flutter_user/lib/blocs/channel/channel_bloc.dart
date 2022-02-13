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
    on<ChannelFetchEvent>((event, emit) async => await _signIn(emit));
  }

  Future<void> _signIn(Emitter<ChannelState> emit) async {
    emit(const ChannelLoadingState(message: 'Loading Channel'));
    final response = await repo.fetchChannels();
    final channels =
        (jsonDecode(response) as List).map((e) => Channel.fromJson(e)).toList();
    if (response.statusCode == 200) {
      emit(ChannelSuccessState(channels: channels));
    } else {
      emit(ChannelErrorState(error: response));
    }
  }
}
