import 'package:flutter/material.dart';
import 'package:movie_app/services/user.dart';
import 'package:movie_app/widgets/alert.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/register_admin');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email harus diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: showPass,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          icon: Icon(
                            showPass ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          var data = {
                            "email": email.text,
                            "password": password.text,
                          };

                          try {
                            var result = await user.loginUser(data);
                            setState(() {
                              isLoading = false;
                            });

                            if (result.status == true) {
                              AlertMessage()
                                  .showAlert(context, result.message, true);
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.pushReplacementNamed(
                                    context, '/dashboard');
                              });
                            } else {
                              AlertMessage().showAlert(context,
                                  result.message, false);
                            }
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            AlertMessage().showAlert(
                                context, "Terjadi kesalahan: $e", false);
                          }
                        }
                      },
                      color: Colors.lightGreen,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text("LOGIN"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
