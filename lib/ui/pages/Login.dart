import 'package:f2k/blocs/authbloc/auth_bloc.dart';
import 'package:f2k/ui/pages/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthBloc _authBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(AppLoadingEvent());
  }

  Widget buildGoogleLogIn(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          FlutterLogo(
            size: 200.0,
          ),
          SizedBox(
            height: 80,
          ),
          SignInButton(
            Buttons.Google,
            onPressed: () {
              _authBloc.add(SignInEvent());
            },
            padding: EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: BlocBuilder(
          bloc: _authBloc,
          builder: (BuildContext context, AuthState state) {
            if (state is Unauthenticated) {
              return buildGoogleLogIn(context);
            } else if (state is Authenticated) {
              FirebaseUser user = state.user;
              return Home(user: user);
            } else if (state is AuthenticationFailure) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              );
            }
          },
        )),
      ),
    );
  }
}
