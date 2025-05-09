import 'package:flutter/material.dart';
import 'package:hiappy/screens/home/PatientHome/EditAccount/EditAccount.dart';
import 'package:hiappy/screens/home/PatientHome/PaymentDetails/Payment.dart';
import 'package:hiappy/screens/home/PatientHome/RenewalSubscription/RenewalSubscription.dart';

void main() {
  runApp(
    const MaterialApp(home: AccountSettings(), debugShowCheckedModeBanner: false),
  );
}

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A7BD5), Color(0xFF00d2ff)], // Blue gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Account Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const Divider(color: Colors.white24),

              // List Items
              ListTile(
                leading: const Icon(Icons.payment, color: Colors.white),
                title: const Text(
                  'Edit Account Details',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditAccount()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.verified, color: Colors.white),
                title: const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
               onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RenewalSubscription()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
