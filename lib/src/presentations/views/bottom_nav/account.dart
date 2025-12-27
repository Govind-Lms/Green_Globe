import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:green_globe/src/presentations/views/auth/change_password.dart';
import 'package:green_globe/src/presentations/views/auth/sign_in.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/nav.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  bool _checkedAuth = false;

  int get _binsNotified {
    if (_userData != null && _userData!['bins_notified'] != null) {
      return _userData!['bins_notified'] as int;
    }
    return 0;
  }

  int get _receivedPoints {
    if (_userData != null && _userData!['points_used'] != null) {
      return _userData!['points_used'] as int;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    _checkAuthAndFetch();
  }

  Future<void> _checkAuthAndFetch() async {
    final user = AuthService.getCurrentUser();
    if (user == null) {
      setState(() {
        _checkedAuth = false;
        _isLoading = false;
      });
      return;
    }
    await _fetchUserData();
    setState(() {
      _checkedAuth = true;
    });
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = AuthService.getCurrentUser();
      if (user != null) {
        final response = await Supabase.instance.client
            .from('users')
            .select()
            .eq('user_id', user.id)
            .maybeSingle();

        setState(() {
          _userData = response;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  int _calculateLevel(int points) {
    return (points ~/ 6000) + 1;
  }

  int _getPointsForCurrentLevel(int points) {
    return points % 6000;
  }

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await AuthService.signOut();
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const BottomNav()),
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error logging out: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

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
                            await AuthService.deleteAccount(
                              password: passwordController.text.trim(),
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
                                  builder: (_) => const SignIn(),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid URL'),
          backgroundColor: Colors.red,
        ),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to open link.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.getCurrentUser();
    if (!_checkedAuth && !_isLoading) {
      return const SignIn();
    }
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (user == null) {
      return const SizedBox.shrink();
    }

    final points = _userData?['points'] as int? ?? 0;
    final level = _calculateLevel(points);
    final currentLevelPoints = _getPointsForCurrentLevel(points);
    final profilePictureUrl =
        _userData?['profile_picture_url'] as String? ?? profilePictureUrls[0];

    String userName = 'User';
    if (user.userMetadata?['full_name'] != null) {
      userName = user.userMetadata?['full_name'] as String;
    } else if (_userData?['email'] != null &&
        _userData!['email'].toString().contains('@')) {
      userName = _userData!['email'].toString().split('@')[0];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: CustomStyle.twenty.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Profile Picture and Name
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: CachedNetworkImageProvider(
                    profilePictureUrl,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userName,
                  style: CustomStyle.twenty.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Level and Points
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$level',
                          style: CustomStyle.fourteenWhite.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Level $level',
                      style: CustomStyle.sixteen.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 24),
                    RichText(
                      text: TextSpan(
                        text: '$currentLevelPoints/',
                        style: CustomStyle.sixteen.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: '6000 Points',
                            style: CustomStyle.sixteen.copyWith(
                              color: primaryGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Info Cards
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.flash_on,
                    value: '$_binsNotified',
                    label: 'Notified',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoCard(
                    icon: Icons.scatter_plot,
                    value: '$_receivedPoints',
                    label: 'Points Used',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Settings Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SETTINGS',
                style: CustomStyle.fourteen.copyWith(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Settings Items
            _SettingsItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Notifications settings coming soon!'),
                //   ),
                // );
                // TODO: Navigate to notifications settings in the future
              },
            ),
            _SettingsItem(
              icon: Icons.language_outlined,
              title: 'Change Language',
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Language settings coming soon!'),
                //   ),
                // );
                // TODO: Navigate to language settings in the future
              },
            ),
            _SettingsItem(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              onTap: () => _openUrl(termsAndConditionsUrl),
            ),
            _SettingsItem(
              icon: Icons.lock_outline,
              title: 'Privacy Policy',
              onTap: () => _openUrl(privacyPolicyUrl),
            ),
            _SettingsItem(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('About section coming soon!')),
                // );
                // TODO: Navigate to about page in the future
              },
            ),
            _SettingsItem(
              icon: Iconsax.password_check,
              title: 'Change Password',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ChangePasswordPage()),
                );
              },
            ),
            _SettingsItem(
              icon: Iconsax.profile_delete,
              title: 'Delete Account',
              onTap: () {
                _handleDeleteAccount(context);
              },
            ),
            _SettingsItem(
              icon: Iconsax.logout,
              title: 'Sign Out',
              onTap: _handleLogout,
              isDestructive: true,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryGreen, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: CustomStyle.sixteen.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: CustomStyle.twelve.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: isDestructive ? Colors.red : Colors.black87,
          ),
          title: Text(
            title,
            style: CustomStyle.sixteen.copyWith(
              color: isDestructive ? Colors.red : Colors.black87,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }
}
