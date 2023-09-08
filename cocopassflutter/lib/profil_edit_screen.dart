import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_profile.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();

  const ProfileEditScreen({Key? key}) : super(key: key);
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  int selectedIconIndex = 0;
  String selectedIconUrl = '';

  final List<String> userIcons = [
    'assets/user_icons/default_user_icon.png',
    'assets/user_icons/user_icon1.png',
    'assets/user_icons/user_icon2.png',
    'assets/user_icons/user_icon3.png',
    'assets/user_icons/user_icon4.png',
    'assets/user_icons/user_icon5.png',
    'assets/user_icons/user_icon6.png',
    'assets/user_icons/user_icon7.png',
    'assets/user_icons/user_icon8.png',
    'assets/user_icons/user_icon9.png',
    'assets/user_icons/user_icon10.png',
    'assets/user_icons/user_icon11.png',
    'assets/user_icons/user_icon12.png',
    'assets/user_icons/user_icon13.png',
    'assets/user_icons/user_icon14.png',
  ];

  void updateSelectedIconIndex(int index) {
    setState(() {
      selectedIconIndex = index;
    });
  }

  void updateProfileImage(newImageUrl) {
    final userProfile = Provider.of<UserProfile>(context, listen: false);
    userProfile.setProfileImage(newImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Modifier le profil'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(userIcons[selectedIconIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Choisissez une icône utilisateur :'),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userIcons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      updateSelectedIconIndex(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(userIcons[index]),
                            fit: BoxFit.cover,
                          ),
                          border: selectedIconIndex == index
                              ? Border.all(
                                  color: Colors.deepPurple,
                                  width: 2.0,
                                )
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                selectedIconUrl = userIcons[selectedIconIndex];
                updateProfileImage(selectedIconUrl);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Paramètres enregistrés avec succès.'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child: const Text('ENREGISTRER',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
