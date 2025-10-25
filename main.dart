import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Main application entry point
void main() {
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: LoginPage(), // Start with login page
    );
  }
}

// Login page as a stateful widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// State class for login page
class _LoginPageState extends State<LoginPage> {
  // Controllers for text fields
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Build phone input field
  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'شماره تلفن',
        hintText: '۰۹۱۲۳۴۵۶۷۸۹',
        prefixIcon: const Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      // Phone number validation
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لطفا شماره تلفن را وارد کنید';
        }
        if (!RegExp(r'^09[0-9]{9}$').hasMatch(value)) {
          return 'شماره تلفن معتبر نیست (مثال: ۰۹۱۲۳۴۵۶۷۸۹)';
        }
        return null;
      },
    );
  }

  // Build password input field
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true, // Hide password text
      keyboardType: TextInputType.number,
      maxLength: 5, // Limit to 5 digits
      inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only numbers allowed
      decoration: InputDecoration(
        labelText: 'رمز عبور (۵ رقمی)',
        prefixIcon: const Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      // Password validation
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لطفا رمز عبور را وارد کنید';
        }
        if (value.length != 5) {
          return 'رمز عبور باید دقیقاً ۵ رقمی باشد';
        }
        return null;
      },
    );
  }

  // Build login button with custom size
  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: 160, // Fixed width for smaller button
      height: 50,  // Fixed height
      child: ElevatedButton(
        onPressed: () {
          // Validate form and navigate to home page
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  phoneNumber: _phoneController.text,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          elevation: 4, // Shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: const Text(
          'ورود',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                // Custom text instead of icon
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'برو ',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.green[400], // Light green color
                        ),
                      ),
                      TextSpan(
                        text: 'تو ',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.green[400], // Light green color
                        ),
                      ),
                      TextSpan(
                        text: 'کار',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.black, // Black color
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // App title
                Text(
                  'به برنامه ما خوش آمدید',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[800],
                  ),
                ),
                
                // Subtitle
                Text(
                  'لطفا اطلاعات خود را وارد کنید',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Input fields
                _buildPhoneField(), 
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 30),
                
                // Centered login button
                Center(
                  child: _buildLoginButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Clean up controllers when widget is disposed
  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Home page displayed after successful login
class HomePage extends StatelessWidget {
  final String phoneNumber;

  const HomePage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحه اصلی'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 24),
              
              // Success message
              const Text(
                'ورود موفقیت آمیز بود!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Display phone number
              Text(
                'شماره تلفن: $phoneNumber',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              
              // Back button
              Container(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'بازگشت',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
