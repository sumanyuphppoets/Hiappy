import 'package:flutter/material.dart';

class Patient {
  final String name;
  final int age;
  final String gender;
  final String center;
  final String imageUrl;

  Patient({
    required this.name,
    required this.age,
    required this.gender,
    required this.center,
    required this.imageUrl,
  });
}

class AssignedPatientCard extends StatefulWidget {
  final List<Patient> patients;

  const AssignedPatientCard({super.key, required this.patients});

  @override
  State<AssignedPatientCard> createState() => _AssignedPatientCardState();
}

class _AssignedPatientCardState extends State<AssignedPatientCard> {
  final PageController _pageController = PageController(viewportFraction: 0.65);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "New Patients (${widget.patients.length.toString().padLeft(2, '0')})",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Horizontal Card Carousel
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.patients.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final patient = widget.patients[index];
              return _buildAssignedPatientCard(patient);
            },
          ),
        ),

        const SizedBox(height: 12),

        // Dots Indicator
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.patients.length, (index) {
              final isActive = _currentIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignedPatientCard(Patient patient) {
    final bool isNetworkImage = patient.imageUrl.startsWith('http');

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child:
                  isNetworkImage
                      ? Image.network(
                        patient.imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/Patientsimg.png',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                      : Image.asset(
                        patient.imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
            ),

            const SizedBox(height: 8),

            Text(
              patient.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              "Age: ${patient.age}, ${patient.gender}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              patient.center,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // implement call functionality if needed
              },
              child: const Text(
                'Call now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
