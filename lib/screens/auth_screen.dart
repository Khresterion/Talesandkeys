// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:talesandkeys/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

// class AddUser extends StatelessWidget {
//   final String fullName;
//   final String company;
//   final int age;

//   AddUser(this.fullName, this.company, this.age);

//   @override
//   Widget build(BuildContext context) {
//     // Create a CollectionReference called users that references the firestore collection
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     Future<void> addUser() {
//       // Call the user's CollectionReference to add a new user
//       return users
//           .add({
//             'full_name': fullName, // John Doe
//             'company': company, // Stokes and Sons
//             'age': age // 42
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     }

//     return TextButton(
//       onPressed: addUser,
//       child: Text(
//         "Add User",
//       ),
//     );
//   }
// }

// class GetUserName extends StatelessWidget {
//   final String documentId;

//   GetUserName(this.documentId);

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//         }

//         return Text("loading");
//       },
//     );
//   }
// }

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String pseudo,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('appuser')
            .add({'pseudo': pseudo, 'email': email});
        //     .setdata({
        //   'name': name,
        //   'email': email,
        // });
      }
    } on PlatformException catch (err) {
      String? message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
