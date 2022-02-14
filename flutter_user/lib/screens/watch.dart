import 'package:flutter/material.dart';
import 'package:flutter_user/model/channel.dart';
import 'package:better_player/better_player.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({Key? key, required this.channel}) : super(key: key);

  final Channel channel;

  @override
  createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.channel.url);
    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.channel.name,
        ),
      ),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(
          controller: _betterPlayerController,
        ),
      ),
    );
  }
}
