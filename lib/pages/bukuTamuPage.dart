import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class BukuTamuPage extends StatefulWidget {
  const BukuTamuPage({super.key});

  @override
  State<BukuTamuPage> createState() => _BukuTamuPageState();
}

class _BukuTamuPageState extends State<BukuTamuPage> {
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
              height: 250,
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
                    "Buku Tamu",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold, color: Colors.black),
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
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Daftar Tamu",
                  style: GoogleFonts.quicksand(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 320, left: 15),
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, snapshot) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "08.00",
                                style: GoogleFonts.quicksand(
                                    // fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 300,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 205, top: 5),
                                        child: Text(
                                          "Design Marketing",
                                          style: GoogleFonts.quicksand(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "UI Design",
                                            style: GoogleFonts.quicksand(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          const Icon(Icons.more_vert_outlined),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.only(top: 510, left: 320),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xff7F669D),
                    borderRadius: BorderRadius.circular(6)),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
