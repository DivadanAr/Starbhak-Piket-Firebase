import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_starbhak_piket/components/bottomNavigation.dart';
import 'package:project_starbhak_piket/pages/absensiDataSiswaPage.dart';
import 'package:intl/intl.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  
  final CollectionReference _kelas =
      FirebaseFirestore.instance.collection('kelas');

  Map<String, bool> _isChecked = {};

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String dayOfWeek = DateFormat('EEEE').format(now);

    int session = 1;
    
    if ((dayOfWeek == 'Monday') || (dayOfWeek == 'Wednesday') || (dayOfWeek == 'Firday')) {
      session = 1;
    } else if ((dayOfWeek == 'Tuesday') || (dayOfWeek == 'Thursday') || (dayOfWeek == 'Saturday')) {
      session = 2;
    }
    
    int sesi = 2;
    
    if ((dayOfWeek == 'Tuesday') || (dayOfWeek == 'Thursday') || (dayOfWeek == 'Saturday')) {
      sesi = 1;
    } else if ((dayOfWeek == 'Monday') || (dayOfWeek == 'Wednesday') || (dayOfWeek == 'Firday')) {
      sesi = 2;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(40, 50, 40, 40),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chair_alt_outlined,
                            color: Colors.black,
                          ),
                          Text("Absensi",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              )))
                        ],
                      ),
                    ),
                    Text("1/5",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        )))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 5, bottom: 3),
                      child: Text(
                        "sesi 1",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700)),
                      )),
                  SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: StreamBuilder(
                      // stream: _kelas.snapshots(),
                      stream:  _kelas
                            .where('sesi', isEqualTo: session)
                            .snapshots(),
                      builder: (context, AsyncSnapshot snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            color: Colors.green,
                          );
                        }
      
                        if (snapshots.hasData) {
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot records =
                                    snapshots.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AbsensiDataSiswaPage(
                                          data: records, // kirim data yang dipilih ke halaman detail
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    width: double.maxFinite,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 2, color: Colors.black12)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          records['nama'],
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Checkbox(
                                          // value: _isChecked,
                                          value: _isChecked[records.id] ?? false,
                                          onChanged: (value) {
                                            setState(() {
                                              // _isChecked = value!;
                                              _isChecked[records.id] =
                                                  value ?? false;
                                            });
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          checkColor: Colors.black,
                                          activeColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
      
                        return CircularProgressIndicator(
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 5, bottom: 3),
                      child: Text(
                        "sesi 2",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700)),
                      )),
                  SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: StreamBuilder(
                      // stream: _kelas.snapshots(),
                      stream:  _kelas
                            .where('sesi', isEqualTo: sesi)
                            .snapshots(),
                      builder: (context, AsyncSnapshot snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            color: Colors.green,
                          );
                        }
      
                        if (snapshots.hasData) {
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot records =
                                    snapshots.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AbsensiDataSiswaPage(
                                          data: records, // kirim data yang dipilih ke halaman detail
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    width: double.maxFinite,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 2, color: Colors.black12)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          records['nama'],
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Checkbox(
                                          // value: _isChecked,
                                          value: _isChecked[records.id] ?? false,
                                          onChanged: (value) {
                                            setState(() {
                                              // _isChecked = value!;
                                              _isChecked[records.id] =
                                                  value ?? false;
                                            });
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          checkColor: Colors.black,
                                          activeColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
      
                        return CircularProgressIndicator(
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
