import 'package:chats/components/my_drawer.dart';
import 'package:chats/components/user_title.dart';
import 'package:chats/pages/chat_page.dart';
import 'package:chats/services/auth/auth_service.dart';
import 'package:chats/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Accueil"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUsersStream(), 
      builder: (context, snapshot) {
        //erreur
        if(snapshot.hasError){
            return const Text("erreur");
        }

        //Rechargement
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Chargement...");
        }

        return ListView(
          children: snapshot.data!
            .map<Widget>((userData) => _buildUserListItem(userData, context))
            .toList(),
        );
      },
      );
  }
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    
    if(userData["email"] != _authService.getCurrentUser()){
      return UserTitle(
        text: userData["email"],
        onTap: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => ChatPage(
              receiverEmail: userData["email"],
              receiverID : userData["uid"],
          ),
          ),
          );
        },
      );
    }else{
      return Container();
    }
  }
}