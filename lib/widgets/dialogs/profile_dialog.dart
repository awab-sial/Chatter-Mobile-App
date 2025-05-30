// import 'package:flutter/material.dart';

// import '../../main.dart';
// import '../../models/chat_user.dart';
// import '../../screens/view_profile_screen.dart';
// import '../profile_image.dart';

// class ProfileDialog extends StatelessWidget {
//   const ProfileDialog({super.key, required this.user});

//   final ChatUser user;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.zero,
//       backgroundColor: Colors.white.withOpacity(.9),
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15))),
//       content: SizedBox(
//           width: mq.width * .6,
//           height: mq.height * .35,
//           child: Stack(
//             children: [
//               //user profile picture
//               Positioned(
//                 top: mq.height * .075,
//                 left: mq.width * .1,
//                 child: ProfileImage(size: mq.width * .5, url: user.image),
//               ),

//               //user name
//               Positioned(
//                 left: mq.width * .04,
//                 top: mq.height * .02,
//                 width: mq.width * .55,
//                 child: Text(user.name,
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.w500)),
//               ),

//               //info button
//               Positioned(
//                   right: 8,
//                   top: 6,
//                   child: MaterialButton(
//                     onPressed: () {
//                       //for hiding image dialog
//                       Navigator.pop(context);

//                       //move to view profile screen
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => ViewProfileScreen(user: user)));
//                     },
//                     minWidth: 0,
//                     padding: const EdgeInsets.all(0),
//                     shape: const CircleBorder(),
//                     child: const Icon(Icons.info_outline,
//                         color: Colors.blue, size: 30),
//                   ))
//             ],
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/chat_user.dart';
import '../../screens/view_profile_screen.dart';
import '../profile_image.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .35,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // User profile image
            Positioned(
              top: mq.height * .075,
              left: mq.width * .1,
              child: Hero(
                tag: 'profile-${user.id}', // Add tag for smooth transition
                child: ProfileImage(
                  size: mq.width * .5,
                  url: user.image,
                ),
              ),
            ),

            // User name
            Positioned(
              left: mq.width * .04,
              top: mq.height * .02,
              width: mq.width * .48,
              child: Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Info icon button
            Positioned(
              right: 8,
              top: 6,
              child: IconButton(
                tooltip: 'View full profile',
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewProfileScreen(user: user),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
