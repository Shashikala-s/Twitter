import 'package:flutter/material.dart';
import 'package:twitter/services/twitter_firebase_client.dart';
import 'package:twitter/view/sign_in.dart';
import 'package:twitter/widgets/twitter_app_bar.dart';
import 'package:twitter/widgets/twitter_scaffold_messenger.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: TwitterAppBar(context, 'A', false),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.3,
                      image: const AssetImage('assets/images/twitter_icon.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "See what's \nhappening in the \nworld right now",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.apply(color: Colors.black, fontWeightDelta: 3),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                _signUpTextField(context, emailController, 'Email',false),
                _signUpTextField(context, passwordController, 'Password',true),
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
                          _signUp();
                        },
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Theme.of(context).backgroundColor,
                        ),
                        label: Text(
                          'Create account'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption?.apply(
                              color: Theme.of(context).backgroundColor,
                              fontWeightDelta: 3),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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
                          _login();
                        },
                        child: Text(
                          "SIGN IN".toUpperCase(),
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

  Padding _signUpTextField(
      BuildContext context, TextEditingController controller, String hint, bool obscure) {
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

  void _signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
            child: CircularProgressIndicator(color: Colors.lightBlueAccent,)));
    try {
      TwitterFirebaseClient()
          .createUser(emailController.text, passwordController.text,context);
    } catch (e) {
     TwitterScaffoldMessenger().errorMsg(context, e.toString());
    }
    Navigator.pop(context);

  }

  void _login() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
