import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';
import 'package:green_globe/src/presentations/views/auth/sign_in.dart';
import 'package:green_globe/src/presentations/views/menu/menu_page.dart';
import 'package:iconsax/iconsax.dart';

PreferredSizeWidget customAppBar(BuildContext context) {
  final ModalRoute<Object?>? parentRoute = ModalRoute.of(context);
  final bool canPop = parentRoute?.canPop ?? false;
  final bool isDrawerOpen = Scaffold.maybeOf(context)?.isDrawerOpen ?? canPop;
  // We consider "closed" to mean: drawer is NOT open and there's no back stack to pop
  final bool isclosed = !canPop && !isDrawerOpen;

  return AppBar(
    leading: IconButton(
      icon: isclosed ? Icon(Iconsax.menu_15) : Icon(Icons.close),
      onPressed: () {
        if (!isclosed) {
          Navigator.of(context).pop();
        } else {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: "Menu",
            barrierColor: Colors.black.withOpacity(0.3),
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) {
              return MenuPage();
              // return Align(
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              final offsetAnimation =
                  Tween<Offset>(
                    begin: Offset(-1, 0),
                    end: Offset(0, 0),
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  );
              return SlideTransition(position: offsetAnimation, child: child);
            },
          );
        }
      },
    ),
    title: Text(
      'GreenGlobe',
      style: CustomStyle.sixteen.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () {
          // Navigator.of(
          //   context,
          // ).push(MaterialPageRoute(builder: (_) => SignIn()));
          // // Add notification action here
        },
      ),
    ],
    backgroundColor: Colors.transparent,
    // elevation: 2,
    foregroundColor: Colors.black,
  );
}
