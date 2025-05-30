// import 'package:flutter/material.dart';

// import '../../helper/my_date_util.dart';
// import '../../main.dart';
// import '../../models/chat_user.dart';
// import '../widgets/profile_image.dart';

// //view profile screen -- to view profile of user
// class ViewProfileScreen extends StatefulWidget {
//   final ChatUser user;

//   const ViewProfileScreen({super.key, required this.user});

//   @override
//   State<ViewProfileScreen> createState() => _ViewProfileScreenState();
// }

// class _ViewProfileScreenState extends State<ViewProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // for hiding keyboard
//       onTap: FocusScope.of(context).unfocus,
//       child: Scaffold(
//           //app bar
//           appBar: AppBar(title: Text(widget.user.name)),

//           //user about
//           floatingActionButton: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Joined On: ',
//                 style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 15),
//               ),
//               Text(
//                   MyDateUtil.getLastMessageTime(
//                       context: context,
//                       time: widget.user.createdAt,
//                       showYear: true),
//                   style: const TextStyle(color: Colors.black54, fontSize: 15)),
//             ],
//           ),

//           //body
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // for adding some space
//                   SizedBox(width: mq.width, height: mq.height * .03),

//                   //user profile picture
//                   ProfileImage(
//                     size: mq.height * .2,
//                     url: widget.user.image,
//                   ),

//                   // for adding some space
//                   SizedBox(height: mq.height * .03),

//                   // user email label
//                   Text(widget.user.email,
//                       style:
//                           const TextStyle(color: Colors.black87, fontSize: 16)),

//                   // for adding some space
//                   SizedBox(height: mq.height * .02),

//                   //user about
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'About: ',
//                         style: TextStyle(
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 15),
//                       ),
//                       Text(widget.user.about,
//                           style: const TextStyle(
//                               color: Colors.black54, fontSize: 15)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../../helper/my_date_util.dart';
import '../../main.dart';
import '../../models/chat_user.dart';
import '../widgets/profile_image.dart';

// View profile screen -- to view profile of another user
class ViewProfileScreen extends StatelessWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(title: Text(user.name)),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Space at top
                SizedBox(height: mq.height * .03),

                // Profile picture
                ProfileImage(size: mq.height * .2, url: user.image),

                // Space
                SizedBox(height: mq.height * .03),

                // Email
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                // Space
                SizedBox(height: mq.height * .02),

                // About section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    const Text(
                      'About: ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        user.about,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                // Space
                SizedBox(height: mq.height * .03),

                // Joined Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: Colors.blueAccent, size: 18),
                    const SizedBox(width: 6),
                    const Text(
                      'Joined On: ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Text(
                      MyDateUtil.getLastMessageTime(
                        context: context,
                        time: user.createdAt,
                        showYear: true,
                      ),
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ],
                ),

                // Bottom space
                SizedBox(height: mq.height * .05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
