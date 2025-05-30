// import 'package:flutter/material.dart';

// import '../api/apis.dart';
// import '../helper/my_date_util.dart';
// import '../main.dart';
// import '../models/chat_user.dart';
// import '../models/message.dart';
// import '../screens/chat_screen.dart';
// import 'dialogs/profile_dialog.dart';
// import 'profile_image.dart';

// //card to represent a single user in home screen
// class ChatUserCard extends StatefulWidget {
//   final ChatUser user;

//   const ChatUserCard({super.key, required this.user});

//   @override
//   State<ChatUserCard> createState() => _ChatUserCardState();
// }

// class _ChatUserCardState extends State<ChatUserCard> {
//   //last message info (if null --> no message)
//   Message? _message;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
//       // color: Colors.blue.shade100,
//       elevation: 0.5,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15))),
//       child: InkWell(
//         borderRadius: const BorderRadius.all(Radius.circular(15)),
//           onTap: () {
//             //for navigating to chat screen
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => ChatScreen(user: widget.user)));
//           },
//           child: StreamBuilder(
//             stream: APIs.getLastMessage(widget.user),
//             builder: (context, snapshot) {
//               final data = snapshot.data?.docs;
//               final list =
//                   data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
//               if (list.isNotEmpty) _message = list[0];

//               return ListTile(
//                 //user profile picture
//                 leading: InkWell(
//                   onTap: () {
//                     showDialog(
//                         context: context,
//                         builder: (_) => ProfileDialog(user: widget.user));
//                   },
//                   child: ProfileImage(
//                       size: mq.height * .055, url: widget.user.image),
//                 ),

//                 //user name
//                 title: Text(widget.user.name),

//                 //last message
//                 subtitle: Text(
//                     _message != null
//                         ? _message!.type == Type.image
//                             ? 'image'
//                             : _message!.msg
//                         : widget.user.about,
//                     maxLines: 1),

//                 //last message time
//                 trailing: _message == null
//                     ? null //show nothing when no message is sent
//                     : _message!.read.isEmpty &&
//                             _message!.fromId != APIs.user.uid
//                         ?
//                         //show for unread message
//                         const SizedBox(
//                             width: 15,
//                             height: 15,
//                             child: DecoratedBox(
//                               decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 0, 230, 119),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10))),
//                             ),
//                           )
//                         :
//                         //message sent time
//                         Text(
//                             MyDateUtil.getLastMessageTime(
//                                 context: context, time: _message!.sent),
//                             style: const TextStyle(color: Colors.black54),
//                           ),
//               );
//             },
//           )),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../api/apis.dart';
import '../helper/my_date_util.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import '../screens/chat_screen.dart';
import 'dialogs/profile_dialog.dart';
import 'profile_image.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key, required this.user});

  final ChatUser user;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message; // Last message (null if none)

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(user: widget.user),
            ),
          );
        },
        child: StreamBuilder(
          stream: APIs.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list = data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

            if (list.isNotEmpty) _message = list[0];

            return ListTile(
              // Profile picture with tap dialog
              leading: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => ProfileDialog(user: widget.user),
                  );
                },
                child: ProfileImage(size: mq.height * .055, url: widget.user.image),
              ),

              // User name
              title: Text(
                widget.user.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              // Last message or about
              subtitle: Text(
                _message != null
                    ? _message!.type == Type.image
                        ? '📷 Image'
                        : _message!.msg
                    : widget.user.about,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // Trailing time or unread indicator
              trailing: _message == null
                  ? null
                  : _message!.read.isEmpty && _message!.fromId != APIs.user.uid
                      ? const CircleAvatar(
                          backgroundColor: Color(0xFF00E677),
                          radius: 6,
                        )
                      : Text(
                          MyDateUtil.getLastMessageTime(
                            context: context,
                            time: _message!.sent,
                          ),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}

