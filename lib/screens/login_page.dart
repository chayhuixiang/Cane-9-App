import 'package:cane_9_app/screens/root_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (buildCtx) => const RootPage()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/CANE-9 Logo 1.png'),
          const Text(
            "Welcome to the Cane-9 App",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
            ),
          ),
          const Text(
            "Log In",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: const Color(0XFFF9E3DC),
                  labelText: "Username",
                  hintText: "Enter Username"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Password",
                hintText: "Enter Password",
                filled: true,
                fillColor: const Color(0XFFF9E3DC),
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
        ],
      ),
    );
  }
}
