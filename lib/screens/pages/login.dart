import 'package:flutter/material.dart';
import 'package:news_app/api/authentication_api.dart';
import 'package:news_app/screens/home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationAPI authenticationAPI = AuthenticationAPI();
  bool isLoading = false;
  bool loginError = false;

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  String username;
  String password;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: (isLoading) ? _drawLoading() : _drawLoginForm(),
      ),
    );
  }

  Widget _drawLoginForm() {
    if (loginError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(
              child: Text('Login Error'),
            ),
          ),
          RaisedButton(
              child: Text(
                'Try Again',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                setState(() {
                  loginError = false;
                });
              }),
        ],
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });

                username = _usernameController.text;
                password = _passwordController.text;

                var response = await authenticationAPI.login(
                    username, password);
                if (response) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                } else {
                  loginError = true;
                }

                setState(() {
                  isLoading = false;
                });
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Text('LOGIN'),
          ),
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
