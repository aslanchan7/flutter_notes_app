import 'package:first_desktop_app/theme/theme.dart';
import 'package:first_desktop_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 80,
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
              ),
            ),
            Switch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: Provider.of<ThemeProvider>(context).themeData == darkTheme,
              onChanged: (value) {
                setState(() {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
