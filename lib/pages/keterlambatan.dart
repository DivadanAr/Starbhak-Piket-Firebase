import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_starbhak_piket/components/bottomNavigation.dart';
import 'package:project_starbhak_piket/controllers/keterlambatanController.dart';
import 'package:project_starbhak_piket/models/keterlambatamModel.dart';
import 'package:project_starbhak_piket/pages/absensiDataSiswaPage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class KeterlambatanPage extends StatefulWidget {
  const KeterlambatanPage({super.key});

  @override
  State<KeterlambatanPage> createState() => _KeterlambatanPageState();
}

class _KeterlambatanPageState extends State<KeterlambatanPage> {
  final alasanController = TextEditingController();
  List<Map<String, dynamic>> _keterlambatanList = [];
  List<String> _listKelas = [];
  List<String> _listSiswa = [];

  String? _selectedKelas;
  String? _selectedSiswa;

  void initState() {
    super.initState();
    getDataKelas().then((listKelas) {
      setState(() {
        _listKelas = listKelas;
      });
    });
    getDataSiswa().then((listSiswa) {
      setState(() {
        _listSiswa = listSiswa;
      });
    });
  }

  Future<List<String>> getDataKelas() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('kelas')
        .where('kelas', whereIn: [10, 11, 12]).get();
    return snapshot.docs.map((doc) => doc['nama'].toString()).toList();
  }

  Future<List<String>> getDataSiswa() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('siswa')
        .where('kelas', isEqualTo: _selectedKelas)
        .get();
    return snapshot.docs.map((doc) => doc['nama'].toString()).toList();
  }

  // void _addSiswa() {
  //   setState(() {
  //     _keterlambatanList.add({
  //       'kelas': _selectedKelas ?? '',
  //       'nama': _selectedSiswa ?? '',
  //       'alasan': '',
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    final DateTime now = DateTime.now();
    final String formattedDate = formatter.format(now);

    final DateFormat month = DateFormat('MMMM', 'id_ID');
    final DateTime monthNow = DateTime.now();
    final String monthDate = month.format(monthNow);

    final DateFormat day = DateFormat('EEEE', 'id_ID');
    final DateTime dayNow = DateTime.now();
    final String dayDate = day.format(dayNow);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 45, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 220,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        // border: Border.all(width: 1.5, color: Color.fromARGB(255, 89, 89, 89))
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                            blurRadius: 5,
                            color: Colors.black38,
                          )
                        ]),
                    child: Container(
                      child: Center(
                        child: Text("Keterlambatan Siswa",
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ))),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Rabu',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ))),
                      Text('20 April 2023',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          )))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 350,
              height: 420,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                      blurRadius: 5,
                      color: Colors.black38,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kelas',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ))),
                      Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid, color: Colors.black38),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedKelas,
                          items: _listKelas.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? selectedItem) {
                            setState(() {
                              _selectedKelas = selectedItem;
                            });
                            getDataSiswa().then((listSiswa) {
                              setState(() {
                                _listSiswa = listSiswa;
                              });
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade700,
                          ),
                          isExpanded: true,
                          underline: SizedBox(),
                          hint: Text(
                            'Pilih Kelas Siswa',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ))),
                      Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid, color: Colors.black38),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedSiswa,
                          items: _listSiswa.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? selectedItem) {
                            setState(() {
                              _selectedSiswa = selectedItem;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade700,
                          ),
                          isExpanded: true,
                          underline: SizedBox(),
                          hint: Text(
                            'Pilih Kelas Siswa',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alasan',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ))),
                      SizedBox(height: 7),
                      TextField(
                        controller: alasanController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // radius
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 113, 113, 113)),
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // ListView.builder(
            //     padding: EdgeInsets.zero,
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemCount: 1 + _keterlambatanList.length,
            //     itemBuilder: (context, snapshot) {
            //       return Container(
            //         padding: EdgeInsets.all(25),
            //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //         width: 350,
            //         height: 370,
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.all(Radius.circular(20)),
            //             boxShadow: [
            //               BoxShadow(
            //                 offset: Offset(0, 2),
            //                 spreadRadius: 0,
            //                 blurRadius: 5,
            //                 color: Colors.black38,
            //               )
            //             ]),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Kelas',
            //                     style: GoogleFonts.quicksand(
            //                         textStyle: TextStyle(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 16,
            //                     ))),
            //                 Container(
            //                   width: 300,
            //                   height: 50,
            //                   margin: EdgeInsets.only(top: 5),
            //                   padding: EdgeInsets.symmetric(horizontal: 12),
            //                   decoration: BoxDecoration(
            //                     border: Border.all(
            //                         style: BorderStyle.solid,
            //                         color: Colors.black38),
            //                     color: Colors.white,
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(12)),
            //                   ),
            //                   child: DropdownButton<String>(
            //                     value: _selectedKelas,
            //                     items: _listKelas.map((String value) {
            //                       return DropdownMenuItem<String>(
            //                         value: value,
            //                         child: Text(
            //                           value,
            //                           style: TextStyle(
            //                             color: Colors.black54,
            //                             fontSize: 16.0,
            //                           ),
            //                         ),
            //                       );
            //                     }).toList(),
            //                     onChanged: (String? selectedItem) {
            //                       setState(() {
            //                         _selectedKelas = selectedItem;
            //                       });
            //                       getDataSiswa().then((listSiswa) {
            //                         setState(() {
            //                           _listSiswa = listSiswa;
            //                         });
            //                       });
            //                     },
            //                     icon: Icon(
            //                       Icons.arrow_drop_down,
            //                       color: Colors.grey.shade700,
            //                     ),
            //                     isExpanded: true,
            //                     underline: SizedBox(),
            //                     hint: Text(
            //                       'Pilih Kelas Siswa',
            //                       style: TextStyle(
            //                         color: Colors.grey.shade700,
            //                         fontSize: 16.0,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Nama',
            //                     style: GoogleFonts.quicksand(
            //                         textStyle: TextStyle(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 16,
            //                     ))),
            //                 Container(
            //                   width: 300,
            //                   height: 50,
            //                   margin: EdgeInsets.only(top: 5),
            //                   padding: EdgeInsets.symmetric(horizontal: 12),
            //                   decoration: BoxDecoration(
            //                     border: Border.all(
            //                         style: BorderStyle.solid,
            //                         color: Colors.black38),
            //                     color: Colors.white,
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(12)),
            //                   ),
            //                   child: DropdownButton<String>(
            //                     value: _selectedSiswa,
            //                     items: _listSiswa.map((String value) {
            //                       return DropdownMenuItem<String>(
            //                         value: value,
            //                         child: Text(
            //                           value,
            //                           style: TextStyle(
            //                             color: Colors.black54,
            //                             fontSize: 16.0,
            //                           ),
            //                         ),
            //                       );
            //                     }).toList(),
            //                     onChanged: (String? selectedItem) {
            //                       setState(() {
            //                         _selectedSiswa = selectedItem;
            //                       });
            //                     },
            //                     icon: Icon(
            //                       Icons.arrow_drop_down,
            //                       color: Colors.grey.shade700,
            //                     ),
            //                     isExpanded: true,
            //                     underline: SizedBox(),
            //                     hint: Text(
            //                       'Pilih Kelas Siswa',
            //                       style: TextStyle(
            //                         color: Colors.grey.shade700,
            //                         fontSize: 16.0,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Alasan',
            //                     style: GoogleFonts.quicksand(
            //                         textStyle: TextStyle(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 16,
            //                     ))),
            //                 TextField(
            //                   maxLines: 5,
            //                   decoration: InputDecoration(
            //                     focusedBorder: OutlineInputBorder(
            //                       borderRadius:
            //                           BorderRadius.circular(10.0), // radius
            //                       borderSide: BorderSide(
            //                           width: 1, color: Color.fromARGB(255, 113, 113, 113)),
            //                     ),
            //                     labelStyle: TextStyle(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 16,
            //                     ),
            //                     border: OutlineInputBorder(
            //                       borderRadius:
            //                           BorderRadius.all(Radius.circular(10)),
            //                       borderSide: BorderSide(
            //                         color: Colors.black38,
            //                         style: BorderStyle.solid,
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ],
            //         ),
            //       );
            //     }),
            // Container(
            //   width: 350,
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.all(Radius.circular(10)),
            //       boxShadow: [
            //         BoxShadow(
            //           offset: Offset(0, 2),
            //           spreadRadius: 0,
            //           blurRadius: 5,
            //           color: Colors.black38,
            //         )
            //       ]),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       _addSiswa();
            //     },
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       elevation: 5,
            //     ),
            //     child: Container(
            //       margin: EdgeInsets.only(left: 30, right: 30),
            //       child: Text(
            //         '+ Tambah Siswa Baru',
            //         style: GoogleFonts.quicksand(
            //           textStyle: TextStyle(
            //             fontWeight: FontWeight.w700,
            //             fontSize: 16,
            //             color: Colors.black87,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xff7F669D),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                      blurRadius: 5,
                      color: Colors.white,
                    )
                  ]),
              child: ElevatedButton(
                onPressed: () {
                  final keterlambatan_add = keterlambatan_model(
                    nama: _selectedSiswa,
                    kelas: _selectedKelas,
                    keterangan: alasanController.text,
                    tanggal: formattedDate,
                    bulan: monthDate,
                    hari: dayDate,
                  );
                  setState(() {
                    _selectedKelas = null;
                    _selectedSiswa = null;
                    alasanController.clear();
                  });

                  keterlambatan_controller()
                      .add_keterlambatan(keterlambatan_add);
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
            )
          ],
        ),
      ),
    );
  }
}
