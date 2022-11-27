// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gui/location_manager.dart';

class AddDibzzItem extends StatefulWidget {
  const AddDibzzItem({super.key});

  @override
  State<AddDibzzItem> createState() => _AddDibzzItemState();
}

class _AddDibzzItemState extends State<AddDibzzItem> {
  final TextEditingController _nameInput = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _category = TextEditingController();

  CollectionReference dibs = FirebaseFirestore.instance.collection('dibs');
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
  uploadTask = ref.putFile(file);
});
    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
  }

  Future<void> _addDib() {
    LocationManager locationManager = LocationManager();

    double latitude = locationManager.latitude;
    double longitude = locationManager.longitude;

    return dibs
        .add({
          'name': _nameInput.value.text,
          'description': _description.value.text,
          'lat': 44.0262133,
          'long': -88.5530043,
          'category': _category.text,
          'image': '',
        })
        .then((value) => print("Dib Added"))
        .catchError((error) => print("Failed to add Dib: $error"));
  }

  void _clearAdd() {
    _nameInput.clear();
    _description.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: null,
                  decoration: InputDecoration(
                    hintText: 'e.g Table',
                    labelText: 'Item',
                    labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                  controller: _nameInput,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _description,
                  onChanged: null,
                  decoration: InputDecoration(
                    hintText: 'General description of the item',
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 10, //make dynamic
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _category,
                  onChanged: null,
                  decoration: InputDecoration(
                    hintText: 'Category of the item',
                    labelText: 'category',
                    labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 10, //make dynamic
                  minLines: 1,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ([
                  ElevatedButton(
                    onPressed: selectFile,
                    child: const Text(
                      "Select Fle",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  const Text(
                    "Click Button to Upload",
                    style: TextStyle(fontSize: 25),
                  ),
                  IconButton(
                    onPressed: uploadFile,
                    icon: const Icon(
                      Icons.upload,
                      size: 30,
                    ),
                  ),
                  buildProgress(),
                ]),
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  height: 410,
                  width: 410,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(44.0262133, -88.5530043),
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: _clearAdd,
                        child: Text('Cancel')), //TODO: clear user dibs item
                    ElevatedButton(onPressed: _addDib, child: Text('Add Dib'))
                  ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Back to ping',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.blueGrey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 50,
          );
        }
      });
}
