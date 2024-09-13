import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {

  static Future<String> checkBalance(id,amount) async{
    var desiredAmount = int.parse(amount.toString());
    FirebaseFirestore store = FirebaseFirestore.instance;
   try{
     DocumentSnapshot userDoc = await store.collection("users").doc(id).get();
     if (userDoc.exists) {
       var balance = int.parse(userDoc.get("balance").toString());

       if (balance != 0 && desiredAmount > balance) {
         return "Payment Amount Should be less than or equal to available your balance";
       }
       else if (balance != 0 && desiredAmount < balance) {
         return "";
       }
     }
   }
   catch (e){
     print(e);
   }

    return "Insufficient Funds";
  }

}