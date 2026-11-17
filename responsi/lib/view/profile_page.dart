import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/library.dart';
import '../../route/app_rute.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = '-';

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }
  void _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? '-';
    });
  }
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginData');
    await prefs.remove('email');
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 44,
                backgroundColor: Color(0xFF1C1C1E),
                child: Icon(Icons.person, size: 48, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                _email,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
               ValueListenableBuilder<Box<Library>>(
                valueListenable: Hive.box<Library>('library').listenable(),
                builder: (context, box, child) => Text(
                  'Jumlah game di library: ${box.length}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),
                onPressed: _logout, 
              child: 
              const Text('Logout')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
