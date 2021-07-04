import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'views/form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) => MaterialApp(home: FormPage());
}
