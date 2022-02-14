import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user/blocs/channel/channel_bloc.dart';
import 'package:flutter_user/blocs/signIn/signin_bloc.dart';
import 'package:flutter_user/blocs/signIn/signin_event.dart';
import 'package:flutter_user/blocs/signIn/signin_state.dart';
import 'package:flutter_user/data/repository.dart';
import 'package:flutter_user/screens/channel.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    String token;
    Repository repo = Repository();
    final formKey = GlobalKey<FormState>();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign In"),
        ),
        body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInLoadingState) {
            } else if (state is SignInErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
            return;
          },
          builder: (context, state) {
            if (state is SignInLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SignInSuccessState) {
              token = state.token;

              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ChannelBloc(repo),
                      child: ChannelPage(
                        token: token,
                      ),
                    ),
                  ),
                );
              });
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: 160,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Enter username',
                              labelText: 'Username',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Enter Password',
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              formKey.currentState?.validate();
                              BlocProvider.of<SignInBloc>(context)
                                ..isFetching = true
                                ..add(SignInFetchEvent(usernameController.text,
                                    passController.text));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
