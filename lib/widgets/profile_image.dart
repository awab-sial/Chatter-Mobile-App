// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../api/apis.dart';

// class ProfileImage extends StatelessWidget {
//   final double size;
//   final String? url;

//   const ProfileImage({super.key, required this.size, this.url});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(size)),
//       child: CachedNetworkImage(
//         width: size,
//         height: size,
//         fit: BoxFit.cover,
//         imageUrl: url ?? APIs.user.photoURL.toString(),
//         errorWidget: (context, url, error) =>
//             const CircleAvatar(child: Icon(CupertinoIcons.person)),
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/apis.dart';

class ProfileImage extends StatelessWidget {
  final double size;
  final String? url;

  const ProfileImage({super.key, required this.size, this.url});

  @override
  Widget build(BuildContext context) {
    // Determine the image URL to use:
    final imageUrl = (url?.isNotEmpty == true)
        ? url!
        : (APIs.user.photoURL ?? '');

    return CircleAvatar(
      radius: size / 2, // CircleAvatar uses radius, so half of size
      backgroundColor: Colors.grey.shade300,
      backgroundImage: (imageUrl.isNotEmpty)
          ? CachedNetworkImageProvider(imageUrl)
          : null,
      child: (imageUrl.isEmpty)
          ? const Icon(
              CupertinoIcons.person,
              size: 24,
              color: Colors.grey,
            )
          : null,
    );
  }
}
