// import 'package:lottie/lottie.dart';

// import '../main.dart';
// import 'package:flutter/material.dart';

// import '../models/message.dart';
// import 'profile_image.dart';

// class AiMessageCard extends StatelessWidget {
//   final AiMessage message;

//   const AiMessageCard({super.key, required this.message});

//   @override
//   Widget build(BuildContext context) {
//     const r = Radius.circular(15);

//     return message.msgType == MessageType.bot

//         //bot
//         ? Row(children: [
//             const SizedBox(width: 6),

//             CircleAvatar(
//               radius: 18,
//               backgroundColor: Colors.white,
//               child: Image.asset('assets/images/logo.png', width: 24),
//             ),

//             //
//             Container(
//               constraints: BoxConstraints(maxWidth: mq.width * .6),
//               margin: EdgeInsets.only(
//                   bottom: mq.height * .02, left: mq.width * .02),
//               padding: EdgeInsets.symmetric(
//                   vertical: mq.height * .01, horizontal: mq.width * .02),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.blue),
//                   borderRadius: const BorderRadius.only(
//                       topLeft: r, topRight: r, bottomRight: r)),
//               child: message.msg.isEmpty
//                   ? Lottie.asset('assets/lottie/ai.json', width: 35)
//                   : Text(message.msg, textAlign: TextAlign.center),
//             )
//           ])

//         //user
//         : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//             //
//             Container(
//                 constraints: BoxConstraints(maxWidth: mq.width * .6),
//                 margin: EdgeInsets.only(
//                     bottom: mq.height * .02, right: mq.width * .02),
//                 padding: EdgeInsets.symmetric(
//                     vertical: mq.height * .01, horizontal: mq.width * .02),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.green),
//                     borderRadius: const BorderRadius.only(
//                         topLeft: r, topRight: r, bottomLeft: r)),
//                 child: Text(
//                   message.msg,
//                   textAlign: TextAlign.center,
//                 )),

//             const ProfileImage(size: 35),

//             const SizedBox(width: 6),
//           ]);
//   }
// }


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../models/message.dart';
import 'profile_image.dart';

class AiMessageCard extends StatelessWidget {
  const AiMessageCard({super.key, required this.message});

  final AiMessage message;

  static const _radius = Radius.circular(15);

  @override
  Widget build(BuildContext context) {
    // Bot Message
    if (message.msgType == MessageType.bot) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 6),

          // Bot avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Image.asset('assets/images/logo.png', width: 24),
          ),

          // Bot message container
          Container(
            constraints: BoxConstraints(maxWidth: mq.width * .6),
            margin: EdgeInsets.only(
              bottom: mq.height * .02,
              left: mq.width * .02,
            ),
            padding: EdgeInsets.symmetric(
              vertical: mq.height * .012,
              horizontal: mq.width * .03,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              border: Border.all(color: Colors.blue),
              borderRadius: const BorderRadius.only(
                topLeft: _radius,
                topRight: _radius,
                bottomRight: _radius,
              ),
            ),
            child: message.msg.isEmpty
                ? Lottie.asset('assets/lottie/ai.json', width: 35)
                : SelectableText(
                    message.msg,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
          ),
        ],
      );
    }

    // User Message
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: mq.width * .6),
          margin: EdgeInsets.only(
            bottom: mq.height * .02,
            right: mq.width * .02,
          ),
          padding: EdgeInsets.symmetric(
            vertical: mq.height * .012,
            horizontal: mq.width * .03,
          ),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.05),
            border: Border.all(color: Colors.green),
            borderRadius: const BorderRadius.only(
              topLeft: _radius,
              topRight: _radius,
              bottomLeft: _radius,
            ),
          ),
          child: SelectableText(
            message.msg,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ),

        const ProfileImage(size: 35),

        const SizedBox(width: 6),
      ],
    );
  }
}

