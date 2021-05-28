import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:histutor/utils/authentication.dart';

import '../HISTUTOR_.dart';
import '../histutor.dart';

BuildContext context_;

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff9BC7DA),
      body: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: SingleChildScrollView(
            child: Container(
                height: 558.0,
                width: 385.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 540.0,
                      width: 368.0,
                      decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment(0.0, 0.0),
                            width:223,
                            height: 92,
                            child: Text("HISTUTOR",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  fontFamily: 'MontserratSubrayada'),),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 11)),
                          Container(

                            alignment: Alignment(0.0, 0.0),
                            height: 74,
                            width: 311,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/g.png',
                                  width:32,
                                  height: 31,),
                                Padding(padding:const EdgeInsets.only(right : 15) ),
                                GoogleButton(),
                              ],
                            ),
                            //padding: EdgeInsets.only(bottom: 50)
                            decoration: BoxDecoration(
                              color: const Color(0xffF4CACA),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                )



            )
        ),
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
          side: BorderSide(color: Color(0xffF4CACA), width: 45),
        ),
        color: Color(0xffF4CACA),
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Color(0xffF4CACA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color(0xffF4CACA), width: 45),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          await signInWithGoogle(context).then((result) {
            print(result);
            if (result != null) {
              //Navigator.of(context).pop();
              Navigator.push(context,
                MaterialPageRoute(
                  // fullscreenDialog: true,
                  builder: (context) => HISTUTOR(),
                ),
              );
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
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Quicksand')
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
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

