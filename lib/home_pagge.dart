import 'package:fingerprint/last_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomePagge extends StatefulWidget {
  const HomePagge({super.key});

  @override
  State<HomePagge> createState() => _HomePaggeState();
}

class _HomePaggeState extends State<HomePagge> {
  final LocalAuthentication auth = LocalAuthentication();

  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);
    if (isAvailable) {
      bool result = await auth.authenticate(
          localizedReason: 'scan your fingerprint to proceed',
          options: AuthenticationOptions(biometricOnly: true));
      if (result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LastPage()));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext contex) {
              return AlertDialog(
                title: Text("Error Occured"),
                content: Text('Permission Denied'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            });
      }
    } else {
      print("No Biometric detected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 10),
              child: Text(
                "Use Your Fingerprint to authenticate\n                    yourself",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Text(
              "Before using the app",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(height: 100),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    )),
                child: Icon(
                  Icons.fingerprint_outlined,
                  size: 120,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
