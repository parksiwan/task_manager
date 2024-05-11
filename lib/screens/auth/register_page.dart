import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/widgets/tm_button.dart';
import 'package:task_manager/widgets/tm_textfield.dart';
import 'package:task_manager/screens/helper/helper_function.dart';
import 'package:task_manager/screens/helper/constants.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();
  String? dropdownTeamNameValue = "SCM-General";

  void register() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords amtch
    if (passwordController.text != confirmPwController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error message
      displayMessageToUser("Passwords don't match", context);
    } else {
      // try creating the user
      try {
        // create the user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        // pop loading circle
        Navigator.pop(context);
        // Get the user's UID
        String uid = userCredential.user!.uid;
        // Save additional user information to Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': userNameController.text,
          'email': emailController.text,
          'team': dropdownTeamNameValue,
        });
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);
        // display error message to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  void dropdownTeamNameCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownTeamNameValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),
              // app name
              const Text(
                "T A S K   M A N A G E R",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),
              // user name textfield
              TMTextField(
                hintText: "Username",
                obscureText: false,
                controller: userNameController,
              ),
              const SizedBox(height: 10),
              // email textfield
              TMTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              // password textfield
              TMTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              // forgot password
              const SizedBox(height: 10),
              // confirm assword textfield
              TMTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPwController,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                items: teamNames.map((map) {
                  return DropdownMenuItem<String>(
                    value: map['value'],
                    child: Text(map['name']),
                  );
                }).toList(),
                value: dropdownTeamNameValue,
                onChanged: dropdownTeamNameCallback,
                decoration: InputDecoration(
                  labelText: "Team",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                //dropdownColor: Theme.of(context).colorScheme.onBackground,
                //style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
              // forgot password
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // sign in buttom
              TMButton(
                text: "Register",
                onTap: register,
              ),
              const SizedBox(height: 25),
              // dont have a account ? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
