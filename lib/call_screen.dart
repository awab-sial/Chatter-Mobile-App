// lib/call_screen.dart

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'zego_config.dart';

// class CallScreen extends StatelessWidget {
//   final String callID;

//   const CallScreen({Key? key, required this.callID}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ZegoUIKitPrebuiltCall(
//         appID: appID,
//         appSign: appSign,
//         userID: userID,
//         userName: userName,
//         callID: callID,
//         config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
//         onDispose: () {
//           // Called when the call ends and widget disposes
//           Navigator.of(context).pop();
//         },
//       ),
//     );
//   }
// }

class CallScreen extends StatelessWidget {
  final String callID;
  final bool isVideoCall;

  const CallScreen({
    Key? key,
    required this.callID,
    this.isVideoCall = false,
  }) : super(key: key);


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID: appID,
        appSign: appSign,
        userID: userID,
        userName: userName,
        callID: callID,
        config: isVideoCall
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
        onDispose: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
