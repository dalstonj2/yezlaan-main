import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

/* ================= ROOT ================= */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaidhyam',
      home: LoginPage(),
    );
  }
}

/* ================= LOGIN ================= */

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameC = TextEditingController();
  final ageC = TextEditingController();
  final phoneC = TextEditingController();

  void login() {
    if (nameC.text.isNotEmpty &&
        ageC.text.isNotEmpty &&
        phoneC.text.length >= 10) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(
            name: nameC.text,
            age: ageC.text,
            phone: phoneC.text,
            loginTime: DateTime.now(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_hospital, size: 90, color: Colors.white),
            const SizedBox(height: 10),
            const Text(
              "Vaidhyam",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            input("Name", nameC),
            const SizedBox(height: 12),
            input("Age", ageC, num: true),
            const SizedBox(height: 12),
            input("Phone Number", phoneC, num: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text("Login", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget input(String hint, TextEditingController c, {bool num = false}) {
    return TextField(
      controller: c,
      keyboardType: num ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

/* ================= HOME ================= */

class HomePage extends StatelessWidget {
  final String name, age, phone;
  final DateTime loginTime;

  const HomePage({
    super.key,
    required this.name,
    required this.age,
    required this.phone,
    required this.loginTime,
  });

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('dd MMM yyyy, hh:mm a').format(loginTime);

    return Scaffold(
      appBar: AppBar(title: const Text("Vaidhyam Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text("Name: $name | Age: $age"),
                subtitle: Text("Phone: $phone\nLogin: $time"),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  bigBtn(
                    context,
                    "AI Doctor",
                    Icons.smart_toy,
                    const AIDoctorPage(),
                  ),
                  bigBtn(
                    context,
                    "Doctors",
                    Icons.video_call,
                    const DoctorListPage(),
                  ),
                  bigBtn(
                    context,
                    "Emergency SOS",
                    Icons.warning,
                    const EmergencyPage(),
                  ),
                  bigBtn(
                    context,
                    "Nearby Hospitals",
                    Icons.local_hospital,
                    const HospitalsPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bigBtn(BuildContext c, String t, IconData i, Widget p) {
    return GestureDetector(
      onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => p)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(i, size: 50),
            const SizedBox(height: 10),
            Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

/* ================= AI DOCTOR ================= */

class AIDoctorPage extends StatefulWidget {
  const AIDoctorPage({super.key});

  @override
  State<AIDoctorPage> createState() => _AIDoctorPageState();
}

class _AIDoctorPageState extends State<AIDoctorPage> {
  final c = TextEditingController();
  String result = "";

  void analyze() {
    final t = c.text.toLowerCase();
    if (t.contains("fever")) {
      result = "Fever detected. Rest and paracetamol advised.";
    } else if (t.contains("cold")) {
      result = "Cold detected. Steam inhalation recommended.";
    } else if (t.contains("cough")) {
      result = "Cough detected. Warm fluids advised.";
    } else {
      result = "Please consult doctors in nearby hospitals immediately.";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Doctor")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: c,
              decoration: const InputDecoration(
                hintText: "Enter symptom (fever / cold / cough)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: analyze, child: const Text("Analyze")),
            const SizedBox(height: 20),
            Text(result, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

/* ================= DOCTOR LIST ================= */

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = [
      "Dr. Ananya • 10 yrs • Apollo",
      "Dr. Rahul • 7 yrs • Fortis",
      "Dr. Meera • 12 yrs • AIIMS",
      "Dr. Arjun • 5 yrs • Manipal",
      "Dr. Sneha • 9 yrs • Narayana",
      "Dr. Kiran • 15 yrs • Care",
      "Dr. Ramesh • 20 yrs • Govt",
      "Dr. Pooja • 6 yrs • Cloudnine",
      "Dr. Varun • 8 yrs • Aster",
      "Dr. Divya • 11 yrs • Max",
      "Dr. Sanjay • 18 yrs • Columbia Asia",
      "Dr. Neha • 4 yrs • Rainbow",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Doctor Consultation")),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.person),
          title: Text(doctors[i]),
          trailing: const Icon(Icons.video_call),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VideoCallPage()),
            );
          },
        ),
      ),
    );
  }
}

/* ================= DUMMY VIDEO CALL ================= */

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person, size: 120, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Doctor on Call",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.call_end),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= EMERGENCY ================= */

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency SOS")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.all(40),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("SOS sent to hospitals & family")),
            );
          },
          child: const Text("SOS", style: TextStyle(fontSize: 32)),
        ),
      ),
    );
  }
}

/* ================= HOSPITALS ================= */

class HospitalsPage extends StatelessWidget {
  const HospitalsPage({super.key});

  Future<void> openMaps() async {
    final uri = Uri.parse(
      "https://www.google.com/maps/search/hospitals+near+me",
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Hospitals")),
      body: Center(
        child: ElevatedButton(
          onPressed: openMaps,
          child: const Text("Open Google Maps"),
        ),
      ),
    );
  }
}
