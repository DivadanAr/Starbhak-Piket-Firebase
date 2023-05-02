// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:project_starbhak_piket/components/bottomNavigation.dart';
// import 'package:project_starbhak_piket/models/absensiModel.dart';
// import 'package:project_starbhak_piket/models/kelasModel.dart';
// import 'package:project_starbhak_piket/pages/absensiPage.dart';
// import 'package:searchfield/searchfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AbsensiRekapPage extends StatefulWidget {
//   final absensi_model? absensi; // definisikan parameter untuk menerima data
//   final kelas_model? getdata; // definisikan parameter untuk menerima data
//   const AbsensiRekapPage({
//     super.key,
//     required this.absensi, required this.getdata
//   });

//   @override
//   State < AbsensiRekapPage > createState() => _AbsensiRekapPageState();
// }

// class _AbsensiRekapPageState extends State < AbsensiRekapPage > {
//   // List < String > izin = [
//   //   'Divadan',
//   //   'Arya Rahman',
//   //   'Sheyla Aulia',
//   //   'khairan nail'
//   // ];

//   final CollectionReference _absensi =
//   FirebaseFirestore.instance.collection('absensi');
//   // bool _isChecked = false;

//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();

//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.fromLTRB(40, 50, 40, 25),
//         child: Column(
//           children: [
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(
//                     Icons.arrow_back_ios_new_rounded,
//                   ),
//                   Container(
//                     width: 140,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(100),
//                       // border: Border.all(width: 1.5, color: Color.fromARGB(255, 89, 89, 89))
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(0, 7),
//                           spreadRadius: 0,
//                           blurRadius: 5,
//                           color: Color.fromRGBO(208, 208, 208, 1),
//                         )
//                       ]),
//                     child: Container(
//                       child: Center(
//                         child: Text("Pilih Siswa",
//                           style: GoogleFonts.quicksand(
//                             textStyle: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16,
//                             ))),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 margin: EdgeInsets.only(top: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Container(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("${widget.getdata?.nama}",
//                                 style: GoogleFonts.quicksand(
//                                   textStyle: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 30,
//                                   ))),
//                               SizedBox(height: 3),
//                               Text("${widget.getdata?.guru}",
//                                 style: GoogleFonts.quicksand(
//                                   textStyle: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 14,
//                                   )))
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 100,
//                           height: 27,
//                           decoration: BoxDecoration(
//                             color: Color(0xff7F669D),
//                             borderRadius: BorderRadius.circular(5)),
//                           child: Center(
//                             child: Text("30 Siswa",
//                               style: GoogleFonts.quicksand(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                   color: Colors.white))),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 20, bottom: 20),
//                       color: Colors.black38,
//                       height: 1.5,
//                       width: double.maxFinite,
//                     ),
//                     Container(
//                       child: Expanded(
//                         child: ListView(
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Tanggal",
//                                   style: GoogleFonts.quicksand(
//                                     textStyle: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                       color: Colors.black))),
//                                 Text("jumat, 14 april 2023",
//                                   style: GoogleFonts.quicksand(
//                                     textStyle: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: Colors.black38))),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Guru Yang bertugas",
//                                   style: GoogleFonts.quicksand(
//                                     textStyle: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                       color: Colors.black))),
//                                 Text("Yoga Sanjaya",
//                                   style: GoogleFonts.quicksand(
//                                     textStyle: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                       color: Colors.black38))),
//                               ],
//                             ),
//                             SizedBox(height: 15),
//                             Text("Siswa Tidak Hadir",
//                               style: GoogleFonts.quicksand(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: Colors.black))),
//                             StreamBuilder(
//                               stream: _absensi
//                               .where('kelas', isEqualTo: 'XI PPLG 2')
//                               .limit(1)
//                               .snapshots(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   return Container(
//                                     width: double.maxFinite,
//                                     height: 350,
//                                     margin: EdgeInsets.only(top: 5),
//                                     padding: EdgeInsets.fromLTRB(
//                                       22, 15, 22, 0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius:
//                                       BorderRadius.circular(10),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           offset: Offset(0, 3),
//                                           spreadRadius: -4,
//                                           blurRadius: 7,
//                                           color: Color.fromRGBO(
//                                             161, 161, 161, 1),
//                                         )
//                                       ]),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment
//                                           .spaceBetween,
//                                           children: [
//                                             Text("Izin",
//                                               style: GoogleFonts.quicksand(
//                                                 textStyle: TextStyle(
//                                                   fontWeight:
//                                                   FontWeight
//                                                   .w600,
//                                                   fontSize: 16,
//                                                   color: Colors
//                                                   .black))),
//                                             Text(
//                                               snapshot.data!.docs.length
//                                               .toString() +
//                                               " siswa",
//                                               style: GoogleFonts.quicksand(
//                                                 textStyle: TextStyle(
//                                                   fontWeight:
//                                                   FontWeight
//                                                   .w500,
//                                                   fontSize: 15,
//                                                   color: Colors
//                                                   .black38))),
//                                           ],
//                                         ),
//                                         Container(
//                                           height: 80,
//                                           child: ListView.builder(
//                                             itemCount: snapshot
//                                             .data!.docs.length,
//                                             itemBuilder:
//                                             (context, index) {
//                                               final DocumentSnapshot
//                                               records = snapshot
//                                                 .data!
//                                                 .docs[index];

//                                               List < String > izinList = [];

//                                               List < dynamic >
//                                                 izinDynamicList =
//                                                 records['izin'];
//                                               for (dynamic izin in izinDynamicList) {
//                                                 izinList.add(
//                                                   izin.toString());
//                                                 print(izinList[index]);
//                                               }
//                                               return ListView.builder(
//                                                 padding:
//                                                 EdgeInsets.all(0),
//                                                 itemCount:
//                                                 izinList.length,
//                                                 shrinkWrap: true,
//                                                 itemBuilder:
//                                                 (context, index) {
//                                                   return Container(
//                                                     padding:
//                                                     EdgeInsets.only(
//                                                       left: 5),
//                                                     margin:
//                                                     EdgeInsets.only(
//                                                       top: 5,
//                                                       bottom: 3,
//                                                       left: 10),
//                                                     decoration:
//                                                     BoxDecoration(
//                                                       border: Border(
//                                                         left:
//                                                         BorderSide(
//                                                           color: Colors
//                                                           .black45,
//                                                           width: 2.0,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     height: 20,
//                                                     child: Text(
//                                                       izinList[index],
//                                                       style: GoogleFonts.quicksand(
//                                                         textStyle: TextStyle(
//                                                           fontWeight:
//                                                           FontWeight
//                                                           .w600,
//                                                           fontSize:
//                                                           15,
//                                                           color: Colors
//                                                           .black54))),
//                                                   );
//                                                 },
//                                               );
//                                             }),
//                                         ),
//                                         SizedBox(height: 7),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment
//                                           .spaceBetween,
//                                           children: [
//                                             Text("Sakit",
//                                               style: GoogleFonts.quicksand(
//                                                 textStyle: TextStyle(
//                                                   fontWeight:
//                                                   FontWeight
//                                                   .w600,
//                                                   fontSize: 16,
//                                                   color: Colors
//                                                   .black))),
//                                             Text(
//                                               snapshot.data!.docs.length
//                                               .toString() +
//                                               " siswa",
//                                               style: GoogleFonts.quicksand(
//                                                 textStyle: TextStyle(
//                                                   fontWeight:
//                                                   FontWeight
//                                                   .w500,
//                                                   fontSize: 15,
//                                                   color: Colors
//                                                   .black38))),
//                                           ],
//                                         ),
//                                         Container(
//                                           height: 80,
//                                           child: ListView.builder(
//                                             itemCount: snapshot
//                                             .data!.docs.length,
//                                             itemBuilder:
//                                             (context, index) {
//                                               final DocumentSnapshot
//                                               records = snapshot
//                                                 .data!
//                                                 .docs[index];

//                                               List < String > sakitList = [];

//                                               List < dynamic >
//                                                 sakitDynamicList =
//                                                 records['sakit'];
//                                               for (dynamic sakit in sakitDynamicList) {
//                                                 sakitList.add(
//                                                   sakit.toString());
//                                                 print(sakitList[index]);
//                                               }
//                                               return ListView.builder(
//                                                 padding:
//                                                 EdgeInsets.all(0),
//                                                 itemCount:
//                                                 sakitList.length,
//                                                 shrinkWrap: true,
//                                                 itemBuilder:
//                                                 (context, index) {
//                                                   return Container(
//                                                     padding:
//                                                     EdgeInsets.only(
//                                                       left: 5),
//                                                     margin:
//                                                     EdgeInsets.only(
//                                                       top: 5,
//                                                       bottom: 3,
//                                                       left: 10),
//                                                     decoration:
//                                                     BoxDecoration(
//                                                       border: Border(
//                                                         left:
//                                                         BorderSide(
//                                                           color: Colors
//                                                           .black45,
//                                                           width: 2.0,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     height: 20,
//                                                     child: Text(
//                                                       sakitList[
//                                                         index],
//                                                       style: GoogleFonts.quicksand(
//                                                         textStyle: TextStyle(
//                                                           fontWeight:
//                                                           FontWeight
//                                                           .w600,
//                                                           fontSize:
//                                                           15,
//                                                           color: Colors
//                                                           .black54))),
//                                                   );
//                                                 },
//                                               );
//                                             }),
//                                         ),
//                                         SizedBox(height: 7),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment
//                                           .spaceBetween,
//                                           children: [
//                                             Text("Alfa",
//                                               style: GoogleFonts.quicksand(
//                                                 textStyle: TextStyle(
//                                                   fontWeight:
//                                                   FontWeight
//                                                   .w600,
//                                                   fontSize: 16,
//                                                   color: Colors
//                                                   .black))),
//                                             Text(
//                                               snapshot.data!.docs.length
//                                               .toString() +
//                                               " siswa",
//                                               style: GoogleFonts.quicksand(
//                                                 textStyle: TextStyle(
//                                                   fontWeight:
//                                                   FontWeight
//                                                   .w500,
//                                                   fontSize: 15,
//                                                   color: Colors
//                                                   .black38))),
//                                           ],
//                                         ),
//                                         Container(
//                                           height: 80,
//                                           child: ListView.builder(
//                                             itemCount: snapshot
//                                             .data!.docs.length,
//                                             itemBuilder:
//                                             (context, index) {
//                                               final DocumentSnapshot
//                                               records = snapshot
//                                                 .data!
//                                                 .docs[index];

//                                               List < String > alfaList = [];

//                                               List < dynamic >
//                                                 alfaDynamicList =
//                                                 records['alfa'];
//                                               for (dynamic alfa in alfaDynamicList) {
//                                                 alfaList.add(
//                                                   alfa.toString());
//                                                 print(alfaList[index]);
//                                               }
//                                               return ListView.builder(
//                                                 padding:
//                                                 EdgeInsets.all(0),
//                                                 itemCount:
//                                                 alfaList.length,
//                                                 shrinkWrap: true,
//                                                 itemBuilder:
//                                                 (context, index) {
//                                                   return Container(
//                                                     padding:
//                                                     EdgeInsets.only(
//                                                       left: 5),
//                                                     margin:
//                                                     EdgeInsets.only(
//                                                       top: 5,
//                                                       bottom: 3,
//                                                       left: 10),
//                                                     decoration:
//                                                     BoxDecoration(
//                                                       border: Border(
//                                                         left:
//                                                         BorderSide(
//                                                           color: Colors
//                                                           .black45,
//                                                           width: 2.0,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     height: 20,
//                                                     child: Text(
//                                                       alfaList[index],
//                                                       style: GoogleFonts.quicksand(
//                                                         textStyle: TextStyle(
//                                                           fontWeight:
//                                                           FontWeight
//                                                           .w600,
//                                                           fontSize:
//                                                           15,
//                                                           color: Colors
//                                                           .black54))),
//                                                   );
//                                                 },
//                                               );
//                                             }),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 } else {
//                                   return CircularProgressIndicator();
//                                 }
//                               }),
//                             SizedBox(height: 15),
//                             Text("Dokumentasi",
//                               style: GoogleFonts.quicksand(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: Colors.black))),
//                             SizedBox(height: 10),
//                             Container(
//                               margin: EdgeInsets.only(bottom: 30),
//                               padding: EdgeInsets.all(10),
//                               width: double.maxFinite,
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     offset: Offset(0, 3),
//                                     spreadRadius: -3,
//                                     blurRadius: 7,
//                                     color: Color.fromRGBO(123, 123, 123, 1),
//                                   )
//                                 ]),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.network(
//                                   '${widget.absensi?.foto}',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//             ),
//             Center(
//               child: SizedBox(
//                 height: 45,
//                 width: double.maxFinite,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AbsensiPage()));
//                   },
//                   child: Text("Selanjutnya"),
//                   style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all < Color > (Color(0xff7F669D)),
//                     shape: MaterialStateProperty.all < RoundedRectangleBorder > (
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_starbhak_piket/components/bottomNavigation.dart';
import 'package:project_starbhak_piket/models/absensiModel.dart';
import 'package:project_starbhak_piket/models/kelasModel.dart';
import 'package:project_starbhak_piket/pages/homePage.dart';
import 'package:project_starbhak_piket/pages/myControllerPage.dart';
import 'package:searchfield/searchfield.dart';

class AbsensiRekapPage extends StatefulWidget {
    final absensi_model? absensi; // definisikan parameter untuk menerima data
  final kelas_model? getdata; // definisikan parameter untuk menerima data
  const AbsensiRekapPage({
    super.key,
    required this.absensi, required this.getdata
  });


  @override
  State<AbsensiRekapPage> createState() => _AbsensiRekapPageState();
}

class _AbsensiRekapPageState extends State<AbsensiRekapPage> {
  List<String> izin = [];
  List<String> sakit= [];
  List<String> alfa = [];

  @override
  void initState() {
    super.initState();

    izin = widget.absensi!.izin!
        .map((izin) => izin.toString())
        .toList();

    sakit = widget.absensi!.sakit!
        .map((sakit) => sakit.toString())
        .toList();

    alfa = widget.absensi!.alfa!
        .map((alfa) => alfa.toString())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 50, 40, 25),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                  Container(
                    width: 140,
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
                        child: Text("Pilih Siswa",
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
            Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.getdata!.nama}",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                    ))),
                                SizedBox(height: 3),
                                Text("${widget.getdata!.guru}",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    )))
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 27,
                            decoration: BoxDecoration(
                                color: Color(0xff7F669D),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text("${widget.getdata!.jumlah} Siswa",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        color: Colors.black38,
                        height: 1.5,
                        width: double.maxFinite,
                      ),
                      Container(
                        child: Expanded(
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tanggal",
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black))),
                                  Text("${widget.absensi!.hari}, ${widget.absensi!.tanggal}",
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.black38))),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Guru Yang bertugas",
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black))),
                                  Text("Yoga Sanjaya",
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.black38))),
                                ],
                              ),
                              SizedBox(height: 15),
                              Text("Siswa Tidak Hadir",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black))),
                              Container(
                                width: double.maxFinite,
                                height: 300,
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.fromLTRB(22, 15, 22, 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 3),
                                        spreadRadius: -4,
                                        blurRadius: 7,
                                        color: Color.fromRGBO(161, 161, 161, 1),
                                      )
                                    ]),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Izin",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.black))),
                                          Text(izin.length.toString() + " siswa",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.black38))),
                                        ],
                                      ),
                                      Container(
                                        height: izin.length * 30,
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          itemCount: izin.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.only(left: 5),
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 3, left: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black45,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              height: 20,
                                              child: Text(izin[index],
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54))),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Sakit",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.black))),
                                          Text(sakit.length.toString() + " siswa",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.black38))),
                                        ],
                                      ),
                                      Container(
                                        height: sakit.length * 30,
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          itemCount: sakit.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.only(left: 5),
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 3, left: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black45,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              height: 20,
                                              child: Text(sakit[index],
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54))),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Alfa",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.black))),
                                          Text(alfa.length.toString() + " siswa",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.black38))),
                                        ],
                                      ),
                                      Container(
                                        height: alfa.length * 30,
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          itemCount: alfa.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.only(left: 5),
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 3, left: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black45,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              height: 20,
                                              child: Text(alfa[index],
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54))),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text("Dokumentasi",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black))),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                padding: EdgeInsets.all(10),
                                width: double.maxFinite,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 3),
                                        spreadRadius: -3,
                                        blurRadius: 7,
                                        color: Color.fromRGBO(123, 123, 123, 1),
                                      )
                                    ]),
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  '${widget.absensi?.foto}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Center(
              child: SizedBox(
                height: 45,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyControllerPage()));
                  },
                  child: Text("Selanjutnya"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff7F669D)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
