import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_fibkovka/pages/signup_page.dart';
import 'package:project_fibkovka/services/auth_service.dart';
import 'package:project_fibkovka/services/users.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'signin_page';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // FibKov
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("FibKof",
                  style: GoogleFonts.jacquesFrancoisShadow(
                    fontSize: 50,
                    color: Colors.white
                  ),),
                  Container(
                    color: Colors.white,
                    height: 2,
                    width: 300,
                  ),
                  const SizedBox(height: 10,),
                  const Text("Fibrabeton & Kofka",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white70
                    ),),
                ],
              )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: 450,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                        color: Colors.white
                      ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30,),
                        // Tizimga kirish
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0,3)
                              )
                            ],
                            color: Colors.white
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Tizimga kirish",
                              style: TextStyle(
                                fontSize: 25
                              ),),
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email'
                                ),
                              ),
                              const SizedBox(height: 15,),
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                    labelText: 'Password'
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25,),
                        ElevatedButton(
                            onPressed: (){
                              String email = emailController.text;
                              String password = passwordController.text;
                              authService.login(email: email,password: password, context: context);
                              },
                            child: const SizedBox(
                                height: 50,
                                width: 275,
                                child: Center(child: Text("Kirish",style: TextStyle(fontSize: 25),)))),
                        const SizedBox(height: 50,),
                        // SignUp navigator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Ro'yxatdan o'tmaganmisiz?",style: TextStyle(color: Colors.grey),),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushReplacementNamed(context, SignUpPage.id);
                                },
                                child: const Text("Ro'yxatdan o'ting",),)
                          ],
                        )
                      ],
                    ),
                    ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
