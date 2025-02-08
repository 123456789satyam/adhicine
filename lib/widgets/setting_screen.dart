import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void handleSignOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            child: const Text("Sign Out", style: TextStyle(color: Colors.red)),
          ),
        ],
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/WhatsApp%20Image%202025-02-07%20at%207.13.43%20PM%20(1)-hlbx4sQ39SWm4axRf79fOvWcz83NN0.jpeg'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Take Care!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Richa Bose',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Settings Section
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingItem(Icons.notifications_none, 'Notification',
                  'Check your medicine notification'),
              _buildSettingItem(
                  Icons.volume_up_outlined, 'Sound', 'Ring, Silent, Vibrate'),
              _buildSettingItem(Icons.person_outline, 'Manage Your Account',
                  'Password, Email ID, Phone Number'),
              _buildSettingItem(Icons.notifications_none, 'Notification',
                  'Check your medicine notification'),
              _buildSettingItem(Icons.notifications_none, 'Notification',
                  'Check your medicine notification'),

              // Device Section
              const SizedBox(height: 24),
              const Text(
                'Device',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              _buildDeviceCard(
                  Icons.bluetooth, 'Connect', 'Bluetooth, Wi-Fi', true),
              const SizedBox(height: 12),
              _buildDeviceCard(Icons.volume_up, 'Sound Option',
                  'Ring, Silent, Vibrate', false),

              // Caretakers Section
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Caretakers',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '03',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildCaretakersRow(),

              // Doctor Section
              const SizedBox(height: 24),
              const Text(
                'Doctor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              _buildAddDoctorButton(),

              // Footer Links
              const SizedBox(height: 32),
              _buildFooterLink('Privacy Policy'),
              _buildFooterLink('Terms of Use'),
              _buildFooterLink('Rate Us'),
              _buildFooterLink('Share'),

              // Log Out Button
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Text('Log Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 24),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  Widget _buildDeviceCard(
      IconData icon, String title, String subtitle, bool isFirst) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaretakersRow() {
    return Row(
      children: [
        _buildCaretakerAvatar('Dipa Luna'),
        const SizedBox(width: 12),
        _buildCaretakerAvatar('Roz Soul'),
        const SizedBox(width: 12),
        _buildCaretakerAvatar('Sunny Tu'),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildCaretakerAvatar(String name) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAddDoctorButton() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Add Your Doctor',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Or use ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'invite link',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[700],
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
