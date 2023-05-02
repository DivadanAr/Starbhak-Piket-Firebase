import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_starbhak_piket/components/bottomNavigation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class RekapitulasiPage extends StatefulWidget {
  const RekapitulasiPage({super.key});

  @override
  State<RekapitulasiPage> createState() => _RekapitulasiPageState();
}

class _RekapitulasiPageState extends State<RekapitulasiPage> {
  final CollectionReference _siswa =
      FirebaseFirestore.instance.collection('siswa');

  final CollectionReference _kelas =
      FirebaseFirestore.instance.collection('kelas');

  final CollectionReference _absensi =
      FirebaseFirestore.instance.collection('Absensi');

  final CollectionReference _keterlambatan =
      FirebaseFirestore.instance.collection('keterlambatan');

  final String dayOfWeek = DateFormat('EEEE').format(DateTime.now());

  int _jumlahSiswa = 0;
  int _jumlahKelasSesi1 = 0;
  int _jumlahKelasSesi2 = 0;
  int _jumlahAbsensiSesi1 = 0;
  int _jumlahAbsensiSesi2 = 0;

  List<String> izin = [];
  List<String> sakit = [];
  List<String> alfa = [];

  List<String> namaTerlambat= [];

  List<String> kelasTerlambat= [];


  @override
  void initState() {
    super.initState();
    _getJumlahKelasSesi1();
    _getJumlahKelasSesi2();
    _getJumlahAbsensiSesi1();
    _getJumlahAbsensiSesi2();
    _getAbsensiData();
    _getJumlahSiswa();
    _getDataTerlambat();
  }

  void _getJumlahSiswa() async {
    QuerySnapshot querySnapshot = await _siswa.get();
    setState(() {
      _jumlahSiswa = querySnapshot.size;
    });
  }

  void _getAbsensiData() async {
    QuerySnapshot querySnapshot = await _absensi.get();
    querySnapshot.docs.forEach((doc) {
      izin.add(doc['izin'].toString());
      sakit.add(doc['sakit'].toString());
      alfa.add(doc['alfa'].toString());
    });
    setState(() {}); // memperbarui tampilan setelah data berhasil diambil
  }

  void _getDataTerlambat() async {
    QuerySnapshot querySnapshot = await _keterlambatan.get();
    querySnapshot.docs.forEach((doc) {
      namaTerlambat.add(doc['nama'].toString());
      kelasTerlambat.add(doc['kelas'].toString());
    });
    setState(() {}); // memperbarui tampilan setelah data berhasil diambil
  }

  Future<void> _getJumlahKelasSesi1() async {
    int session = 1;
    if ((dayOfWeek == 'Monday') ||
        (dayOfWeek == 'Wednesday') ||
        (dayOfWeek == 'Firday')) {
      session = 1;
    } else if ((dayOfWeek == 'Tuesday') ||
        (dayOfWeek == 'Thursday') ||
        (dayOfWeek == 'Saturday')) {
      session = 2;
    }
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('kelas')
          .where('sesi', isEqualTo: session)
          .get();
      final int jumlahKelasSesi1 = querySnapshot.docs.length;
      setState(() {
        _jumlahKelasSesi1 = jumlahKelasSesi1;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getJumlahKelasSesi2() async {
    int session = 1;
    if ((dayOfWeek == 'Monday') ||
        (dayOfWeek == 'Wednesday') ||
        (dayOfWeek == 'Firday')) {
      session = 2;
    } else if ((dayOfWeek == 'Tuesday') ||
        (dayOfWeek == 'Thursday') ||
        (dayOfWeek == 'Saturday')) {
      session = 1;
    }
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('kelas')
          .where('sesi', isEqualTo: session)
          .get();
      final int jumlahKelasSesi2 = querySnapshot.docs.length;
      setState(() {
        _jumlahKelasSesi2 = jumlahKelasSesi2;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getJumlahAbsensiSesi1() async {
    int session = 1;
    if ((dayOfWeek == 'Monday') ||
        (dayOfWeek == 'Wednesday') ||
        (dayOfWeek == 'Firday')) {
      session = 1;
    } else if ((dayOfWeek == 'Tuesday') ||
        (dayOfWeek == 'Thursday') ||
        (dayOfWeek == 'Saturday')) {
      session = 2;
    }

    initializeDateFormatting('id_ID');
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    final DateTime now = DateTime.now();
    final String formattedDate = formatter.format(now);

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('absensi')
          .where('sesi', isEqualTo: session)
          .where('tanggal', isEqualTo: formattedDate)
          .get();
      final int jumlahAbsensiSesi1 = querySnapshot.docs.length;
      setState(() {
        _jumlahAbsensiSesi1 = jumlahAbsensiSesi1;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getJumlahAbsensiSesi2() async {
    int session = 1;
    if ((dayOfWeek == 'Monday') ||
        (dayOfWeek == 'Wednesday') ||
        (dayOfWeek == 'Firday')) {
      session = 2;
    } else if ((dayOfWeek == 'Tuesday') ||
        (dayOfWeek == 'Thursday') ||
        (dayOfWeek == 'Saturday')) {
      session = 1;
    }

    initializeDateFormatting('id_ID');
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    final DateTime now = DateTime.now();
    final String formattedDate = formatter.format(now);

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('absensi')
          .where('sesi', isEqualTo: session)
          .where('tanggal', isEqualTo: formattedDate)
          .get();
      final int jumlahAbsensiSesi2 = querySnapshot.docs.length;
      setState(() {
        _jumlahAbsensiSesi2 = jumlahAbsensiSesi2;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
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
                      child: Text("Rekapitulasi",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ))),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(dayDate,
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ))),
                    Text(formattedDate,
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        )))
                  ],
                )
              ],
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Absensi Hari Ini',
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    width: 350,
                    height: 365,
                    decoration: BoxDecoration(
                        color: Color(0xff7F669D),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          width: 300,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Sesi 1',
                                            style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ))),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          margin: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: Colors.black45,
                                                      style: BorderStyle.solid,
                                                      width: 2))),
                                          child: Text(
                                              '$_jumlahAbsensiSesi1/$_jumlahKelasSesi1 Kelas',
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black45,
                                                fontSize: 15,
                                              ))),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        child: _jumlahAbsensiSesi1 >=
                                                _jumlahKelasSesi1
                                            ? Icon(
                                                Icons.check_circle,
                                                size: 30,
                                                color: Color(0xff00726D),
                                              )
                                            : Container())
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Sesi 2',
                                            style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ))),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          margin: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: Colors.black45,
                                                      style: BorderStyle.solid,
                                                      width: 2))),
                                          child: Text(
                                              '$_jumlahAbsensiSesi2/$_jumlahKelasSesi2 Kelas',
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black45,
                                                fontSize: 15,
                                              ))),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        child: _jumlahAbsensiSesi2 >=
                                                _jumlahKelasSesi2
                                            ? Icon(
                                                Icons.check_circle,
                                                size: 30,
                                                color: Color(0xff00726D),
                                              )
                                            : Container())
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: 300,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Jumlah Siswa Hadir',
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 15,
                                    )),
                                  ),
                                  Text(
                                    '$_jumlahSiswa',
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 15,
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Jumlah Siswa Tidak Hadir',
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                                  ),
                                  Text(
                                    (izin.length + alfa.length + sakit.length).toString(),
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.download),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Unduh Laporan Absensi',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Laporan KenamaTerlambatan',
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18,
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    padding: EdgeInsets.only(top: 5, bottom: 20),
                    width: 350,
                    decoration: BoxDecoration(
                        color: Color(0xff7F669D),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, right: 20),
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Jumlah Siswa namaTerlambat',
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 15,
                                    )),
                                  ),
                                  Text(
                                    namaTerlambat.length.toString(),
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 15,
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              padding:
                                  EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                style: BorderStyle.solid,
                                                width: 2,
                                                color: Colors.black45))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'No',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Nama',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Kelas',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    itemCount: namaTerlambat.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              (index+1).toString(),
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black87,
                                                fontSize: 15,
                                              )),
                                            ),
                                            Container(
                                              width: 130,
                                              child: Text(
                                                namaTerlambat[index],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                )),
                                              ),
                                            ),
                                            Text(
                                              kelasTerlambat[index],
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black87,
                                                fontSize: 14.5,
                                              )),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.download),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Unduh Laporan Absensi',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Laporan Kunjungan Tamu',
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18,
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    padding: EdgeInsets.only(top: 5),
                    width: 350,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Color(0xff7F669D),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, right: 20),
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Jumlah Tamu Berkunjung',
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 15,
                                    )),
                                  ),
                                  Text(
                                    '3',
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 15,
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              padding:
                                  EdgeInsets.only(top: 15, left: 20, right: 20),
                              width: 300,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                style: BorderStyle.solid,
                                                width: 2,
                                                color: Colors.black45))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'No',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Nama',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Instansi',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '1',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Thomas Jefri',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'PT MNC',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '2',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Jajang ST.',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Ortu Siswa',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '3',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Alfiansyah',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        ),
                                        Text(
                                          'Kelurahan',
                                          style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: 15,
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.download),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Unduh Laporan Buku Tamu',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                              )
                            ],
                          ),
                        )
                      ],
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
