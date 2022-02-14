import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user/blocs/channel/channel_bloc.dart';
import 'package:flutter_user/blocs/signIn/signin_bloc.dart';
import 'package:flutter_user/data/repository.dart';
import 'package:flutter_user/screens/channel.dart';
import 'package:flutter_user/screens/signIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Repository repo = Repository();
    return MaterialApp(
      title: 'Flutter Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: BlocProvider(
          create: (context) => SignInBloc(repo), child: const SignInPage()),
    );
  }
}
