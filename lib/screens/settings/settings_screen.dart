import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/config/Routes/RouteName.dart';
import '../../app_localization/language/language_bloc.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _profileController;
  late AnimationController _accountController;
  late AnimationController _aboutController;
  late AnimationController _logoutController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _profileController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _accountController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _aboutController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _logoutController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start animations after a small delay to ensure widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
        // Start staggered animations
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) _profileController.forward();
        });
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) _accountController.forward();
        });
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) _aboutController.forward();
        });
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) _logoutController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _profileController.dispose();
    _accountController.dispose();
    _aboutController.dispose();
    _logoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Profile Section with animation
                AnimatedBuilder(
                  animation: _profileController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - _profileController.value)),
                      child: Opacity(
                        opacity: _profileController.value,
                        child: Transform.scale(
                          scale: 0.8 + (0.2 * _profileController.value),
                          child: _buildProfileSection(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                
                // Account Section with animation
                AnimatedBuilder(
                  animation: _accountController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - _accountController.value)),
                      child: Opacity(
                        opacity: _accountController.value,
                        child: _buildAccountSection(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                
                // About Section with animation
                AnimatedBuilder(
                  animation: _aboutController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - _aboutController.value)),
                      child: Opacity(
                        opacity: _aboutController.value,
                        child: _buildAboutSection(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                
                // Logout Button with animation
                AnimatedBuilder(
                  animation: _logoutController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - _logoutController.value)),
                      child: Opacity(
                        opacity: _logoutController.value,
                        child: _buildLogoutButton(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000), // light shadow
            blurRadius: 2,
            // spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteName.Profile);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              backgroundImage: const AssetImage('assets/image/user-profile-pic.jpg'),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pratik Patil',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '+91 98765 43210',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'ACCOUNT',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildListTile(
                  icon: Icons.person_outline,
                  title: 'Personal Information',
                  onTap: () {
                    // Navigate to personal information
                  },
                ),
                _buildDivider(),
                BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, state) {
                    if (state is LanguageLoaded) {
                      return _buildListTile(
                        icon: Icons.language_outlined,
                        title: 'Language',
                        subtitle: _getLanguageName(state.locale.languageCode),
                        onTap: () => _showLanguageDialog(context, state.locale),
                      );
                    }
                    return _buildListTile(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'ABOUT',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildListTile(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    // Navigate to help & support
                  },
                ),
                _buildDivider(),
                _buildListTile(
                  icon: Icons.description_outlined,
                  title: 'Terms & Privacy Policy',
                  onTap: () {
                    // Navigate to terms & privacy
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: OutlinedButton(
          onPressed: () {
            // Add haptic feedback
            // HapticFeedback.mediumImpact();
            // Handle logout
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 20,
                  key: ValueKey('logout_icon'),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: Icon(
            icon,
            color: Colors.grey[700],
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              )
            : null,
        trailing: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[600],
          ),
        ),
        onTap: () {
          // Add haptic feedback
          // HapticFeedback.lightImpact();
          onTap();
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: 20,
      endIndent: 20,
      color: Colors.grey[200],
    );
  }

  void _showLanguageDialog(BuildContext context, Locale currentLocale) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: animation,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 20,
                        spreadRadius: 2,
                        color: Colors.black12,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// Title
                      Text(
                        AppLocalizations.of(context)!.selectLanguage,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// English
                      _languageTile(
                        context,
                        title: AppLocalizations.of(context)!.english,
                        icon: Icons.language,
                        selected: currentLocale.languageCode == 'en',
                        onTap: () {
                          context.read<LanguageBloc>().add(
                            LanguageChanged(const Locale('en')),
                          );
                          Navigator.pop(context);
                        },
                      ),

                      const SizedBox(height: 12),

                      /// Hindi
                      _languageTile(
                        context,
                        title: AppLocalizations.of(context)!.hindi,
                        icon: Icons.translate,
                        selected: currentLocale.languageCode == 'hi',
                        onTap: () {
                          context.read<LanguageBloc>().add(
                            LanguageChanged(const Locale('hi')),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _languageTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required bool selected,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? const Color(0xFFE7FCEE) : Colors.grey.shade100,
          border: Border.all(
            color: selected ? Colors.green : Colors.transparent,
          ),
        ),
        child: Row(
          children: [

            Icon(icon, color: Colors.black54),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: selected
                  ? const Icon(
                Icons.check_circle,
                color: Colors.green,
                key: ValueKey('check'),
              )
                  : const SizedBox(key: ValueKey('empty')),
            )
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिंदी';
      default:
        return languageCode;
    }
  }
}
