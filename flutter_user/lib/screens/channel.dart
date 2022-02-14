import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user/blocs/channel/channel_bloc.dart';
import 'package:flutter_user/blocs/channel/channel_event.dart';
import 'package:flutter_user/blocs/channel/channel_state.dart';
import 'package:flutter_user/data/repository.dart';
import 'package:flutter_user/model/channel.dart';
import 'package:flutter_user/screens/watch.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  @override
  Widget build(BuildContext context) {
    Repository repo = Repository();
    BlocProvider.of<ChannelBloc>(context).add(ChannelFetchEvent(widget.token));
    List<Channel> _channel = [];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Channels"),
        ),
        body: BlocConsumer<ChannelBloc, ChannelState>(
          listener: (context, state) {
            if (state is ChannelLoadingState) {
            } else if (state is ChannelSuccessState && state.channels.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No more Channels')));
            } else if (state is ChannelErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
              BlocProvider.of<ChannelBloc>(context).isFetching = false;
            }
            return;
          },
          builder: (context, state) {
            if (state is ChannelInitialState ||
                state is ChannelLoadingState && _channel.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChannelSuccessState) {
              _channel.addAll(state.channels);
              BlocProvider.of<ChannelBloc>(context).isFetching = false;
            } else if (state is ChannelErrorState && _channel.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<ChannelBloc>(context)
                          ..isFetching = true
                          ..add(ChannelFetchEvent(widget.token));
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                    const SizedBox(height: 15),
                    Text(state.error, textAlign: TextAlign.center),
                  ],
                ),
              );
            }
            _channel.sort((b, a) => b.createdAt.compareTo(a.createdAt));
            return ListView.builder(
              itemCount: _channel.length,
              itemBuilder: (context, index) {
                // Time and Name Formatting
                DateTime time = DateTime.parse(_channel[index].createdAt);

                String name = _channel[index].name;
                String capitalize(String s) =>
                    s[0].toUpperCase() + s.substring(1);
                name = capitalize(name);

                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(name),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WatchPage(
                            channel: _channel[index],
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: _channel[index].name == 'Untitled'
                          // ignore: prefer_const_constructors
                          ? NetworkImage(
                              'https://cdn.pixabay.com/photo/2012/04/24/12/29/no-symbol-39767_1280.png')
                          : NetworkImage(
                              'https://devel.uniqcast.com/samples/logos/${_channel[index].id}.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    subtitle: Text(_channel[index].id.toString()),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            );
          },
        ));
  }
}
