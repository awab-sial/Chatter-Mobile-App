// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../api/apis.dart';
// import '../../helper/dialogs.dart';
// import '../../main.dart';
// import '../../models/chat_user.dart';
// import '../widgets/profile_image.dart';
// import 'auth/login_screen.dart';

// //profile screen -- to show signed in user info
// class ProfileScreen extends StatefulWidget {
//   final ChatUser user;

//   const ProfileScreen({super.key, required this.user});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _image;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // for hiding keyboard
//       onTap: FocusScope.of(context).unfocus,
//       child: Scaffold(
//           //app bar
//           appBar: AppBar(title: const Text('Profile Dashboard')),

//           //floating button to log out
//           floatingActionButton: Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: FloatingActionButton.extended(
//                 backgroundColor: Colors.redAccent,
//                 onPressed: () async {
//                   //for showing progress dialog
//                   Dialogs.showLoading(context);

//                   await APIs.updateActiveStatus(false);

//                   //sign out from app
//                   await APIs.auth.signOut().then((value) async {
//                     await GoogleSignIn().signOut().then((value) {
//                       //for hiding progress dialog
//                       Navigator.pop(context);

//                       //for moving to home screen
//                       Navigator.pop(context);

//                       // APIs.auth = FirebaseAuth.instance;

//                       //replacing home screen with login screen
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const LoginScreen()));
//                     });
//                   });
//                 },
//                 icon: const Icon(Icons.logout),
//                 label: const Text('Logout')),
//           ),

//           //body
//           body: Form(
//             key: _formKey,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // for adding some space
//                     SizedBox(width: mq.width, height: mq.height * .03),

//                     //user profile picture
//                     Stack(
//                       children: [
//                         //profile picture
//                         _image != null
//                             ?

//                             //local image
//                             ClipRRect(
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(mq.height * .1)),
//                                 child: Image.file(File(_image!),
//                                     width: mq.height * .2,
//                                     height: mq.height * .2,
//                                     fit: BoxFit.cover))
//                             :

//                             //image from server
//                             ProfileImage(
//                                 size: mq.height * .2,
//                                 url: widget.user.image,
//                               ),

//                         //edit image button
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: MaterialButton(
//                             elevation: 1,
//                             onPressed: () {
//                               _showBottomSheet();
//                             },
//                             shape: const CircleBorder(),
//                             color: Colors.white,
//                             child: const Icon(Icons.edit, color: Colors.blue),
//                           ),
//                         )
//                       ],
//                     ),

//                     // for adding some space
//                     SizedBox(height: mq.height * .03),

//                     // user email label
//                     Text(widget.user.email,
//                         style: const TextStyle(
//                             color: Colors.black54, fontSize: 16)),

//                     // for adding some space
//                     SizedBox(height: mq.height * .05),

//                     // name input field
//                     TextFormField(
//                       initialValue: widget.user.name,
//                       onSaved: (val) => APIs.me.name = val ?? '',
//                       validator: (val) => val != null && val.isNotEmpty
//                           ? null
//                           : 'Required Field',
//                       decoration: const InputDecoration(
//                           prefixIcon: Icon(Icons.person, color: Colors.blue),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(12)),
//                           ),
//                           hintText: 'eg. Happy Singh',
//                           label: Text('Name')),
//                     ),

//                     // for adding some space
//                     SizedBox(height: mq.height * .02),

//                     // about input field
//                     TextFormField(
//                       initialValue: widget.user.about,
//                       onSaved: (val) => APIs.me.about = val ?? '',
//                       validator: (val) => val != null && val.isNotEmpty
//                           ? null
//                           : 'Required Field',
//                       decoration: const InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.info_outline, color: Colors.blue),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(12)),
//                           ),
//                           hintText: 'eg. Feeling Happy',
//                           label: Text('About')),
//                     ),

//                     // for adding some space
//                     SizedBox(height: mq.height * .05),

//                     // update profile button
//                     ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                           shape: const StadiumBorder(),
//                           minimumSize: Size(mq.width * .5, mq.height * .06)),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();
//                           APIs.updateUserInfo().then((value) {
//                             Dialogs.showSnackbar(
//                                 context, 'Profile Updated Successfully!');
//                           });
//                         }
//                       },
//                       icon: const Icon(Icons.edit, size: 28),
//                       label:
//                           const Text('UPDATE', style: TextStyle(fontSize: 16)),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }

//   // bottom sheet for picking a profile picture for user
//   void _showBottomSheet() {
//     showModalBottomSheet(
//         context: context,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         builder: (_) {
//           return ListView(
//             shrinkWrap: true,
//             padding:
//                 EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
//             children: [
//               //pick profile picture label
//               const Text('Pick Profile Picture',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

//               //for adding some space
//               SizedBox(height: mq.height * .02),

//               //buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   //pick from gallery button
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           shape: const CircleBorder(),
//                           fixedSize: Size(mq.width * .3, mq.height * .15)),
//                       onPressed: () async {
//                         final ImagePicker picker = ImagePicker();

//                         // Pick an image
//                         final XFile? image = await picker.pickImage(
//                             source: ImageSource.gallery, imageQuality: 80);
//                         if (image != null) {
//                           log('Image Path: ${image.path}');
//                           setState(() {
//                             _image = image.path;
//                           });

//                           APIs.updateProfilePicture(File(_image!));

//                           // for hiding bottom sheet
//                           if (mounted) Navigator.pop(context);
//                         }
//                       },
//                       child: Image.asset('assets/images/add_image.png')),

//                   //take picture from camera button
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           shape: const CircleBorder(),
//                           fixedSize: Size(mq.width * .3, mq.height * .15)),
//                       onPressed: () async {
//                         final ImagePicker picker = ImagePicker();

//                         // Pick an image
//                         final XFile? image = await picker.pickImage(
//                             source: ImageSource.camera, imageQuality: 80);
//                         if (image != null) {
//                           log('Image Path: ${image.path}');
//                           setState(() {
//                             _image = image.path;
//                           });

//                           APIs.updateProfilePicture(File(_image!));

//                           // for hiding bottom sheet
//                           if (mounted) Navigator.pop(context);
//                         }
//                       },
//                       child: Image.asset('assets/images/camera.png')),
//                 ],
//               )
//             ],
//           );
//         });
//   }
// }


import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/apis.dart';
import '../../helper/dialogs.dart';
import '../../main.dart';
import '../../models/chat_user.dart';
import '../widgets/profile_image.dart';
import 'auth/login_screen.dart';

// Profile screen to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile Dashboard')),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              Dialogs.showLoading(context);

              await APIs.updateActiveStatus(false);
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();

              if (mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ),

        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: mq.height * .03),

                  // Profile picture with edit button
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .1),
                        child: _image != null
                            ? Image.file(
                                File(_image!),
                                width: mq.height * .2,
                                height: mq.height * .2,
                                fit: BoxFit.cover,
                              )
                            : ProfileImage(
                                size: mq.height * .2,
                                url: widget.user.image,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: _showBottomSheet,
                          shape: const CircleBorder(),
                          color: Colors.white,
                          child: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: mq.height * .03),

                  Text(widget.user.email,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16)),

                  SizedBox(height: mq.height * .05),

                  // Name input
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      hintText: 'e.g. Happy Singh',
                      label: Text('Name'),
                    ),
                  ),

                  SizedBox(height: mq.height * .02),

                  // About input
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.about = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.info_outline, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      hintText: 'e.g. Feeling Happy',
                      label: Text('About'),
                    ),
                  ),

                  SizedBox(height: mq.height * .05),

                  // Update button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size(mq.width * .5, mq.height * .06),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                              context, 'Profile Updated Successfully!');
                        });
                      }
                    },
                    icon: const Icon(Icons.edit, size: 28),
                    label:
                        const Text('UPDATE', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Bottom sheet to pick image
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding:
              EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
          children: [
            const Text('Pick Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

            SizedBox(height: mq.height * .02),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Gallery
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(mq.width * .3, mq.height * .15),
                  ),
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Image.asset('assets/images/add_image.png'),
                ),

                // Camera
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(mq.width * .3, mq.height * .15),
                  ),
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: Image.asset('assets/images/camera.png'),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  // Pick image handler
  void _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: source, imageQuality: 80);

    if (image != null) {
      log('Image Path: ${image.path}');
      setState(() => _image = image.path);
      await APIs.updateProfilePicture(File(_image!));
      if (mounted) Navigator.pop(context);
    }
  }
}

