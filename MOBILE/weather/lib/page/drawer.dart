import 'package:flutter/material.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/page/about.dart';
import 'package:weather/page/helpcenter.dart';
import 'package:weather/page/terms&condition.dart';

class CustomDrawer extends StatelessWidget {
  final Constants constants = Constants();

  ListTile _buildListTile(
    BuildContext context, {
    required String text,
    IconData? icon,
    VoidCallback? onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: icon != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                icon,
                color: iconColor ?? constants.primaryColor,
                size: 24,
              ),
            )
          : null,
      title: Text(
        text,
        style: TextStyle(
          color: textColor ?? constants.TertiaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: icon == null
          ? Icon(
              Icons.arrow_forward_ios,
              color: constants.TertiaryColor.withOpacity(0.7),
              size: 20,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              constants.primaryColor.withOpacity(0.9),
              constants.secondaryColor.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              // Header Section with Enhanced Design
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.3),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "WU",
                          style: TextStyle(
                            color: constants.secondaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black26,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Weather User",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      "Personal Weather Companion",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Menu Items with Hover Effect
              ...([
                {
                  'text': "Weather Forecast",
                  'icon': Icons.cloud_outlined,
                  'onTap': () {
                    // Navigate to Weather Forecast page
                  }
                },
                {
                  'text': "About",
                  'icon': Icons.location_city_outlined,
                  'onTap': () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutScreen()),
                    );
                  }
                },
                {
                  'text': "Help Center",
                  'icon': Icons.help_center_outlined,
                  'onTap': () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpCenterScreen()),
                    );
                  }
                }
              ])
                  .map((item) => _buildListTile(
                        context,
                        text: item['text'] as String,
                        icon: item['icon'] as IconData,
                        onTap: item['onTap'] as VoidCallback,
                        textColor: Colors.white,
                      ))
                  .toList(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(
                  color: Colors.white24,
                  thickness: 1.5,
                ),
              ),

              // Additional Links
              _buildListTile(
                context,
                text: "Terms & Conditions / Privacy",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TermsAndConditionsPage(),
                    ),
                  );
                },
                textColor: Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
