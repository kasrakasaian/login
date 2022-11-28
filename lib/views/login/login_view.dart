import 'package:badge/services/authentication_service.dart';
import 'package:badge/views/login/bloc/login_bloc.dart';
import 'package:badge/views/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameFieldController =
      TextEditingController();

  final TextEditingController _passwordFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          RepositoryProvider.of<AuthenticationService>(context))
        ..add(ServicesInitEvent()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessfulLoginState) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WelcomeView(username: state.username),
            ));
          }
          if (state is LoginInitialState) {
            if (state.error != null) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: Text(state.error!),
                      ));
            }
          }
        },
        builder: (context, state) {
          if (state is LoginInitialState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoginTitle(),
                TextFields(
                    usernameController: _usernameFieldController,
                    passController: _passwordFieldController),
                //const Forget(),
                Register(
                    usernameController: _usernameFieldController,
                    passController: _passwordFieldController)
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class LoginTitle extends StatelessWidget {
  const LoginTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: const Text(
        "Login",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passController;

  const TextFields(
      {Key? key,
      required this.usernameController,
      required this.passController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Container(
            height: 150,
            margin: const EdgeInsets.only(
              right: 70,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 32),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 20),
                      border: InputBorder.none,
                      icon: Icon(Icons.account_circle_rounded),
                      hintText: "Username",
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 32),
                  child: TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 22),
                      border: InputBorder.none,
                      icon: Icon(Icons.account_circle_rounded),
                      hintText: "Password",
                    ),
                  ),
                ),
              ],
            ),
          ),
          LoginButton(
            usernameController: usernameController,
            passController: passController,
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passController;

  const LoginButton(
      {Key? key,
      required this.usernameController,
      required this.passController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => BlocProvider.of<LoginBloc>(context).add(
            LoginButtonEvent(usernameController.text, passController.text)),
        child: Container(
          margin: const EdgeInsets.only(right: 15),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green[200]!.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff1bccba),
                Color(0xff22e2ab),
              ],
            ),
          ),
          child: const Icon(
            Icons.arrow_forward_outlined,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}

class Forget extends StatelessWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 16),
          child: Text(
            "Forgot ?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }
}

class Register extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passController;

  const Register(
      {Key? key,
      required this.usernameController,
      required this.passController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => BlocProvider.of<LoginBloc>(context)
            ..add(SignUpButtonEvent(
                usernameController.text, passController.text)),
          child: Container(
            margin: const EdgeInsets.only(left: 16, top: 24),
            child: const Text(
              "Register",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xffe98f60),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
