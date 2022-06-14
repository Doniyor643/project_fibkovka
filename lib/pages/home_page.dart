import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_fibkovka/services/database_service.dart';

import '../services/users.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DatabaseService _service = DatabaseService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dates'),
      ),
      body: _allUsers(),
    );
  }

  /// Barcha foydalanuvchilarni o'qish
  Widget _allUsers() =>
    StreamBuilder<List<Work>>(
      stream: _service.readUserWork(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text("Error !!!!!!!!! ${snapshot.error}");
        }else if(snapshot.hasData){
          final works = snapshot.data;
          return ListView(
            children: works!.map(buildUserWorks).toList(),);
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );

  // Widget _oneUser() =>
  //   FutureBuilder<Users?>(
  //     future: _service.readUser(name: 'Doniyor',family: "643"),
  //     builder: (context, snapshot){
  //       if(snapshot.hasData){
  //         final work = snapshot.data;
  //         return work == null
  //             ?
  //           const Center(child: Text("No user"),)
  //             :
  //           buildUserWorks(work);
  //       }else if(snapshot.hasError){
  //         Text("Error !!!!!!!!!!!!!!! ${snapshot.error}");
  //       }
  //         return const Center(child: CircularProgressIndicator(),);
  //
  //     },
  //   );


  Widget buildUserWorks(Work works) {
    return ExpansionTile(
      title: Text(works.name),
      subtitle: Text(works.text),
      children: [

      ],

    );

  }


}
