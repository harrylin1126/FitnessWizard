import 'package:flutter/material.dart';
import "../../constants.dart";
import 'function/profile_details_dialog.dart';
import 'widgets/profile_widget.dart';
import 'function/acheivement_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  /*@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: ExactAssetImage("assets/images/userImage.png"),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Constants.primaryColor.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width*.3,
                child: Row(
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                      child: Image.asset("assets/images/verified.png"),
                    ),
                  ],
                ),
              ),
              Text(
                "modohiyaku@SAO.com",
                style: TextStyle(
                  color: Constants.blackColor.withOpacity(0.3),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: size.height * .7,
                width: size.width,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'My Profile',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ProfileDetailsDialog();
                          },
                        );
                      },
                    ),
                    const ProfileWidget(
                      icon: Icons.settings,
                      title: 'Settings',
                    ),
                    const ProfileWidget(
                      icon: Icons.notifications,
                      title: 'Notifications',
                    ),
                    const ProfileWidget(
                      icon: Icons.auto_awesome,
                      title: 'Achievement',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: ExactAssetImage("assets/images/userImage.png"),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Constants.primaryColor.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Row(
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                      child: Image.asset("assets/images/verified.png"),
                    ),
                  ],
                ),
              ),
              Text(
                "modohiyaku@SAO.com",
                style: TextStyle(
                  color: Constants.blackColor.withOpacity(0.3),
                ),
              ),
              const SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileWidget(
                    icon: Icons.person,
                    title: 'My Profile',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ProfileDetailsDialog();
                        },
                      );
                    },
                  ),
                  const ProfileWidget(
                    icon: Icons.settings,
                    title: 'Settings',
                  ),
                  const ProfileWidget(
                    icon: Icons.notifications,
                    title: 'Notifications',
                  ),
                   ProfileWidget(
                    icon: Icons.auto_awesome,
                    title: 'Achievement',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return  AchievementDialog();
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}