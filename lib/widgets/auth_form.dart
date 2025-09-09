import 'package:chat/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthForm extends GetWidget<AuthController> {
  AuthForm(this.submitFn, this.isLoading, this.logInFn);

  final bool isLoading;
  final Future<void> Function(
      String email,
      String password,
      bool isLogin,
      BuildContext ctx) submitFn;
  final Future<void> Function(String email, String password) logInFn;


  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  dynamic _userEmail = '';

  dynamic _userPassword;

  ///Form validation and save
  _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState?.save();
      submitFn(
        _userEmail?.trim(),
        _userPassword?.trim(),
        _isLogin,
        context,
      );
    }
  }

  logInFunction(BuildContext context) {
   
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState?.save();
      logInFn(_userEmail?.trim(), _userPassword?.trim());
    }
  }

  //Form Widget

  @override
  Widget build(BuildContext context) {
    return new Builder(
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: ValueKey('email'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value?.isEmpty == null || !value!.contains('@')) {
                            return 'Please Enter valid Email Address.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                        ),
                        onSaved: (value) {
                          _userEmail = value;
                        },
                      ),
                      TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value?.isEmpty == null || value!.length < 7) {
                              return 'Password must be atleast 7 characters long';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          onSaved: (value) {
                            _userPassword = value;
                          }),
                      SizedBox(
                        height: 12,
                      ),
                      if (isLoading) CircularProgressIndicator(),
                      if (!isLoading)
                        _isLogin
                            ? ElevatedButton(
                                onPressed: () => {logInFunction(context)}, child: Text('Login'))
                            : ElevatedButton(
                                child: Text('Sign Up'),
                                onPressed: () => {_trySubmit(context)},
                              ),
                      if (!isLoading)
                        TextButton(
                          child: Text(_isLogin
                              ? 'Create a new account'
                              : 'I already have an account'),
                          style: TextButton.styleFrom(backgroundColor: Colors.pink),
                          onPressed: () {
                            _isLogin = !_isLogin;
                            
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
