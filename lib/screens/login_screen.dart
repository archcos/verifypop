import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'home_screen.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernamenameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ListView(
                padding: const EdgeInsets.all(30),
                children: [
                  Image.asset(
                    "assets/logo1.png",
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text("Air Quality Detection System", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  const SizedBox(height: 25),
                  Text("Welcome!", style: const TextStyle(fontSize: 15, color: Colors.white, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Email",
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value){
                      return (value == '')? "Input Email" : null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.name,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      )
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        Map creds = {
                          'email': _emailController.text,
                          'password': _passwordController.text,
                          'device_name': 'mobile',
                        };
                        if (_formKey.currentState.validate()) {
                          try {
                            await Provider.of<Auth>(context, listen: false).login(creds: creds);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => HomeScreen())
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString()))
                            );
                          }
                        }
                      },
                      child: const Text("Sign In", style: TextStyle(color: Colors.black, fontSize: 17))
                  ),
                  TextButton(
                      onPressed: (){
                        RegisterPage();
                      },
                      child: const Text("Create Account")
                  )
                ]
            )
        )
    );
  }

  void RegisterPage() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Create Account'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _usernamenameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "Username"),
                    validator: (value){
                      return (value == '')? "Input Username" : null;
                    },
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "Full Name"),
                    validator: (value){
                      return (value == '')? "Input Full Name" : null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.name,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Password"),
                    validator: (value){
                      return (value == '')? "Input Password" : null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email Address"),
                    // validator: (value){
                    //   return (value == '')? "Input Email Address" : null;
                    // },
                  ),
                ],
              ),
            ),
          ),
          actions: [

            TextButton(
              onPressed: () async {
                Map creds = {
                  'username' : _usernamenameController.text,
                  'name' : _nameController.text,
                  'email': _emailController.text,
                  'password': _passwordController.text,
                  'device_name': 'mobile',
                };
                if (_formKey.currentState.validate()) {
                  bool emailValid = RegExp(
                      r"^[a-zA-Z\d.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(_emailController.text);
                  if (emailValid) {
                    String token = await Provider.of<Auth>(context, listen: false).register(creds: creds);
                    Navigator.of(context).push(VerifyPop()); // navigate back to login page
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid email address")),
                    );
                  }
                }
              },
              child: const Center(
                child: Text("Sign Up"),
              ),
            ),
          ],
        );
      },
    );
  }
  VerifyPop() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Verify Account'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email Address"),
                    // validator: (value){
                    //   return (value == '')? "Input Email Address" : null;
                    // },
                  ),
                ],
              ),
            ),
          ),
          actions: [

            TextButton(
              onPressed: () async {
                Map creds = {
                  'username' : _usernamenameController.text,
                  'name' : _nameController.text,
                  'email': _emailController.text,
                  'password': _passwordController.text,
                  'device_name': 'mobile',
                };
                if (_formKey.currentState.validate()) {
                  bool emailValid = RegExp(
                      r"^[a-zA-Z\d.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(_emailController.text);
                  if (emailValid) {
                    String token = await Provider.of<Auth>(context, listen: false).register(creds: creds);
                    Navigator.of(context).pop(); // navigate back to login page
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid email address")),
                    );
                  }
                }
              },
              child: const Center(
                child: Text("Verify"),
              ),
            ),
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: const Text("Back")
            )
          ],
        );
      },
    );
  }
}