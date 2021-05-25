import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:histutor/utils/authentication.dart';

import '../histutor.dart';
import '../mainboard.dart';

BuildContext context_;

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          height: 380.0,
          width: 540.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'HISTUTOR'
                  ),
                ),
              ),
              Container(
                child: Center(child: GoogleButton()),
                color: const Color(0X9BC7DA),
                padding: EdgeInsets.only(bottom: 50)
              ),
              // Container(
              //     child: Center(child: IconButton(
              //       icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
              //       onPressed: () => {
              //         signOutGoogle(),
              //       },
              //     ),),
              //     color: const Color(0X9BC7DA),
              //     padding: EdgeInsets.only(bottom: 50)
              // ),
            ],
          ),
        )
      ),
    );
  }
}

class GoogleButton extends StatefulWidget {
  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blueGrey, width: 3),
        ),
        color: Colors.white,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.blueGrey, width: 3),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          //print("PRessed!!");
          await signInWithGoogle(context).then((result) {
            print(result);
            // if(result == null){
            //
            //   //signOutGoogle();
            //   //FirebaseAuth.instance.signOut();
            // }
            if (result != null) {
              //Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(
                   // fullscreenDialog: true,
                    builder: (context) => mainboard(),
                  ),
              );
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //    // fullscreenDialog: true,
              //     builder: (context) => histutor(),
              //   ),
              // );
            }
          }).catchError((error) {
            print('Registration Error: $error');
          });
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Colors.blueGrey,
            ),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image(
              //   image: AssetImage("assets/images/google_logo.png"),
              //   height: 30.0,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Continue with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }




}

