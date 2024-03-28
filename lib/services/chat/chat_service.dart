import 'package:chats/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {

  //prendre l'instance of firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//Affichage des utilisateurs
  Stream<List<Map<String, dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){

        // recherche d'un user
        final user = doc.data();
        return user;
      }).toList();
    });
  }

//Envoie de message
  Future<void> sendMessage(String receiverID, message) async{

    //Prendre des informations du users
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //Créer un nouveau message
    Message newMessage = Message(
      senderID: currentUserID, 
      senderEmail: currentUserEmail, 
      receiverID: receiverID, 
      message: message, 
      timestamp: timestamp);
    
    //construit des boite pour chaque message
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //ajouter le nouveau message à la base de donnée
    await _firestore
          .collection('chat_rooms')
          .doc(chatRoomID)
          .collection('messages')
          .add(newMessage.toMap());
  }
 //récupération de message
    Stream<QuerySnapshot> getMessages(String userID, otherUserID){

      List<String> ids = [userID, otherUserID];
      ids.sort();
      String chatRoomID = ids.join('_');
      return _firestore
              .collection('chat_rooms')
              .doc(chatRoomID)
              .collection('messages')
              .orderBy('timestamp', descending: false)
              .snapshots();
    }
}