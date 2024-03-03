import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.0),
        CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage('https://media.licdn.com/dms/image/D4D03AQHIVocsnBFJqQ/profile-displayphoto-shrink_800_800/0/1708484147297?e=1715212800&v=beta&t=cYvdBcmuOz53W5bAb8IxIcLW7XXosS_MEhFlmfNaXJE'), // Replace with user's profile picture
        ),
        SizedBox(height: 16.0),
        Text(
          'Anuroop Farkya', // Replace with user's name
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'anuroopf02@gmail.com', // Replace with user's email
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildProfileOption(context, 'Edit Profile', Icons.edit, () {
                    // Navigate to Edit Profile screen
                  }),
                  buildProfileOption(context, 'Change Password', Icons.lock, () {
                    // Navigate to Change Password screen
                  }),
                  buildProfileOption(context, 'Subscription Status', Icons.subscriptions, () {
                    // Navigate to Subscription Status screen
                  }),
                  buildProfileOption(context, 'Preferences', Icons.settings, () {
                    // Navigate to Preferences screen
                  }),
                  buildProfileOption(context, 'Saved Articles', Icons.bookmark, () {
                    // Navigate to Saved Articles screen
                  }),
                  buildProfileOption(context, 'Logout', Icons.logout, () {
                    // Perform logout action
                  }),
                  buildProfileOption(context, 'Settings', Icons.settings, () {
                    // Navigate to Settings screen
                  }),
                  buildProfileOption(context, 'Feedback/Rating', Icons.feedback, () {
                    // Navigate to Feedback/Rating screen
                  }),
                  buildProfileOption(context, 'About Us', Icons.info, () {
                    // Navigate to About Us screen
                  }),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileOption(BuildContext context, String title, IconData icon, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28.0,
              color: Colors.blueAccent,
            ),
            SizedBox(width: 16.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}


/*
* buildTile(
                      context,
                      'Recently Viewed Articles',
                      Icons.history,
                      Colors.teal,
                      () {
                        // Navigate to Recently Viewed Articles screen
                      },
                    ),
                    *
                    *
                    *
                    *
                buildTile(
                      context,
                      'Reading Preferences',
                      Icons.format_size,
                      Colors.purple,
                      () {
                        // Navigate to Reading Preferences screen
                      },
                    ),
                    *
                    *
                    *

                    * */