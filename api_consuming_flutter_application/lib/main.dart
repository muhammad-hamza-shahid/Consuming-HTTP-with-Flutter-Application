import 'package:api_consuming_flutter_application/services/notes_service.dart';
import 'package:api_consuming_flutter_application/services/user_preferences.dart';
import 'package:api_consuming_flutter_application/views/note_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void setupLocator(){
  GetIt.I.registerLazySingleton(() => NotesService());
}
void main() async{
  await UserPreferences().init();
  setupLocator();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data;

  @override
  void initState() async{
    data = UserPreferences().data;

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}