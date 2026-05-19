import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void _handIeLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    
    if(email.isEmpty || password.isEmpty) {
      _showSnackBar('Vui long nhap day du thong tin', Colors.red);
      return;
    }
    
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds:2));
    setState(() => _isLoading = false);

    if (email == 'tast@gmail.com' && password == '123456'){
      _showSnackBar('Dang nhap thanh cong', Colors.green);
    }

    else {
      _showSnackBar('Email hoac mat khau khong dung', Colors.red);
    }
  }

  void _handeleForgotPassword(){
    final resetController =  TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213e),
        title: const Text('Quen mat khau', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: resetController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Nhap email cua ban',
            hintStyle: TextStyle(color: Colors.grey.shade500),
            filled: true,
            fillColor: const Color(0xFF1a1a2e),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
          child: const Text('Huy', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSnackBar('Da gui link dat lai mat khau', Colors.green);
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4fc3f7)),
              child: const Text('Gui', style: TextStyle(color: Colors.black),)
          ),
        ],
      ),
    );
  }
  void _showSnackBar (String message, Color color){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: const Color(0xFF1a1a2e),
  body: SafeArea(
  child: Center(
  child: SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 28),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text ('Hoyo',
  style: TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  letterSpacing: 3,
  ),
  ),
  const SizedBox(height: 32),

  TextField(
  controller: _emailController,
  style: const TextStyle(color: Colors.white),
  decoration: InputDecoration(
  hintText: 'Email/Ten dang nhap',
  hintStyle: TextStyle(color: Colors.grey.shade500),
  prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
  filled: true,
  fillColor: const Color(0xFF16213E),
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide.none
  ),
  ),
  ),
  const SizedBox(height: 14),

  TextField(
  controller: _passwordController,
  obscureText: _obscurePassword,
  style: const TextStyle(color: Colors.white),
  decoration: InputDecoration(
  hintText: 'Mat khau',
  hintStyle: TextStyle(color: Colors.grey.shade500),
  prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
  suffixIcon: IconButton(
  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
  icon: Icon(
  _obscurePassword ? Icons.visibility_off : Icons.visibility,
  color: Colors.grey
  ),
  ),
  filled: true,
  fillColor: const Color(0xFF16213e),
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(80),
  borderSide: BorderSide.none, 
  ),
  ),
  ),
  const SizedBox(height: 8),
  
  
  Align(
  alignment: Alignment.centerRight,
  child: TextButton(
  onPressed: _handeleForgotPassword, 
  child: const Text('Quen mat khau', style: TextStyle(color: Colors.blueAccent),
  ),
  ),
  ),
  const SizedBox(height: 8),
  
  SizedBox(
  width: double.infinity,
  child: ElevatedButton(
  onPressed: _isLoading ? null: _handIeLogin,
  style: ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFF4fc3f7),
  foregroundColor: Colors.black,
  padding: const EdgeInsets.symmetric(vertical: 14),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8),
  ),
  ), 
  child: _isLoading
  ? const SizedBox(
  height: 20,
  width: 20,
  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
  )
  : const Text('Dang nhap',
  style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  ),
  ),
  ),
  const SizedBox(height: 16),
  
  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Chua co tai khoan?', style: TextStyle(color: Colors.grey.shade400)),
  TextButton(onPressed: () => _showSnackBar('Sang Dang Ky', Colors.blue),
  child: const Text('Dang ky', style: TextStyle(color: Colors.blueAccent),))
  ],
  ),
  ],
  ),
  ),
  ),
  ),
    );
  }
}
