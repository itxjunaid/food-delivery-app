import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;
  bool locationEnabled = true;
  bool privacyPolicyEnabled = true;
  String selectedLanguage = "English (US)";

  final List<Map<String, dynamic>> languages = [
    {"name": "Indonesia", "flag": "🇮🇩", "code": "id"},
    {"name": "English (US)", "flag": "🇺🇸", "code": "en_US"},
    {"name": "Thailand", "flag": "🇹🇭", "code": "th"},
    {"name": "Chinese", "flag": "🇨🇳", "code": "zh"},
  ];

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 40,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Language',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ...languages
                      .map(
                        (language) => _buildLanguageOption(language, setState),
                      )
                      .toList(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Select',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageOption(
    Map<String, dynamic> language,
    StateSetter setModalState,
  ) {
    final bool isSelected = selectedLanguage == language["name"];
    final Color borderColor = isSelected ? Colors.orange : Colors.grey[300]!;

    return GestureDetector(
      onTap: () {
        setModalState(() {
          selectedLanguage = language["name"];
        });
        setState(() {
          selectedLanguage = language["name"];
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1),
          color: isSelected ? Colors.orange.withOpacity(0.1) : Colors.white,
        ),
        child: Row(
          children: [
            Text(language["flag"], style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 15),
            Text(
              language["name"],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 16),
                ),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.purple, width: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: [
          // PROFILE section
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'PROFILE',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Push Notification
          ListTile(
            title: const Text('Push Notification'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
              activeColor: Colors.white,
              activeTrackColor: Colors.grey[300],
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
            onTap: () {
              setState(() {
                notificationsEnabled = !notificationsEnabled;
              });
            },
          ),

          // Location
          ListTile(
            title: const Text('Location'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            trailing: Switch(
              value: locationEnabled,
              onChanged: (value) {
                setState(() {
                  locationEnabled = value;
                });
              },
              activeColor: Colors.white,
              activeTrackColor: Colors.orange,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
            onTap: () {
              setState(() {
                locationEnabled = !locationEnabled;
              });
            },
          ),

          // Language
          ListTile(
            title: const Text('Language'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedLanguage,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: () {
              _showLanguageBottomSheet();
            },
          ),

          // OTHER section
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'OTHER',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // About Ticketis
          ListTile(
            title: const Text('About Ticketis'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Handle about ticketis
            },
          ),

          // Privacy Policy
          ListTile(
            title: const Text('Privacy Policy'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  child:
                      privacyPolicyEnabled
                          ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple,
                              ),
                            ),
                          )
                          : null,
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: () {
              setState(() {
                privacyPolicyEnabled = !privacyPolicyEnabled;
              });
              // Navigate to privacy policy
            },
          ),

          // Terms and Conditions
          ListTile(
            title: const Text('Terms and Conditions'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Handle terms and conditions
            },
          ),
        ],
      ),
    );
  }
}
