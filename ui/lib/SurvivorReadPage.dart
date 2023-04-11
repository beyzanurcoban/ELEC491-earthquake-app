import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SurvivorReadPage extends StatefulWidget {
  final String ndefUID;

  const SurvivorReadPage({super.key, required this.ndefUID});

  @override
  _SurvivorReadPageState createState() => _SurvivorReadPageState();
}

class _SurvivorReadPageState extends State<SurvivorReadPage> {
  String natID = 'Girilmemiş';
  String name = 'Girilmemiş';
  String surname = 'Girilmemiş';
  String sex = 'Girilmemiş';
  String ageMin = 'Girilmemiş';
  String ageMax = 'Girilmemiş';
  String bloodType = 'Girilmemiş';
  String chronicIllness = 'Girilmemiş';
  double longitude = 0.0;
  double latitude = 0.0;

  late FirebaseFirestore db;

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
    getVictimFromDB();
  }

  Future<void> getVictimFromDB() async {
    final docRef = db.collection('victim').doc(widget.ndefUID);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      final data = docSnap.data()!;
      setState(() {
        natID = data['victim_nat_id'].toString();
        name = data['victim_name'];
        surname = data['victim_surname'];
        sex = data['victim_sex'];
        ageMin = data['victim_age_min'].toString();
        ageMax = data['victim_age_max'].toString();
        bloodType = data['blood_type'];
        chronicIllness = data['chronic_illness'];
        longitude = data['longitude'];
        latitude = data['latitude'];
      });
    } else {
      throw Exception('Failed to fetch victim data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(),
        middle: Text(
          "Depremzede Bilgisi",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          // TODO: Name Surname
                          '$name $surname',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5)),
                        Text(
                          "ndefUID: ${widget.ndefUID}",
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                      ],
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'TC Kimlik No.',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black38,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          natID,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Cinsiyet',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black38,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          sex,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Minimum Yaş',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.black38,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                ageMin,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Maksimum Yaş',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.black38,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                ageMax,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Kan Grubu',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black38,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          bloodType,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Kronik Rahatsızlıklar',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black38,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          chronicIllness,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Son Görülen Konum',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black38,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          '$latitude $longitude',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
