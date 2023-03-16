import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/login_bloc.dart';
import '../../bloc/login_event.dart';
import '../../bloc/login_state.dart';

/*class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthBloc authBloc;

  LoginForm({
    required this.loginBloc,
    required this.authBloc,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: _passwordController,
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  state is! LoginLoading ? _onLoginButtonPressed : null;
                },
                child: Text('Login'),
              ),
              Container(
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.add(LoginButtonPressed(
      userName: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}*/
