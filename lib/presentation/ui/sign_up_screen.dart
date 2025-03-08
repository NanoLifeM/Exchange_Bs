import 'package:exchange_bs/data/userdata_object.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_source/response_model.dart';
import '../../data/models/user_model.dart';
import '../../logic/providers/is_obsecure_password_provider.dart';
import '../../logic/providers/user_data_provider.dart';
import 'main_wrapper.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late UserDataProvider userProvider;

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    userProvider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                        quarterTurns: 3,
                        child: Lottie.asset('images/bitcointouch.json',
                            fit: BoxFit.fill)),
                  ],
                ),
              ),
              Flexible(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 30,),
                      // Lottie.asset('images/bitcointouch.json',height: height * 0.3,fit: BoxFit.fill),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Sign Up',
                            style: GoogleFonts.ubuntu(
                                fontSize: screenSize.height * 0.035,
                                color: Theme.of(context).unselectedWidgetColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Create Account',
                            style: GoogleFonts.ubuntu(
                                fontSize: screenSize.height * 0.03,
                                color:
                                    Theme.of(context).unselectedWidgetColor)),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'Username',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                controller: nameController,
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter username';
                                  } else if (value.length < 4) {
                                    return 'at least enter 4 characters';
                                  } else if (value.length > 13) {
                                    return 'maximum character is 13';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenSize.height * 0.02,
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email_rounded),
                                  hintText: 'gmail',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter gmail';
                                  } else if (!value.endsWith('@gmail.com')) {
                                    return 'please enter valid gmail';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenSize.height * 0.02,
                              ),
                              Consumer<IsObsecurePasswordProvider>(
                                builder: (context, data, child) {
                                  return TextFormField(
                                    controller: passwordController,
                                    obscureText: data.isObsecure,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.lock_open),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          data.isObsecure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          Provider.of<IsObsecurePasswordProvider>(
                                                  context,
                                                  listen: false)
                                              .changeIsObsecure();
                                        },
                                      ),
                                      hintText: 'Password',
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      } else if (value.length < 7) {
                                        return 'at least enter 6 characters';
                                      } else if (value.length > 13) {
                                        return 'maximum character is 13';
                                      }
                                      return null;
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: screenSize.height * 0.01,
                              ),
                              Text(
                                'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                                style: GoogleFonts.ubuntu(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    height: 1.5),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: screenSize.height * 0.02,
                              ),
                              Consumer<UserDataProvider>(
                                  builder: (context, userDataProvider, child) {
                                switch (
                                    userDataProvider.registerStatus?.status) {
                                  case Status.LOADING:
                                    return const CircularProgressIndicator();
                                  case Status.COMPLETED:
                                    // savedLogin(userDataProvider.registerStatus?.data);
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) =>
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainWrapper())));
                                    return _signupBtn();
                                  case Status.ERROR:
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _signupBtn(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.error,
                                              color: Colors.redAccent,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              userDataProvider
                                                  .registerStatus!.message,
                                              style: GoogleFonts.ubuntu(
                                                  color: Colors.redAccent,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  default:
                                    return _signupBtn();
                                }
                              }),
                            ],
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.center,
                          child: Text('Already have an account?')),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.blue, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen()));
                            },
                            child: const Text('Login'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        /// screen size < 600
        else {
          return Column(
            children: [
              Lottie.asset("assets/json_file/waveloop.json",
                  height: screenSize.height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.fill),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Sign Up',
                    style: GoogleFonts.ubuntu(
                        fontSize: screenSize.height * 0.035,
                        color: Theme.of(context).unselectedWidgetColor,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Create Account',
                    style: GoogleFonts.ubuntu(
                        fontSize: screenSize.height * 0.03,
                        color: Theme.of(context).unselectedWidgetColor)),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          controller: nameController,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            } else if (value.length < 4) {
                              return 'at least enter 4 characters';
                            } else if (value.length > 13) {
                              return 'maximum character is 13';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            hintText: 'gmail',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter gmail';
                            } else if (!value.endsWith('@gmail.com')) {
                              return 'please enter valid gmail';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Consumer<IsObsecurePasswordProvider>(
                          builder: (context, data, child) {
                            return TextFormField(
                              controller: passwordController,
                              obscureText: data.isObsecure,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_open),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    data.isObsecure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    Provider.of<IsObsecurePasswordProvider>(
                                            context,
                                            listen: false)
                                        .changeIsObsecure();
                                  },
                                ),
                                hintText: 'Password',
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else if (value.length < 7) {
                                  return 'at least enter 6 characters';
                                } else if (value.length > 13) {
                                  return 'maximum character is 13';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        Text(
                          'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                          style: GoogleFonts.ubuntu(
                              fontSize: 15, color: Colors.grey, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Consumer<UserDataProvider>(
                            builder: (context, userDataProvider, child) {
                          switch (userDataProvider.registerStatus?.status) {
                            case Status.LOADING:
                              return const CircularProgressIndicator();
                            case Status.COMPLETED:

                              savedLogin(userDataProvider.registerStatus?.data);
                              WidgetsBinding.instance.addPostFrameCallback(
                                  (timeStamp) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainWrapper())));
                              return _signupBtn();
                            case Status.ERROR:
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _signupBtn(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: Colors.redAccent,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        userDataProvider
                                            .registerStatus!.message,
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.redAccent,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            default:
                              return _signupBtn();
                          }
                        }),
                      ],
                    )),
              ),
              const Expanded(
                child:  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('Already have an account?')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20.0, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen()));
                    },
                    child: const Text('Login'),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.03,)
            ],
          );
        }
      }),
    );
  }

  Widget _signupBtn() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            userProvider.callRegisterApi(nameController.text,
                emailController.text, passwordController.text);
          }
        },
        child: const Text('Sign Up'),
      ),
    );
  }

  Future<void> savedLogin(UserModel model) async {
    final prefs = await SharedPreferences.getInstance();
    UserDataObject.userName=nameController.text;
    UserDataObject.email=emailController.text;
    UserDataObject.password=passwordController.text;
    UserDataObject.token=model.token!;
    prefs.setString("user_token", model.token!);
    prefs.setString("user_name", nameController.text);
    prefs.setString("user_email", emailController.text);
    prefs.setString("user_password", passwordController.text);
    prefs.setBool("LoggedIn", true);
  }
}
