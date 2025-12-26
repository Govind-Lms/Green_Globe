import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/auth/sign_up.dart';
import 'package:green_globe/src/presentations/views/auth/forget_password.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/nav.dart';
import 'package:iconsax/iconsax.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool rememberMe = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.signIn(email: email, password: password);

      // You can navigate to the home/dashboard screen here
      // For now, just show success
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => BottomNav()));
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
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
      // appBar: AppBar(),
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

              // "Sign in" title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign In',
                  style: CustomStyle.fourteen.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Email field
              _buildTextField(
                inputType: TextInputType.emailAddress,
                controller: _emailController,
                hint: 'abc@email.com',
                icon: Iconsax.message,
              ),
              const SizedBox(height: 16),

              // Password field
              _buildTextField(
                inputType: TextInputType.visiblePassword,
                controller: _passwordController,
                hint: 'Your password',
                icon: Iconsax.lock,
                obscureText: true,
                suffixIcon: Icons.visibility_outlined,
              ),
              const SizedBox(height: 16),

              // Remember me + Forgot password
              Row(
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: rememberMe,
                      activeThumbColor: primaryGreen,
                      onChanged: (val) {
                        setState(() => rememberMe = val);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('Remember Me', style: CustomStyle.fourteen),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ForgetPasswordPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: CustomStyle.fourteen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sign in button
              SizedBox(
                width: 300,
                height: kToolbarHeight,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignIn,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'SIGN IN',
                                style: CustomStyle.sixteenWhite,
                              ),
                            ),
                            SizedBox(width: 10),
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
                  text: "Don't have an account? ",
                  style: CustomStyle.fourteen,
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: CustomStyle.fourteen.copyWith(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => SignUp()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextInputType inputType,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    IconData? suffixIcon,
  }) {
    return TextField(
      keyboardType: inputType,
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
