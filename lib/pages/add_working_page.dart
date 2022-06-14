import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_fibkovka/pages/working_page.dart';
import 'package:project_fibkovka/services/database_service.dart';

import '../services/auth_service.dart';

class AddWorkingPage extends StatefulWidget {
  static const String id = "add_working_page";
  const AddWorkingPage({Key? key}) : super(key: key);

  @override
  State<AddWorkingPage> createState() => _AddWorkingPageState();
}

class _AddWorkingPageState extends State<AddWorkingPage> {

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  late XFile _selectedFile;
  final ImagePicker _picker = ImagePicker();
  String _selectedFileName = "";
  String _upLoadedPath = "";
  bool _isLoading = false;
  String size = 'metr';


  AuthService service = AuthService();
  TextEditingController nameController = TextEditingController();
  TextEditingController sumController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma'lumot kiritish"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(
              children: [
                // Nomi
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Nomi",
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 10,),
                // Narxi
                TextField(
                  keyboardType: TextInputType.number,
                  controller: sumController,
                  decoration: const InputDecoration(
                      labelText: "Narxi",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 10,),
                // Ma'lumot'
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      labelText: "Ma'lumot",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 10,),
                // Size
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: Colors.grey)
                  ),
                  child: ExpansionTile(
                    title: Text(size,style: const TextStyle(fontWeight: FontWeight.bold),),
                    children: [
                      // Meter
                      ListTile(
                        title: const Text("metr"),
                        onTap: (){
                          setState((){
                            size = 'metr';
                          });
                        },
                      ),
                      // Dona
                      ListTile(
                        title: const Text("dona"),
                        onTap: (){
                          setState((){
                            size = 'dona';
                          });
                        },
                      ),
                      // Kilogram
                      ListTile(
                        title: const Text("kg"),
                        onTap: (){
                          setState((){
                            size = 'kg';
                          });
                        },
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 10,),

                // Button Rasm qo'shish
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: _selectedFileName.isEmpty
                      ?
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        _alertDialog();
                        },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.photo_camera_outlined,size: 50,color: Colors.grey,),
                          Text("Rasm qo'shish",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    ),
                  )
                      :
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: FileImage(File(_selectedFile.path)), //Image.file(File(_selectedFile.path)),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: (){
                              _alertDialog();
                            },
                            icon: const Icon(Icons.drive_file_rename_outline),
                            color: Colors.white,)
                    ],)
                  )
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: (){
                    try{
                      String name = nameController.text.trim();
                      String summa = sumController.text.trim();
                      String texts = addressController.text.trim();
                      String sizes = size;
                      String num = '0';
                      if(name.isEmpty && summa.isEmpty && texts.isEmpty){
                        service.flutterToast("Barcha ma'lumotlar kiritilmagan");
                      }else{
                        uploadFile(_selectedFile, name).whenComplete(() => {
                          DatabaseService().addUserWork(name, summa, texts, sizes,num,_upLoadedPath),

                          nameController.clear(),
                          sumController.clear(),
                          addressController.clear(),
                        service.flutterToast("Ma'lumotlar kiritildi").whenComplete(() => {
                          Navigator.pop(context, WorkingPage.id)
                        })
                        });
                      }
                    }catch(e){
                      print(e);
                    }

                  },
                  child: const SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Center(child: Text("Kiritish"),),
                  ))
              ],
            ),
            _isLoading
                ?
            const Center(child: CircularProgressIndicator(),)
                :
            const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Future _alertDialog() => showDialog(
      context: context,
      builder: (context)=>  AlertDialog(
        title: const  Text("Rasm qo'yish"),
        content: const Text("Rasm yuklash uchun quidagilardan birini tanlang :"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: (){
                funSelectFileGallery().whenComplete(() => Navigator.pop(context));
              },
                child: const Text('Gallery'),),
              ElevatedButton(onPressed: (){
                funSelectFileCamera().whenComplete(() => Navigator.pop(context));
              },
                child: const Text('Camera'),)
            ],
          ),

        ],
      ));

  // Galereyadan o'qish
  Future<void> funSelectFileGallery()async{
    final img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile = img as XFile;
      _selectedFileName = img.name.toString();
    });
  }

  // Cameradan o'qish
  Future<void> funSelectFileCamera()async{
    final img = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedFile = img as XFile;
      _selectedFileName = img.name.toString();
    });
  }

  // Serverga jo'natish 2 - usul Jo'natilgan rasm nomi o'zgarib boradi
  Future<void> uploadFile(XFile xFile,String name)async{
    String fileNameHour = DateTime.now().millisecond.toString();
    Reference reference = _firebaseStorage
        .ref()
        .child('Working')
        .child("WorkPhoto")
        .child('${name}_$fileNameHour');
    UploadTask uploadTask = reference.putFile(File(xFile.path));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _isLoading = true;
      });
    });

    await uploadTask.whenComplete(() async {
      _upLoadedPath = await uploadTask.snapshot.ref.getDownloadURL();
      print(_upLoadedPath);
      setState(() {
        _isLoading = false;
      });
    });
  }
}
