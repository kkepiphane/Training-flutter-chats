import 'package:chats/services/auth/auth_service.dart';
import 'package:chats/components/my_button.dart';
import 'package:chats/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmePasswordController = TextEditingController();
  
  final void Function()?onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context){
     final auth = AuthService();
     if(_passwordController.text == _confirmePasswordController.text){
        try{
            auth.signUpWithEmailPassword(
            _emailController.text, 
            _passwordController.text);
        } catch(e){
          showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
          );
        }
     }else{
      showDialog(
          context: context, 
          builder: (context) => const AlertDialog(
            title: Text("Mot de passe ne correspond"),
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
            Text("Let's create an account for you",
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

            //Confirmation mot de passe
             MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmePasswordController,
            ),
            const SizedBox(height: 10),
            //Button login
            MyButton(
              text : "S'inscrire",
              onTap : ()=>register(context),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Already have an account?",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

              GestureDetector(
                onTap: onTap,
                child: Text("Se connecter",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                      ),
                  ),
              ),
              ],
            ),
            //Inscription
          ]
      ),
      ),
    );
  }
}