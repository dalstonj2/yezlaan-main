import 'package:flutter/material.dart';

void main() {
  runApp(const HealthcareApp());
}

class HealthcareApp extends StatelessWidget {
  const HealthcareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Vaidyam'),
          backgroundColor: const Color.fromARGB(255, 106, 126, 160),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_hospital, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Describe your symptoms...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: const Text(
                  'உங்கள் அறிகுறிகளை விவரிக்கவும்',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter symptoms here (e.g., Fever, Cough)',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print("AI is analyzing symptoms...");
                },
                child: const Text('Ask Doctor AI'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_call),
              label: "Call Doctor",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital_outlined),
              label: "Hospitals",
            ),
          ],
        ),
      ),
    );
  }
}
