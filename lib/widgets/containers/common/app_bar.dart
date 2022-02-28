import 'package:cached_network_image/cached_network_image.dart';
import 'package:credit_card/routes/signin.dart';
import 'package:credit_card/state/common/user_credential.dart';
import 'package:credit_card/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'blue_gradient_background.dart';
import 'custom_icon.dart';

class CustomAppBar extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  const CustomAppBar(
      {Key? key,
      required this.height,
      required this.title,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCredentialProvider provider =
        Provider.of<UserCredentialProvider>(context, listen: false);
    String? imageUrl = provider.userCredential!.user!.photoURL;
    double imageSize = height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(imageSize * 0.5),
          child: SizedBox(
              width: imageSize,
              height: imageSize,
              child: CachedNetworkImage(imageUrl: imageUrl!)),
        ),
        SizedBox(
          height: height * 0.55,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              title,
              style: GoogleFonts.sora(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        InkResponse(
          onTap: () => confirmSignout(context),
          child: Column(
            children: [
              Icon(
                Icons.logout,
                size: height * 0.7,
                color: MyTheme.darkBlue,
              ),
              SizedBox(
                child: Text(
                  "Sign out",
                  style: GoogleFonts.sora(color: MyTheme.darkBlue),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  confirmSignout(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: MyTheme.darkBlue,
            title:
                Text('Sign out', style: GoogleFonts.sora(color: Colors.white)),
            content: Text('Are you sure you want to sign out?',
                style: GoogleFonts.sora(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel',
                      style: GoogleFonts.sora(color: Colors.white))),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SigninRoute()),
                          ));
                },
                child: Text('Sign out',
                    style: GoogleFonts.sora(color: Colors.white)),
              )
            ],
          );
        });
  }
}
