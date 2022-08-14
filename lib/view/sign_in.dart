import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/view/sign_up.dart';
import 'package:twitter/widgets/twitter_scaffold_messenger.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.4,
                      image: const AssetImage('assets/images/twitter_icon.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  child: Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.apply(color: Colors.black, fontWeightDelta: 3),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                _signUpTextField(context, emailController, 'Email', false),
                _signUpTextField(context, passwordController, 'Password', true),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: FloatingActionButton.extended(
                        elevation: 0,
                        onPressed: () {
                          _signIn();
                        },
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Theme.of(context).backgroundColor,
                        ),
                        label: Text(
                          'Sign In'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption?.apply(
                              color: Theme.of(context).backgroundColor,
                              fontWeightDelta: 3),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.apply(color: Colors.black, fontWeightDelta: 2),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          _sinUp();
                        },
                        child: Text(
                          "SIGN UP".toUpperCase(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.subtitle2?.apply(
                              color: Theme.of(context).primaryColor,
                              fontWeightDelta: 2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _signUpTextField(BuildContext context,
      TextEditingController controller, String hint, bool obscure) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    obscureText: obscure,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: Theme.of(context).textTheme.overline),
                    controller: controller,
                    textCapitalization: TextCapitalization.none,
                    textAlign: TextAlign.start,
                    onChanged: (var len) {
                      setState(() {
                        setState(() {});
                        // _productFilter(len);
                      });
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: Colors.lightBlueAccent,
            )));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      TwitterScaffoldMessenger().errorMsg(context, e.toString());
    }
    Navigator.pop(context);
  }

  void _sinUp() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUp()));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
