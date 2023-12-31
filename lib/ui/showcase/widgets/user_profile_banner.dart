import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/auth_utility.dart';
import 'package:taskmanager/ui/showcase/screens/authentication/edit_profile_screen.dart';
import 'package:taskmanager/ui/showcase/screens/authentication/sign_in_screen.dart';

class UserProfileBanner extends StatefulWidget {
  final bool? isUpdateScreen;

  const UserProfileBanner({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()));
          }
        },
        child: Row(
          children: [
            Visibility(
              visible: (widget.isUpdateScreen ?? false) == false,
              child: Row(
                children: [
                  CircleAvatar(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          const Icon(Icons.account_circle_outlined),
                      imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.account_circle_outlined),
                    ),
                  ),

                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(
                  //     AuthUtility.userInfo.data?.photo ?? '',
                  //   ),
                  //   onBackgroundImageError: (_, __) {
                  //     const Icon(Icons.image);
                  //   },
                  //   radius: 18,
                  // ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            }
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
