import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:green_globe/src/presentations/views/auth/change_password.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/nav.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<void> _handleDeleteAccount(BuildContext context) async {
    final passwordController = TextEditingController();
    bool isDeleting = false;

    await showDialog(
      context: context,
      barrierDismissible: !isDeleting,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              contentTextStyle: CustomStyle.fourteen,
              titleTextStyle: CustomStyle.sixteen.copyWith(
                fontWeight: FontWeight.bold,
              ),
              title: const Text('Delete Account'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Are you sure you want to delete your account? This action cannot be undone.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    enabled: !isDeleting,
                    decoration: InputDecoration(
                      labelText: 'Enter Password to Confirm',
                      labelStyle: CustomStyle.twelve,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isDeleting
                      ? null
                      : () {
                          Navigator.of(ctx).pop();
                        },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: isDeleting
                      ? null
                      : () async {
                          setState(() {
                            isDeleting = true;
                          });
                          try {
                            await AuthService.deleteAccountViaEdgeFunction(
                              passwordController.text.trim(),
                            );
                            if (ctx.mounted) {
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Account deleted successfully.',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => const BottomNav(),
                                ),
                                (route) => false,
                              );
                            }
                          } on AuthException catch (e) {
                            setState(() {
                              isDeleting = false;
                            });
                            if (ctx.mounted) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } catch (e) {
                            setState(() {
                              isDeleting = false;
                            });
                            if (ctx.mounted) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Failed to delete account. Please try again.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                  child: isDeleting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid URL'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    try {
      if (!await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webViewConfiguration: const WebViewConfiguration(
          enableDomStorage: true,
          enableJavaScript: true,
        ),
      )) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch $url'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to open link.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleEmailFeedback() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@greenglobe.com',
      query: 'subject=Feedback&body=',
    );
    await _openUrl(emailUri.toString());
  }

  // Future<void> _handleShareApp() async {
  //   try {
  //     await Share.share(
  //       'Check out Green Globe - Waste Management for a Better World!',
  //       subject: 'Green Globe App',
  //     );
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Failed to share app.'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }

  // Future<void> _handleRateApp() async {
  //   // TODO: Implement rate app functionality with platform-specific URLs
  //   // const appStoreUrl = 'https://apps.apple.com/app/green-globe/id123456789';
  //   // const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.greenglobe.app';

  //   if (mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Rate app feature coming soon!')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'About Us',
              style: CustomStyle.twenty.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),

            // App Branding Section
            Center(
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/logo.png', width: 80, height: 80),
                    const SizedBox(height: 16),
                    Text(
                      'Green Globe',
                      style: CustomStyle.twenty.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Waste Management for a Better World!',
                      style: CustomStyle.fourteen.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // PREFERENCES Section
            Text(
              'SETTINGS',
              style: CustomStyle.fourteen.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Iconsax.password_check,
                      color: primaryGreen,
                      size: 24,
                    ),
                    title: Text('Change Password', style: CustomStyle.sixteen),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ChangePasswordPage()),
                      );
                    },
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                  ListTile(
                    leading: Icon(
                      Iconsax.profile_delete,
                      color: primaryGreen,
                      size: 24,
                    ),
                    title: Text(
                      'Delete Account',
                      style: CustomStyle.sixteen.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),

                    onTap: () async {
                      _handleDeleteAccount(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // CONTACT US Section
            Text(
              'CONTACT US',
              style: CustomStyle.fourteen.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Iconsax.message,
                      color: primaryGreen,
                      size: 24,
                    ),
                    title: Text('Email Feedback', style: CustomStyle.sixteen),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),
                    onTap: _handleEmailFeedback,
                  ),
                  // Divider(height: 1, color: Colors.grey.shade200),
                  // ListTile(
                  //   leading: Icon(Iconsax.share, color: primaryGreen, size: 24),
                  //   title: Text('Share App', style: CustomStyle.sixteen),
                  //   trailing: Icon(
                  //     Icons.chevron_right,
                  //     color: Colors.grey.shade400,
                  //   ),
                  //   // onTap: _handleShareApp,
                  // ),
                  // Divider(height: 1, color: Colors.grey.shade200),
                  // ListTile(
                  //   leading: Icon(Iconsax.star, color: primaryGreen, size: 24),
                  //   title: Text('Rate App', style: CustomStyle.sixteen),
                  //   trailing: Icon(
                  //     Icons.chevron_right,
                  //     color: Colors.grey.shade400,
                  //   ),
                  //   // onTap: _handleRateApp,
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // IMPORTANT Section
            Text(
              'IMPORTANT',
              style: CustomStyle.fourteen.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Iconsax.shield_tick,
                      color: primaryGreen,
                      size: 24,
                    ),
                    title: Text('Privacy Policy', style: CustomStyle.sixteen),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),
                    onTap: () => _openUrl(privacyPolicyUrl),
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                  ListTile(
                    leading: Icon(
                      Iconsax.document_text,
                      color: primaryGreen,
                      size: 24,
                    ),
                    title: Text('Terms of Service', style: CustomStyle.sixteen),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),
                    onTap: () => _openUrl(termsAndConditionsUrl),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
