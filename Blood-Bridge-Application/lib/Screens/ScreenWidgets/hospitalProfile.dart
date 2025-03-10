import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Auth/loginPage.dart';

class HospitalProfile extends StatefulWidget {
  final User user;
  const HospitalProfile({super.key, required this.user});
  @override
  State<HospitalProfile> createState() => _HospitalProfileState();
}

class _HospitalProfileState extends State<HospitalProfile> {
  bool _isSigningOut = false;
  String phone = 'unkonwn';
  String location = 'unknown';
  void getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final currentUserData =
        await FirebaseFirestore.instance.doc('users/${uid!}').get();
    location = currentUserData['location'];
    phone = currentUserData['mobileNo'];

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFFF8E1E7),
                      radius: 70.r,
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        radius: 60.r,
                        child: Image.asset(
                          'assets/images/hospital-building.png',
                          height: 40.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${widget.user.displayName}",
                    style: TextStyle(
                        color: const Color(0xFBD85585),
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 82.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF8E1E7),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black54),
                              ),
                            ),
                            Container(
                              child: Text(
                                location.length > 20
                                    ? "${location.substring(0, 17)}..."
                                    : location,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(
                          color: Color(0xFFD1AAB1),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                "Phone no.",
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black54),
                              ),
                            ),
                            Container(
                              child: Text(
                                phone,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      'assets/images/profileImage.png',
                      colorBlendMode: BlendMode.color,
                      height: 80.h,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Thank you for being a part of our Blood Bank",
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  _isSigningOut
                      ? const CircularProgressIndicator()
                      : TextButton(
                          onPressed: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await FirebaseAuth.instance.signOut();
                            setState(() {
                              _isSigningOut = false;
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Log out',
                            style: TextStyle(color: Color(0xFBD85585)),
                          ),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
