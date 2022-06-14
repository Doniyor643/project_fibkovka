import 'dart:io';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:project_fibkovka/pages/add_working_page.dart';
import 'package:project_fibkovka/pages/update_working_page.dart';

import '../services/database_service.dart';
import '../services/users.dart';

class WorkingPage extends StatefulWidget {
  static const String id = 'working_page';
  const WorkingPage({Key? key}) : super(key: key);

  @override
  State<WorkingPage> createState() => _WorkingPageState();
}

class _WorkingPageState extends State<WorkingPage> {

  int allSumma = 0;
  final DatabaseService _service = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mening ishlarim"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, AddWorkingPage.id);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: _allUsers(),
    );
  }
  /// Barcha foydalanuvchilarni o'qish
  Widget _allUsers() =>
      StreamBuilder<List<Work>>(
        stream: _service.readUserWork(),
        builder: (context,snapshot){
          List<Work>?list = snapshot.data;
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
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.cyan)
        )
      ),
      child: ExpansionTile(
        title: Text(works.name),
        subtitle: Text(works.text),
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(works.urlAddress), //Image.file(File(_selectedFile.path)),
                  fit: BoxFit.cover
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, UpdateWorkingPage.id);
                    },
                    icon: const Icon(Icons.drive_file_rename_outline),
                color: Colors.red,),
                // Pastki panel
                Container(
                  height: 80,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(color: Colors.greenAccent)
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(works.name,
                            style: const TextStyle(fontSize: 15,),),
                          Container(
                            height: 70,
                            width: 2,
                            color: Colors.grey,
                          ),
                          Text(works.summa,
                            style: const TextStyle(fontSize: 15,),),
                          Container(
                            height: 70,
                            width: 2,
                            color: Colors.grey,
                          ),
                          Text(works.number.toString(),
                            style: const TextStyle(fontSize: 15,),),
                          Container(
                            height: 70,
                            width: 2,
                            color: Colors.grey,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Jami summa:"),
                              Text(_addSumma(works).toString(),
                                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      )
                ),
              ],
            ),
            ),
        ],
      ),
    );
  }

  int _addSumma(Work work){
    int summa = int.parse(work.summa);
    int number = int.parse(work.number);
    int all = summa * number;

    return all;
  }
}
