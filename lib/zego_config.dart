// lib/zego_config.dart
import '../api/apis.dart';


const int appID = ;          // Replace with your actual AppID
const String appSign = ''; // Replace with your actual AppSign

// NOTE: userID and userName will be dynamically set based on logged-in user.
String userID = APIs.me.id;
String userName = APIs.me.name;
