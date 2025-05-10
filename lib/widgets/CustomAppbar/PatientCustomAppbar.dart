import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';
import 'package:hiappy/screens/home/PatientHome/Notification/Notification.dart';
import 'package:hiappy/widgets/gradient_button.dart';

class PatientCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? centerImage;
  final String notificationIcon;
  final String sosIcon;
  final bool isHomePage;
  final VoidCallback? onBack;

  const PatientCustomAppBar({
    Key? key,
    this.centerImage,
    this.notificationIcon = 'assets/icons/notification.svg',
    this.sosIcon = 'assets/icons/sos.svg',
    this.isHomePage = false,
    this.onBack,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      leading:
          isHomePage
              ? Builder(
                builder:
                    (context) => IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/Draweropen.svg',
                        width: 20,
                        height: 20,
                        color: Colors.black,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
              )
              : IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(notificationIcon, width: 26, height: 26),
          onPressed: () {
                        Navigator.of(context, rootNavigator: false).push(
                          MaterialPageRoute(builder: (context) => NotificationScreen()),
                        );
                      },
        ),
        IconButton(
          icon: SvgPicture.asset(sosIcon, width: 26, height: 26),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  alignment: Alignment.center,
                  title: const Center(
                    child: Text(
                      'For Emergency Contact',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: SizedBox(
                    width: 400, // 👈 Custom width
                    height: 280, // 👈 Custom height
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GradientButton(
                          title: 'Call Ambulance',
                          textSize: 18,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFB575EA), Color(0xFFEC758F)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: 30,
                          height: 60,
                          width: 300,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        GradientButton(
                          title: 'Call Mentor',
                          textSize: 18,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF75B5EB), Color(0xFF75EC99)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: 30,
                          height: 60,
                          width: 300,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        GradientButton(
                          title: 'Call Family Member',
                          textSize: 18,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF757CF0), Color(0xFF75E9F0)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: 30,
                          height: 60,
                          width: 300,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        GradientButton(
                          title: 'Share Location',
                          textSize: 18,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFB575EA), Color(0xFFEC758F)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: 30,
                          height: 60,
                          width: 300,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Center(
            child:
                centerImage != null
                    ? Image.asset(
                      centerImage!,
                      width: 140,
                      height: 40,
                      fit: BoxFit.contain,
                    )
                    : SvgPicture.asset(
                      'assets/images/default_image.svg',
                      width: 140,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
          ),
        ),
      ),
    );
  }
}
