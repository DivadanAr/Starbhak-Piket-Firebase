import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_starbhak_piket/pages/absensiDataSiswaPage.dart';

class keterlambatan_model {
  String? id;
  String? nama;
  String? kelas;
  String? keterangan;
  String? bulan;
  String? hari;
  String? tanggal;

  keterlambatan_model({
    this.id,
    this.nama,
    this.kelas,
    this.keterangan,
    this.bulan,
    this.hari,
    this.tanggal,
  });

    Map<String, dynamic> add_data() {
    return {
      "nama": nama,
      "kelas": kelas,
      "keterangan": keterangan,
      "bulan": bulan,
      "hari": hari,
      "tanggal": tanggal,
    };
  }



}
