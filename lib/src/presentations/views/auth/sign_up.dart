import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/auth/sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Pass additional user data as a Map instead of a String per Supabase API
      await AuthService.signUp(
        email: email,
        password: password,
        data: {'full_name': name},
      );
      // Show success, navigate to sign in screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created! Please sign in.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => SignIn()));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              // Logo + App name
              Column(
                children: [
                  // Change asset path to your logo file
                  Image.asset('assets/icons/logo.png', height: 56),
                  const SizedBox(height: 12),
                  Text(
                    'GreenGlobe',
                    style: CustomStyle.sixteen.copyWith(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // "Sign Up" title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create Your Account',
                  style: CustomStyle.fourteen.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                controller: _nameController,
                hint: 'Full Name',
                icon: Iconsax.user,
              ),
              const SizedBox(height: 16),
              // Email field
              _buildTextField(
                controller: _emailController,
                hint: 'abc@email.com',
                icon: Iconsax.message,
              ),
              const SizedBox(height: 16),

              // Password field
              _buildTextField(
                controller: _passwordController,
                hint: 'Your password',
                icon: Iconsax.lock,
                obscureText: true,
                suffixIcon: Icons.visibility_outlined,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _confirmPasswordController,
                hint: 'Confirm password',
                icon: Iconsax.lock,
                obscureText: true,
                suffixIcon: Icons.visibility_outlined,
              ),
              const SizedBox(height: 16),

              // Sign Up button
              SizedBox(
                width: 300,
                height: kToolbarHeight,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 6,
                    shadowColor: primaryGreen.withOpacity(0.4),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('SIGN UP', style: CustomStyle.sixteenWhite),
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.white24,
                              radius: 20,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // OR divider
              Center(child: Text('OR', style: CustomStyle.fourteen)),
              const SizedBox(height: 24),

              // Google button
              _SocialButton(
                text: 'Login with Google',
                icon: FontAwesomeIcons.google,
                iconColor: const Color(0xFFDB4437),
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Facebook button
              _SocialButton(
                text: 'Login with Facebook',
                icon: FontAwesomeIcons.facebook,
                iconColor: const Color(0xFF1877F2),
                onTap: () {},
              ),
              const SizedBox(height: 32),

              // Bottom sign up text
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: CustomStyle.fourteen,
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: CustomStyle.fourteen.copyWith(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => SignIn()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    IconData? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFB0B0B0)),
        suffixIcon: suffixIcon == null
            ? null
            : Icon(suffixIcon, color: const Color(0xFFB0B0B0)),
        hintText: hint,
        hintStyle: CustomStyle.fourteen.copyWith(color: Color(0xFFB0B0B0)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: secondaryGreen, width: 1.4),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _SocialButton({
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: kToolbarHeight,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 3),
              blurRadius: 4,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Text(text, style: CustomStyle.fourteen),
          ],
        ),
      ),
    );
  }
}
