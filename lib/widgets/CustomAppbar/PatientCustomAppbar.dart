import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/core/constants/colors.dart';

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
      title: null,
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
                onPressed:
                    onBack ??
                    () {
                       Navigator.of(context).maybePop(); 
                    },
              ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(notificationIcon, width: 26, height: 26),
          onPressed: () {
            // TODO: Handle notification tap
          },
        ),
        IconButton(
          icon: SvgPicture.asset(sosIcon, width: 26, height: 26),
          onPressed: () {
            // TODO: Handle SOS tap
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
