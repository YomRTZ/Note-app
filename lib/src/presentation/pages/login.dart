import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecommerc/src/data/model/user.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/login/login_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/login/login_state.dart';

import 'package:flutter_ecommerc/src/presentation/pages/view_post.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthStateSucess) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ViewPost()),
            (route) => false);
      }
      if (state is AuthStateFailure) {
        showLoginErrorDialog(context);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Image(
                    image: AssetImage('images/logo.png'),
                    width: 250,
                    height: 250,
                  ),
                  const Text(
                    "Welcome!",
                    style: TextStyle(fontSize: 25, color: Colors.red),
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(fontSize: 15),
                              suffixIcon: Icon(
                                Icons.email,
                                size: 24,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: passwordController,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              labelText: "password",
                              labelStyle: TextStyle(fontSize: 15),
                              suffixIcon: Icon(
                                Icons.password,
                                size: 24,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Users user = Users(
                                email: emailController.text,
                                password: passwordController.text);
                            BlocProvider.of<AuthBloc>(context)
                                .add(LoginEvent(user: user));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            backgroundColor:
                                const Color.fromARGB(255, 236, 104, 95),
                          ),
                          child: Text("Login"),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Center(
            child: Text(
              ("Login Error"),
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 230, 8, 8)),
            ),
          ),
          content: const Text(
              "Sorry,your Phone Number or Password is incorrect. please check and try again"),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
