// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../services/auth.dart';
// import 'verifyEmail_screen.dart';
//
// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     _nameController.text = '';
//     _emailController.text = '';
//     _passwordController.text = '';
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 validator: (value) =>
//                 value?.isEmpty ?? true ? 'Please enter your name' : null,
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _emailController,
//                 validator: (value) =>
//                 value?.isEmpty ?? true ? 'Please enter a valid email' : null,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 validator: (value) =>
//                 value?.isEmpty == true ? 'Please enter a password' : null,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Map creds = {
//                     'name' : _nameController.text,
//                     'email': _emailController.text,
//                     'password': _passwordController.text,
//                     'device_name': 'mobile',
//                   };
//                   if (_formKey.currentState.validate()) {
//                     Provider.of<Auth>(context, listen: false).register(creds: creds);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => EmailOtpPage()),
//                     );
//                   }
//                 },
//                 child: Text('Register'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
