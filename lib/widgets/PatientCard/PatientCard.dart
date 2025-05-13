import 'package:flutter/material.dart';

class Patient {
  final String name;
  final int age;
  final String gender;
  final String center;
  final String imageUrl;
  final Color? backgroundColor;

  Patient({
    required this.name,
    required this.age,
    required this.gender,
    required this.center,
    required this.imageUrl,
    this.backgroundColor,
  });
}

class PatientCard extends StatefulWidget {
  final List<Patient> patients;
  final bool user; // 👈 New
  final String name; // 👈 New
  final VoidCallback? onSeeMore; // 👈 New: callback for "See More"

  const PatientCard({
    super.key,
    required this.patients,
    required this.user,
    required this.name,
    this.onSeeMore, // 👈 Initialize the callback
  });

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  final PageController _pageController = PageController(viewportFraction: 0.65);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.patients.isNotEmpty
            ? widget.patients.first.backgroundColor ?? Colors.white
            : Colors.white;

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(bottom: 16), // optional padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name and See More button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${widget.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Default color for name
                        ),
                      ),
                      TextSpan(
                        text:
                            "(${widget.patients.length.toString().padLeft(2, '0')})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:
                              Colors.blue, // Change this to your desired color
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.onSeeMore != null)
                  GestureDetector(
                    onTap: widget.onSeeMore,
                    child: const Text(
                      'See More',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Horizontal Card Carousel
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
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
                return _buildPatientCard(patient);
              },
            ),
          ),

          const SizedBox(height: 12),

          // Dots Indicator
          if (widget.user)
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
      ),
    );
  }

  Widget _buildPatientCard(Patient patient) {
    final bool isNetworkImage = patient.imageUrl.startsWith('http');
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8, bottom: 5),
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
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                      : Image.asset(
                        patient.imageUrl,
                        height: 200,
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
