import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/nav.dart';
import 'package:iconsax/iconsax.dart';

class ResetPasswordPage extends StatefulWidget {
  
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  String? _errorMessage;

  // For password field
  bool _showNewPassword = false;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    // _prepareFromUri(widget.initialUri);
  }

  // void _prepareFromUri(Uri uri) {
  //   final email = uri.queryParameters['email'];
  //   if (email != null && email.isNotEmpty) {
  //     _emailController.text = email;
  //   }
  // }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    const int minPasswordLength = 8;

    setState(() {
      _passwordError = null;
    });

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide email and new password')),
      );
      return;
    }

    if (password.length < minPasswordLength) {
      setState(() {
        _passwordError =
            'Password must be at least $minPasswordLength characters long';
      });
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      await AuthService.updatePassword(password: password);
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => BottomNav()));
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await AuthService.signOut();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => BottomNav()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reset Password',
            style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Iconsax.message,
                    color: Color(0xFFB0B0B0),
                  ),
                  hintText: 'abc@email.com',
                  hintStyle: CustomStyle.fourteen.copyWith(
                    color: const Color(0xFFB0B0B0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E5E5),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: primaryGreen,
                      width: 1.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: !_showNewPassword,
                onChanged: (val) {
                  setState(() {
                    if (val.length < 8) {
                      _passwordError =
                          'Password must be at least 8 characters long';
                    } else {
                      _passwordError = null;
                    }
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Iconsax.lock,
                    color: Color(0xFFB0B0B0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showNewPassword = !_showNewPassword;
                      });
                    },
                  ),
                  hintText: 'New Password',
                  hintStyle: CustomStyle.fourteen.copyWith(
                    color: const Color(0xFFB0B0B0),
                  ),
                  errorText: _passwordError,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E5E5),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: primaryGreen,
                      width: 1.4,
                    ),
                  ),
                ),
                // decoration: InputDecoration(
                //   labelText: "New Password",

                //   errorText: _passwordError,
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                // ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  fixedSize: Size(300, kToolbarHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('Reset Password', style: CustomStyle.fourteenWhite),
              ),
              const SizedBox(height: 12),
              if (_errorMessage != null) ...[
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () async {
                    final email = _emailController.text.trim();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter your email to resend reset link',
                          ),
                        ),
                      );
                      return;
                    }
                    try {
                      await AuthService.forgotPassword(
                        email: email,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Reset email resent. Check your inbox.',
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to resend: $e')),
                      );
                    }
                  },
                  child: const Text('Resend reset email'),
                ),
              ],
              const SizedBox(height: 8),
              // if (_token == null && _errorMessage == null)
              //   const Text(
              //     'The recovery link did not include a token. Make sure you used the link from the email.',
              //     style: TextStyle(color: Colors.red),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
