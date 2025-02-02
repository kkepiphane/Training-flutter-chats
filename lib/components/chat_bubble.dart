import 'package:chats/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key, 
    required this.message, 
    required this.isCurrentUser
    });

  @override
  Widget build(BuildContext context) {
    // ligth vs dark
    bool isDarkMode = 
         Provider.of<ThemeProvider>(context, listen: false).idDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? (isDarkMode 
        ? Colors.black : Colors.grey.shade500) 
        :(isDarkMode ? Colors.grey.shade800 : Colors.black),
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
            ? Colors.white
            : (isDarkMode ? Colors.white : Colors.white)
                  ),
      ),
    );
  }
}