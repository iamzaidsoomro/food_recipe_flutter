import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBar extends StatelessWidget {
  const UserBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _userName = FirebaseAuth.instance.currentUser?.displayName;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hi ${_userName},',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(height: 10),
                    const Text(
                      'Search delicious food recipes',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 124, 124, 124)),
                      softWrap: true,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
