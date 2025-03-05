import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:common/common.dart';
import 'package:business_logic/business_logic.dart';

import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Welcome Back', style: theme.textTheme.headlineLarge!.copyWith(color: Colors.white)),
              ),
            ),
          ),
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(controller: _emailFieldController, decoration: const InputDecoration(hintText: 'Email')),
          
              const SizedBox(height: 16.0),
          
              TextField(
                controller: _passwordFieldController, 
                obscureText: _isPasswordObscured, 
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                    icon: Icon((_isPasswordObscured) ? Icons.visibility : Icons.visibility_off),
                  )
                ),
              ),
          
              const SizedBox(height: 8.0),
          
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text('Forgot Password?')),
              ),
          
              const SizedBox(height: 16.0),
          
              ElevatedButton(
                onPressed: () async {
                  final email = _emailFieldController.text;
                  final password = _passwordFieldController.text;

                  await _loginInteractor.perform(email: email, password: password);
                  if (!mounted) return;
          
                  GoRouter.of(context).go('/calendar');
                },
                child: const Text('Login'),
              ),
          
              const SizedBox(height: 8.0),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      final url = Uri.parse('$_cognitoUrl/oauth2/authorize')
                        .replace(
                          queryParameters: {
                            'response_type': 'code',
                            'client_id': ApplicationProperties.aws.cognito.clientId,
                            'redirect_uri': ApplicationProperties.aws.cognito.redirectUri,
                            'identity_provider': 'Facebook',
                          },
                        );
                      await launchUrl(url);
                    },
                    icon: const SizedBox.square(
                      dimension: 24.0,
                      child: Image(
                        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/1024px-2021_Facebook_icon.svg.png'),
                      ),
                    ),
                  ),
          
                  IconButton(
                    onPressed: () async {
                      final url = Uri.parse('$_cognitoUrl/oauth2/authorize')
                        .replace(
                          queryParameters: {
                            'response_type': 'code',
                            'client_id': ApplicationProperties.aws.cognito.clientId,
                            'redirect_uri':ApplicationProperties.aws.cognito.redirectUri,
                            'identity_provider': 'Google',
                          },
                        );
                      await launchUrl(url);
                    },
                    icon: const SizedBox.square(
                      dimension: 24.0,
                      child: Image(
                        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_"G"_logo.svg/1024px-Google_"G"_logo.svg.png'),
                      ),
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 16.0),
          
              const Row(
                children: <Widget>[
                  Expanded(child: Divider()),
          
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR'),
                  ),
          
                  Expanded(child: Divider()),
                ]
              ),
          
              const SizedBox(height: 16.0),
          
              OutlinedButton(
                onPressed: () async {
                  GoRouter.of(context).go('/auth/sign-up');
                },
                child: const Text('Sign Up')
              ),
            ],
          ),
        ],
      ),
    );
  }


  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController = TextEditingController();

  bool _isPasswordObscured = true;

  final _loginInteractor = GetIt.instance<EmailPasswordLoginInteractor>();


  static final _cognitoUrl = ApplicationProperties.aws.cognito.cognitoUri;
}
