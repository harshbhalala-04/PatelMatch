import 'package:chat/controllers/authController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthScreen extends GetWidget<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false, 
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                     
                      controller: _emailController,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Obx(() =>  (controller.isLoading.value) 
                        ? CircularProgressIndicator()
                        : (controller.isLogin.value) 
                          ? ElevatedButton(
                              onPressed: () => {
                                    controller.login(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim())
                                  },
                              child: Text('Login'))
                          : ElevatedButton(
                              child: Text('Sign Up'),
                              onPressed: () => {
                                controller.createUser(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim())
                              },
                            ),
                    ),
                    Obx(() => 
                      controller.isLoading.value 
                      ? Container() 
                      : TextButton(
                        child: Text(controller.isLogin.value
                            ? 'Create a new account'
                            : 'I already have an account'),
                        style: TextButton.styleFrom(primary: Colors.pink),
                        onPressed: () {
                          controller.toggleLoginStatus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
