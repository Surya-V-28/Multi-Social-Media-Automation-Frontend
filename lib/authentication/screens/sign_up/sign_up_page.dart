import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0,),
          child: Column(
            children: [
              Container(
                width: 256.0,
                height: 156.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.black,
                ),
              ),
        
              const SizedBox(height: 16.0),
        
              const Text('Own Your Social Feed, Anytime, Anywhere'),
        
              const SizedBox(height: 32.0),
        
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final url = Uri.parse('$_cognitoUrl/oauth2/authorize')
                      .replace(
                        queryParameters: {
                          'response_type': 'code',
                          'client_id': '53ltp6q8s0sugbgu9u0l16h8j2',
                          'redirect_uri': 'application://post_scheduler/auth/cognito/oauth-callback',
                          'identity_provider': 'Google',
                        },
                      );
                    await launchUrl(url);
                  }, 
                  style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.green)),
                  icon: const Icon(Icons.person),
                  label: const Text('Continue with Google'),
                ),
              ),
        
              const SizedBox(height: 8.0),
        
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final url = Uri.parse('$_cognitoUrl/oauth2/authorize')
                      .replace(
                        queryParameters: {
                          'response_type': 'code',
                          'client_id': '53ltp6q8s0sugbgu9u0l16h8j2',
                          'redirect_uri': 'application://post_scheduler/auth/cognito/oauth-callback',
                          'identity_provider': 'Facebook',
                        },
                      );
                    await launchUrl(url);
                  }, 
                  style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.blue)),
                  icon: const Icon(Icons.person),
                  label: const Text('Continue with Facebook'),
                ),
              ),

              const SizedBox(height: 16.0),
        
              const Divider(),
        
              const SizedBox(height: 16.0),
        
              const Text("Register or Sign In and we'll get started"),
        
              const SizedBox(height: 16.0),
        
              TextField(
                controller: _emailFieldController,
                onChanged: (value) => _emailFieldUpdatedStreamController.add(null),
                decoration: const InputDecoration(hintText: 'Enter Email'),
              ),
        
              const SizedBox(height: 32.0),

              SizedBox(
                width: double.infinity,
                child: _buildSubmitButton(),
              ),
        
              const SizedBox(height: 64.0),
        
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Already registered?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
        
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).push("/login");
                    }, 
                    child: const Text('Log In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    void onPressed() async {
      await GoRouter.of(context).push('/auth/sign-up/email', extra: { 'email': _emailFieldController.text });
    }

    return StreamBuilder(
      stream: _emailFieldUpdatedStreamController.stream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: (_emailFieldController.text != '') ? onPressed : null,
          child: const Text('Submit'),
        );
      }
    );
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    _emailFieldUpdatedStreamController.close();

    super.dispose();
  }

  final _emailFieldController = TextEditingController();
  final _emailFieldUpdatedStreamController = StreamController<void>();

  static const _cognitoUrl = 'https://rahil-post-scheduler-federated.auth.ap-south-1.amazoncognito.com';
}
