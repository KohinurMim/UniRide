import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SignupScreen extends StatefulWidget {
  final Function(String role) onSignUpSuccess;
  final VoidCallback onLoginPressed;

  const SignupScreen({
    super.key,
    required this.onSignUpSuccess,
    required this.onLoginPressed,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String selectedRole = 'Student';
  bool agreeTerms = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final TextEditingController nameController =
      TextEditingController(text: 'Arafat Rahman');
  final TextEditingController emailController =
      TextEditingController(text: 'arafat@university.edu');
  final TextEditingController idController =
      TextEditingController(text: '2024-98421');
  final TextEditingController passwordController =
      TextEditingController(text: '••••••••');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '••••••••');

  void updateRole(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Logo & Title
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.directions_bus_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'UniRide',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'Join UniRide to track your campus ride',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              // Role Selector Segmented Control
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _buildRoleTab('Student'),
                    _buildRoleTab('Driver'),
                    _buildRoleTab('Admin'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Full Name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline,
                      color: AppColors.textMuted),
                  hintText: 'Full Name',
                ),
              ),
              const SizedBox(height: 12),

              // Email
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined,
                      color: AppColors.textMuted),
                  hintText: 'University Email address',
                ),
              ),
              const SizedBox(height: 12),

              // Student / Staff ID
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.badge_outlined,
                      color: AppColors.textMuted),
                  hintText: selectedRole == 'Student'
                      ? 'Student ID Number'
                      : 'Staff / Driver ID',
                ),
              ),
              const SizedBox(height: 12),

              // Password
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: AppColors.textMuted),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 12),

              // Confirm Password
              TextField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_clock_outlined,
                      color: AppColors.textMuted),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                  hintText: 'Confirm Password',
                ),
              ),

              const SizedBox(height: 12),

              // Terms Agreement Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: agreeTerms,
                      activeColor: AppColors.primary,
                      onChanged: (val) {
                        setState(() {
                          agreeTerms = val ?? true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'I agree to the Terms & Conditions and Privacy Policy',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Sign Up Button
              ElevatedButton(
                onPressed: agreeTerms
                    ? () {
                        widget.onSignUpSuccess(selectedRole);
                      }
                    : null,
                child: Text('Sign Up as $selectedRole'),
              ),

              const SizedBox(height: 16),

              // "or" Divider
              const Row(
                children: [
                  Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.border)),
                ],
              ),

              const SizedBox(height: 16),

              // Google Sign Up Button
              OutlinedButton.icon(
                onPressed: () {
                  widget.onSignUpSuccess(selectedRole);
                },
                icon: const Icon(Icons.g_mobiledata, size: 28),
                label: const Text('Sign Up with Google'),
              ),

              const SizedBox(height: 20),

              // Log In Footer Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: widget.onLoginPressed,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleTab(String role) {
    final isSelected = selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => updateRole(role),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Text(
            role,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}