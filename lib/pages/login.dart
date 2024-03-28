import 'package:chats/services/auth/auth_service.dart';
import 'package:chats/components/my_button.dart';
import 'package:chats/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Aller sur la page d'inscription
 final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

Future<void> login(BuildContext context) async {
  //Service 
  final authService = AuthService();

  try{
    await authService.signInWithEmailPassword(
      _emailController.text, 
      _passwordController.text
      );
  }
  catch(e){
    showDialog(
      // ignore: use_build_context_synchronously
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ),
      );
  }
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
            //Message de bienvenu
            Text("Welcome back, you've been missed",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                ),
            ),

            const SizedBox(height: 25),

            //champs d'email
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            //Champ mot de passe
            const SizedBox(height: 10),
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 10),
            //Button login
            MyButton(
              text : "Se connecter",
              onTap : ()=>login(context),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Not a member ?",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

              GestureDetector(
                onTap: onTap,
                child: Text("Inscrir-toi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary
                    ),
                ),
              )
              ],
            ),
            //Inscription
          ]
      ),
      ),
    );
  }
}