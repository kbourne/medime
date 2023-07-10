import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../custom_route.dart';
import '../dashboard_screen.dart';
import '../../models/muser.dart';
import '../../users.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/auth';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _userEmail = '';
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  bool _emailVerified = false;
  late Muser _muser; /// PROVIDER

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {

    });
  }

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'User not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {

    _muser = Provider.of<Muser>(context, listen: false);

    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: Constants.appName,
      logo: const AssetImage('assets/images/gvlogo.png'),
      initialAuthMode: AuthMode.signup,
      hideForgotPasswordButton: false,
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      savedEmail: _muser.email ?? '',
      savedPassword: '',
      navigateBackAfterRecovery: true,
      // onConfirmRecover: _signupConfirm,
      // onConfirmSignup: _signupConfirm,
      loginAfterSignUp: true,
      // loginProviders: [
      //   LoginProvider(
      //     button: Buttons.linkedIn,
      //     label: 'Sign in with LinkedIn',
      //     callback: () async {
      //       return null;
      //     },
      //     providerNeedsSignUpCallback: () {
      //       // put here your logic to conditionally show the additional fields
      //       return Future.value(true);
      //     },
      //   ),
      //   LoginProvider(
      //     icon: FontAwesomeIcons.google,
      //     label: 'Google',
      //     callback: () async {
      //       return null;
      //     },
      //   ),
      //   LoginProvider(
      //     icon: FontAwesomeIcons.githubAlt,
      //     callback: () async {
      //       debugPrint('start github sign in');
      //       await Future.delayed(loginTime);
      //       debugPrint('stop github sign in');
      //       return null;
      //     },
      //   ),
      // ],
      termsOfService: [
        // TermOfService(
        //   id: 'newsletter',
        //   mandatory: false,
        //   text: 'Newsletter subscription',
        // ),
        TermOfService(
          id: 'general-term',
          mandatory: true,
          text: 'Term of services',
          linkUrl: 'https://gradientvalley.com/termsofservice.html',
        ),
      ],
      additionalSignupFields: [
        const UserFormField(
          keyName: 'Username',
          icon: Icon(FontAwesomeIcons.userLarge),
        ),
        const UserFormField(keyName: 'Name'),
        const UserFormField(keyName: 'Surname'),
        UserFormField(
          keyName: 'phone_number',
          displayName: 'Phone Number',
          userType: LoginUserType.phone,
          fieldValidator: (value) {
            final phoneRegExp = RegExp(
              '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
            );
            if (value != null &&
                value.length < 7 &&
                !phoneRegExp.hasMatch(value)) {
              return "This isn't a valid phone number";
            }
            return null;
          },
        ),
      ],
      scrollable: true,
      hideProvidersTitle: false,
      // loginAfterSignUp: false,
      // hideForgotPasswordButton: true,
      // hideSignUpButton: true,
      disableCustomPageTransformer: true,
      messages: LoginMessages(
        userHint: 'Email',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm password',
        loginButton: 'LOG IN',
        signupButton: 'SIGN UP',
        forgotPasswordButton: 'Forgot password?',
        recoverPasswordButton: 'SEND TO ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'The password does not match!',
        recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
        recoverPasswordDescription: 'Just enter your email and if we have it, we will send you a link to reset your password!',
        recoverPasswordSuccess: 'Password rescued successfully',
        flushbarTitleError: '😬 Oh, oh, something went wrong...',
        flushbarTitleSuccess: 'Get ready to upgrade your Data Science knowledge!',
        providersTitleFirst: ' Sign in/up with:\n  Social Sign-in!\nCurrent Providers:',
        providersTitleSecond: 'OR',
      ),
      theme: LoginTheme(
        primaryColor: Colors.blue.shade900,
        accentColor: Colors.white,
        errorColor: Colors.deepOrange,
        pageColorLight: Colors.indigo.shade300,
        pageColorDark: Colors.indigo.shade500,
        logoWidth: 0.80,
        titleStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontFamily: 'Quicksand',
          letterSpacing: 2,
        ),
        beforeHeroFontSize: 28,
        afterHeroFontSize: 20,
        bodyStyle: const TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
        textFieldStyle: const TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.black,
          shadows: [Shadow(color: Colors.grey, blurRadius: 2)],
        ),
        buttonStyle: const TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 8,
          margin: const EdgeInsets.only(top: 8),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade500,
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.redAccent.shade100, // Colors.white,
          ),
          // labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.red,
          backgroundColor: Colors.purple.shade700,
          highlightColor: Colors.purpleAccent.shade700,
          elevation: 4.0,
          highlightElevation: 2.0,
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(52.0)),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
      userValidator: (value) {
        _userEmail = value ?? '';
        // if (!value!.contains('@') || !value.endsWith('.com')) {
        //   return "Email must contain '@' and end with '.com'";
        // }
        if (!EmailValidator.validate(value!)) {
          return "Sorry, but that email doesn't seem to work. Try again?";
        }

        return null;

      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        debugPrint('Login info');
        debugPrint('Name: ${loginData.name}');
        debugPrint('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (signupData) {
        debugPrint('Signup info');
        debugPrint('Name: ${signupData.name}');
        debugPrint('Password: ${signupData.password}');

        _userEmail = signupData.name ?? '';
        signupData.additionalSignupData?.forEach((key, value) {
          debugPrint('$key: $value');
        });
        if (signupData.termsOfService.isNotEmpty) {
          debugPrint('Terms of service: ');
          for (final element in signupData.termsOfService) {
            debugPrint(
              ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}',
            );
          }
        }
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      },
      onRecoverPassword: (name) {
        debugPrint('Recover password info');
        debugPrint('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      // headerWidget: const IntroWidget(),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "You are trying to login/sign up on server hosted on ",
              ),
              TextSpan(
                text: "example.com",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          textAlign: TextAlign.justify,
        ),
        Row(
          children: const <Widget>[
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Authenticate"),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}