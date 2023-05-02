import 'package:flutter/material.dart';   
import 'package:google_fonts/google_fonts.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class JadwalPiketPage extends StatefulWidget {
  const JadwalPiketPage({super.key});

  @override
  State<JadwalPiketPage> createState() => _JadwalPiketPageState();
}

class _JadwalPiketPageState extends State<JadwalPiketPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff7F669D),
        child: Stack(
          children: <Widget>[
            Container(
              height: 300,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 253, 253, 253),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  )),
            ),
            const Align(
              alignment: Alignment(-0.9, -0.9),
              child: Icon(Icons.arrow_back),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, right: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  width: 150,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 239, 239, 239),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(8, 10), // Shadow position
                      ),
                    ],
                  ),
                  child: Text(
                    "Jadwal Piket",
                    style: GoogleFonts.quicksand(),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 130,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CalendarTimeline(
                    showYears: false,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
                    onDateSelected: (date) =>
                        setState(() => _selectedDate = date),
                    leftMargin: 20,
                    monthColor: Colors.black,
                    dayColor: Colors.teal[200],
                    dayNameColor: const Color.fromARGB(255, 248, 248, 248),
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: const Color(0xff7F669D),
                    dotsColor: const Color.fromARGB(255, 245, 245, 245),
                    selectableDayPredicate: (date) => date.day != 23,
                    locale: 'en',
                  ),
                ],
              ),

              // Container(
              //   width: double.maxFinite,
              //   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //         height: 80,
              //         width: 60,
              //         decoration: const BoxDecoration(
              //           color: Color.fromARGB(255, 239, 239, 239),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey,
              //               blurRadius: 4,
              //               offset: Offset(8, 10), // Shadow position
              //             ),
              //           ],
              //         ),
              //       ),
              //       const Padding(padding: EdgeInsets.only(left: 30)),
              //       Container(
              //         height: 80,
              //         width: 60,
              //         decoration: const BoxDecoration(
              //           color: Color.fromARGB(255, 239, 239, 239),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey,
              //               blurRadius: 4,
              //               offset: Offset(8, 10), // Shadow position
              //             ),
              //           ],
              //         ),
              //       ),
              //       const Padding(padding: EdgeInsets.only(left: 30)),
              //       Container(
              //         height: 80,
              //         width: 60,
              //         decoration: const BoxDecoration(
              //           color: Color.fromARGB(255, 239, 239, 239),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey,
              //               blurRadius: 4,
              //               offset: Offset(8, 10), // Shadow position
              //             ),
              //           ],
              //         ),
              //       ),
              //       const Padding(padding: EdgeInsets.only(left: 30)),
              //       Container(
              //         height: 80,
              //         width: 60,
              //         decoration: const BoxDecoration(
              //           color: Color.fromARGB(255, 239, 239, 239),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey,
              //               blurRadius: 4,
              //               offset: Offset(8, 10), // Shadow position
              //             ),
              //           ],
              //         ),
              //       ),
              //       const Padding(padding: EdgeInsets.only(left: 30)),
              //       Container(
              //         height: 80,
              //         width: 60,
              //         decoration: const BoxDecoration(
              //           color: Color.fromARGB(255, 239, 239, 239),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey,
              //               blurRadius: 4,
              //               offset: Offset(8, 10), // Shadow position
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350, left: 39),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      height: 100,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 244, 244, 244),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: const RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Sesi 1",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 520, left: 39),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      height: 100,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 244, 244, 244),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: const RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Sesi 2",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350, left: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 244, 244, 244),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 520, left: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 244, 244, 244),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 130, top: 540),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xff7F669D),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, left: 10),
                        child: Text(
                          'Yoga sensei',
                          style: GoogleFonts.quicksand(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, left: 10),
                        child: Text(
                          '40 Kelas (1500 siswa)',
                          style: GoogleFonts.quicksand(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40, left: 10),
                        child: Icon(
                          Icons.punch_clock,
                          color: Color.fromARGB(255, 168, 168, 168),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 47, left: 33),
                            child: Text(
                              "08.00-12.00",
                              style: GoogleFonts.quicksand(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 130, top: 370),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xff7F669D),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, left: 10),
                        child: Text(
                          'Yoga sensei',
                          style: GoogleFonts.quicksand(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, left: 10),
                        child: Text(
                          '40 Kelas (1500 siswa)',
                          style: GoogleFonts.quicksand(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40, left: 10),
                        child: Icon(
                          Icons.punch_clock,
                          color: Color.fromARGB(255, 168, 168, 168),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 47, left: 33),
                            child: Text(
                              "08.00-12.00",
                              style: GoogleFonts.quicksand(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 150, top: 30),
                            child: Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff7F669D),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
