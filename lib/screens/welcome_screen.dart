// ignore_for_file: prefer_const_constructors
import 'package:beauty/screens/regestration_screen.dart';
import 'package:beauty/screens/signin_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/mybuttom.dart';


class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
          backgroundColor:Color.fromARGB(255, 179, 97, 128),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Registration',style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 223, 198, 198))),
              SizedBox(width: 10),
              Container(
                  child:
                  Image.asset ("images/chat.png") ,
                  width: 25
              ),],),),
      backgroundColor: Color.fromARGB(255, 182, 175, 179),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  child: Image.asset('images/51599fafc9713efb92f342fa0774ba15-removebg-preview.png'),
                ),
                Text(
                  'MessageMe',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 179, 97, 128),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
           mybutton(
              color: Color.fromARGB(255, 179, 97, 128)!,
              title: 'Sign in', 
                  
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),
            mybutton(
              color: Color.fromARGB(255, 204, 148, 170)!,
              title: 'register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
