import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;

  String selectedCurrency = "PKR";

  final Color primaryColor = const Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const Text(
            "Preferences",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: SwitchListTile(
              value: darkMode,
              activeColor: primaryColor,
              secondary: const Icon(Icons.dark_mode),
              title: const Text("Dark Mode"),
              subtitle: const Text("Enable dark theme"),
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            ),
          ),

          const SizedBox(height: 15),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: SwitchListTile(
              value: notifications,
              activeColor: primaryColor,
              secondary: const Icon(Icons.notifications),
              title: const Text("Notifications"),
              subtitle: const Text("Receive reminders"),
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),
          ),

          const SizedBox(height: 15),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: const Icon(Icons.currency_exchange),
              title: const Text("Currency"),
              subtitle: Text(selectedCurrency),
              trailing: DropdownButton<String>(
                value: selectedCurrency,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(
                    value: "PKR",
                    child: Text("PKR"),
                  ),
                  DropdownMenuItem(
                    value: "USD",
                    child: Text("USD"),
                  ),
                  DropdownMenuItem(
                    value: "EUR",
                    child: Text("EUR"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "More",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
              title: const Text("Profile"),
              subtitle: const Text("View your profile"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 12),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFF3E0),
                child: Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
              ),
              title: const Text("Rate App"),
              subtitle: const Text("Leave a review"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 12),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE3F2FD),
                child: Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
              ),
              title: const Text("Share App"),
              subtitle: const Text("Share with your friends"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 12),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFF3E5F5),
                child: Icon(
                  Icons.info,
                  color: Colors.purple,
                ),
              ),
              title: const Text("About App"),
              subtitle: const Text("Expense Splitter Lite v1.0"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Expense Splitter Lite",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2026 Muhammad Hamza",
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.delete_forever),
              label: const Text(
                "Reset All Data",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("All data has been reset."),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}