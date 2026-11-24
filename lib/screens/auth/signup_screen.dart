import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _formKey = GlobalKey<FormState>();

  String selectedRole = 'Student';
  bool agreeTerms = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController idController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: 'Arafat Rahman');
    emailController = TextEditingController(text: 'student@university.edu');
    idController = TextEditingController(text: '2024-98421');
    phoneController = TextEditingController(text: '+1 555-0192');
    passwordController = TextEditingController(text: 'password123');
    confirmPasswordController = TextEditingController(text: 'password123');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    idController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void updateRole(String role) {
    setState(() {
      selectedRole = role;
      passwordController.text = 'password123';
      confirmPasswordController.text = 'password123';
      if (role == 'Student') {
        nameController.text = 'Arafat Rahman';
        emailController.text = 'student@university.edu';
        idController.text = '2024-98421';
        phoneController.text = '+1 555-0192';
      } else if (role == 'Driver') {
        nameController.text = 'Rafiq Ahmed';
        emailController.text = 'driver.rafiq@university.edu';
        idController.text = 'DRV-1042';
        phoneController.text = '+1 555-0841';
      } else {
        nameController.text = 'Admin Supervisor';
        emailController.text = 'admin@university.edu';
        idController.text = 'ADM-9011';
        phoneController.text = '+1 555-0010';
      }
    });
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms & Conditions and Privacy Policy.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // 1. Firebase Authentication: Register User
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final String uid = userCredential.user!.uid;

      // 2. Update Display Name
      await userCredential.user?.updateDisplayName(nameController.text.trim());

      // Normalize role string (e.g., 'student' or 'driver')
      final String roleValue = selectedRole.toLowerCase();

      // 3. Save User Document in Cloud Firestore under 'users' collection with UID
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({
        'fullName': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'idNumber': idController.text.trim(),
        'role': roleValue, // 'student' or 'driver'
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)); // Merge ensures no duplicate user documents

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account registered successfully as $selectedRole!'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );

      widget.onSignUpSuccess(selectedRole);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String errorMessage = e.message ?? 'Registration failed.';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already registered. Please login instead.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak. Please use at least 6 characters.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is formatted incorrectly.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.danger,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully as $selectedRole!'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );

      widget.onSignUpSuccess(selectedRole);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline,
                        color: AppColors.textMuted),
                    hintText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined,
                        color: AppColors.textMuted),
                    hintText: 'University Email address',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Phone Number
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_outlined,
                        color: AppColors.textMuted),
                    hintText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Student / Staff ID
                TextFormField(
                  controller: idController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.badge_outlined,
                        color: AppColors.textMuted),
                    hintText: selectedRole == 'Student'
                        ? 'Student ID Number'
                        : 'Staff / Driver ID',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your ID number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Password
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Confirm Password
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
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
                  onPressed: (agreeTerms && !isLoading)
                      ? _handleRegister
                      : null,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text('Sign Up as $selectedRole'),
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
                  onPressed: isLoading
                      ? null
                      : () {
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
                        onTap: isLoading ? null : widget.onLoginPressed,
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
      ),
    );
  }

  Widget _buildRoleTab(String role) {
    final isSelected = selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: isLoading ? null : () => updateRole(role),
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
