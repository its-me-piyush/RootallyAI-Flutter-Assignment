import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rootally_ai_internship/screens/auth/components/authentication_service.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final dref = FirebaseDatabase.instance.reference();
  late DatabaseReference _databaseReference;

  @override
  void initState() {
    _databaseReference = dref;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50, left: 20),
              child: const Text(
                'Good Morning ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                'Jane',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: const Text(
                'You have only 4 sessions',
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                'today',
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            FirebaseAnimatedList(
              shrinkWrap: true,
              query: _databaseReference,
              itemBuilder: (context, snapshot, animation, index) {
                var trial = snapshot.value;
                List<DataModel> _list = [];
                trial.forEach((key, value) {
                  _list.add(
                    DataModel(
                      performedAt: value['performedAt'],
                      program: value['program'],
                      title: value['title'],
                      isCompleted: value['isCompleted'],
                    ),
                  );
                });
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Timeline.builder(
                      position: TimelinePosition.Left,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) => TimelineModel(
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _list[index].title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: FittedBox(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.fitness_center_sharp,
                                                  color: Colors.blue,
                                                ),
                                                Text(
                                                  _list[index].program,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (_list[index].isCompleted)
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.blue[900],
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5,
                                                  bottom: 5,
                                                  left: 10,
                                                  right: 10),
                                              child: const Text(
                                                'Completed',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (_list[index].isCompleted)
                                          const Text(
                                            'Performed At',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        if (_list[index].isCompleted)
                                          Text(
                                            _list[index].performedAt,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              // color: Colors.blue,
                                            ),
                                          ),
                                        if (!_list[index].isCompleted)
                                          Row(
                                            children: const [
                                              Icon(Icons.play_arrow_rounded),
                                              Text(
                                                'Finish Session',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  // color: Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (!_list[index].isCompleted)
                                          Text(
                                            ' $index to start',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              // color: Colors.blue,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: 110,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.red,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/session${index + 1}.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            icon: Icon(
                              index < 2
                                  ? Icons.check
                                  : Icons.blur_circular_rounded,
                              color: Colors.white,
                            ),
                            position: TimelineItemPosition.right,
                            iconBackground:
                                index < 2 ? Colors.blue.shade900 : Colors.grey,
                          ),
                      itemCount: _list.length),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class DataModel {
  final String performedAt;
  final String program;
  final String title;
  final bool isCompleted;
  DataModel({
    required this.performedAt,
    required this.program,
    required this.title,
    required this.isCompleted,
  });
}
