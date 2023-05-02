import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_starbhak_piket/pages/auth/changeEmail.dart';
import 'package:project_starbhak_piket/pages/myControllerPage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  File? image;

  String imageUrl = '';

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    print('${imagePicked?.path}');

    if (imagePicked == null) return;

    String uniqueFileName = DateTime.now().millisecond.toString();

    image = File(imagePicked.path);

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('profile');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(imagePicked.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    usernameController.text = user.displayName ?? '';
    emailController.text = user.email ?? '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    Container(
                      width: 220,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          // border: Border.all(width: 1.5, color: Color.fromARGB(255, 89, 89, 89))
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 7),
                              spreadRadius: 0,
                              blurRadius: 5,
                              color: Color.fromRGBO(208, 208, 208, 1),
                            )
                          ]),
                      child: Container(
                        child: Center(
                          child: Text("Ubah Data Pengguna",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 60, bottom: 15),
                          width: 200,
                          height: 200,
                          child: image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                    height: 1000,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('${user.photoURL}'),
                                )),
                      GestureDetector(
                        onTap: getImage,
                        child: Text(
                          'Ubah Foto',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Pengguna',
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    // initialValue: '${user.displayName}',
                    controller: usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter Your Username',
                        hintText: 'Username',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0), // radius
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0), // radius
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade400),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0), // radius
                          borderSide:
                              BorderSide(width: 2, color: Colors.red.shade700),
                        ),
                        labelStyle: const TextStyle(color: Colors.black54)),
                  )
                ],
              ),
              SizedBox(height: 17),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Pengguna',
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    // initialValue: '${user.email}',
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter Your Username',
                        hintText: 'Username',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0), // radius
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0), // radius
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade400),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0), // radius
                          borderSide:
                              BorderSide(width: 2, color: Colors.red.shade700),
                        ),
                        labelStyle: const TextStyle(color: Colors.black54)),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 240, bottom: 20),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangeEmailPage()));
                          },
                          child: Text('Ubah Password',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)))))
                ],
              ),
              Container(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyControllerPage()));
                  },
                  child: Text("Simpan Perubahan",
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800))),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff7F669D)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
