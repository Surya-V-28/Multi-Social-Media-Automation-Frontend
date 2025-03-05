import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:business_logic/business_logic.dart';

class EmailSignUpPage extends StatefulWidget {
  const EmailSignUpPage({super.key, required this.email});

  @override
  State<EmailSignUpPage> createState() => _EmailSignUpPageState();


  final String email;
}

class _EmailSignUpPageState extends State<EmailSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 64.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Create Account', style: theme.textTheme.headlineMedium,),

          const SizedBox(height: 8.0),

          const Text('Create your account to start scheduling your social media effortlessly', textAlign: TextAlign.center),

          const SizedBox(height: 32.0),

          TextField(
            controller: _usernameFieldController, 
            onChanged: (value) => _fieldsUpdatedStream.add(null),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Username'
            )
          ),
      
          const SizedBox(height: 16.0),
      
          TextField(
            controller: _passwordFieldController, 
            onChanged: (value) => _fieldsUpdatedStream.add(null),
            obscureText: _isPasswordObscured, 
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                icon: Icon((_isPasswordObscured) ? Icons.visibility : Icons.visibility_off),
              )
            ),
          ),
      
          const SizedBox(height: 32.0),
      
          SizedBox(
            width: double.infinity,
            child: _buildSignUpButton(),
          ),

          const SizedBox(height: 16.0),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: _agreedToTermsAndConditions, 
                onChanged: (value) {
                  setState(() => _agreedToTermsAndConditions = value!);
                  _fieldsUpdatedStream.add(null);
                },
              ),

              const Text('I agree with the Terms and Conditions'),
            ],
          ),

          const SizedBox(height: 32.0),

          Text('Already registered?', style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white)),
      
          TextButton(
            onPressed: () async {
              GoRouter.of(context).pushReplacement('/auth/login');
            },
            child: const Text('Login')
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    Future<void> onPressed() async {
      final email = widget.email;
      final username = _usernameFieldController.text;
      final password = _passwordFieldController.text;

      try {
        await _signUpInteractor.perform(email, username, password);
      }
      on Exception {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to sign up"))
        );

        return;
      }
      if (!mounted) return;

      try {
        await _loginInteractor.perform(email: email, password: password);
      }
        on Exception {
        if (!mounted) return;

        GoRouter.of(context).go('/auth/login');
        return;
      }

      if (!mounted) return;

      GoRouter.of(context).go('/calendar');
    }

    return StreamBuilder(
      stream: _fieldsUpdatedStream.stream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: (_usernameFieldController.text.isNotEmpty && _passwordFieldController.text.isNotEmpty && _agreedToTermsAndConditions) ? onPressed : null,
          child: const Text('Sign Up'),
        );
      }
    );

  }

  @override
  void dispose() {
    _usernameFieldController.dispose();
    _passwordFieldController.dispose();
    _fieldsUpdatedStream.close();

    super.dispose();
  }



  bool _isPasswordObscured = true;
  var _agreedToTermsAndConditions = false;

  final _fieldsUpdatedStream = StreamController<void>();

  final _usernameFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  final _signUpInteractor = GetIt.instance<EmailPasswordSignUpInteractor>();
  final _loginInteractor = GetIt.instance<EmailPasswordLoginInteractor>();
}
