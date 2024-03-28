import 'package:chats/services/auth/auth_service.dart';
import 'package:chats/pages/settings.dart';
import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
 void logout(){
    final auth = AuthService();
    auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(

        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        children: [
              Column(
                children: [
                  DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text("A C C U E I L"),
                leading: const Icon(Icons.home),
                onTap: (){
                  Navigator.pop(context);
                },
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text("P A R A M È T R E S"),
                leading: const Icon(Icons.settings),
                onTap: (){
                   Navigator.pop(context);
                   Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
                },
                ),
              ),
                ],
              ),
              Padding(
              
              padding: const EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                title: const Text("D É C O N N E X I O N"),
                leading: const Icon(Icons.logout),
                onTap: logout,
                ),
              )
        ],
      ),
    );
  }
}