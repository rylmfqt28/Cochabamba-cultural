import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/user/ui/widgets/home_tab.dart';
import 'package:cochabambacultural/user/ui/widgets/search_event_tab.dart';
import 'package:cochabambacultural/user/ui/widgets/create_event_tab.dart';
import 'package:cochabambacultural/user/ui/widgets/favorites_event_tab.dart';
import 'package:cochabambacultural/user/ui/widgets/user_profile_tab.dart';

import 'package:cochabambacultural/ui/widgets/splash_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.search, size: 30),
      const Icon(Icons.add, size: 30),
      const Icon(Icons.favorite, size: 30),
      const Icon(Icons.person, size: 30)
    ];

    final tabs = [
      const HomeTab(),
      const SearchEventTab(),
      const CreateEventTab(),
      const FavoritesEventTab(),
      const UserProfileTab()
    ];

    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      if (state.existUser) {
        return WillPopScope(
          onWillPop: () async {
            // if (Platform.isAndroid) {
            //   SystemNavigator.pop();
            // }
            return false;
          },
          child: Container(
            color: colorApp.primaryBackground,
            child: SafeArea(
              top: false,
              child: ClipRect(
                child: Scaffold(
                  backgroundColor: colorApp.primaryBackground,
                  extendBody: true,
                  body: tabs[index],
                  bottomNavigationBar: Theme(
                    data: Theme.of(context).copyWith(
                        iconTheme: IconThemeData(color: colorApp.iconPrimary)),
                    child: CurvedNavigationBar(
                      backgroundColor: Colors.transparent,
                      height: responsive.hp(7.6),
                      index: index,
                      animationCurve: Curves.easeInOut,
                      animationDuration: const Duration(milliseconds: 300),
                      items: items,
                      color: colorApp.primaryColor,
                      onTap: (index) => setState(() {
                        this.index = index;
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const SplashWidget());
      }
    });
  }
}
