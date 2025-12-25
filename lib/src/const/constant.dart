import 'package:flutter/material.dart';

const primaryGreen = Color(0xFF5EA560);
const secondaryGreen = Color(0xff98C586);
const accentGreen = Color(0xffDCEED8);

var profilePictureUrls = [
  "https://lmjcaqkomyviuyecqush.supabase.co/storage/v1/object/public/profile_pictures/profie_pic_01.jpg",
  "https://lmjcaqkomyviuyecqush.supabase.co/storage/v1/object/public/profile_pictures/profie_pic_02.jpg",
  "https://lmjcaqkomyviuyecqush.supabase.co/storage/v1/object/public/profile_pictures/profie_pic_03.jpg",
  "https://lmjcaqkomyviuyecqush.supabase.co/storage/v1/object/public/profile_pictures/profie_pic_04.jpg",
  "https://lmjcaqkomyviuyecqush.supabase.co/storage/v1/object/public/profile_pictures/profie_pic_05.jpg",
  "https://lmjcaqkomyviuyecqush.supabase.co/storage/v1/object/public/profile_pictures/profie_pic_06.jpg",
  "https://lmjcaqkomyviuyecqush.supabase.co/storage/v1/object/public/profile_pictures/profie_pic_07.jpg",
  "https://lmjcaqkomyviuyecqush.supabase.co/storage/v1/object/public/profile_pictures/profie_pic_08.jpg",
];

List<Map<String, dynamic>> bins = [
  {'name': 'Bin 1', 'image': Icon(Icons.delete)},
  {'name': 'Bin 2', 'image': Icon(Icons.delete)},
  {'name': 'Bin 3', 'image': Icon(Icons.delete)},
  {'name': 'Bin 4', 'image': Icon(Icons.delete)},
];

List<Map<String, dynamic>> menuIcons = [
  {'name': 'Smart Bins', 'image': Icon(Icons.delete)},
  {'name': 'Auctions', 'image': Icon(Icons.delete)},
  {'name': 'Points', 'image': Icon(Icons.delete)},
];

final privacyPolicyUrl =
    "https://portfolio-zaw-win-myats-projects.vercel.app/privacy_policy_greenglobe.html";

final termsAndConditionsUrl =
    "https://portfolio-zaw-win-myats-projects.vercel.app/terms_conditions_greenglobe.html";
