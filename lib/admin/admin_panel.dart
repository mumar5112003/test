import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFlatButton(context, 'Dashboard', Icons.dashboard),
            _buildFlatButton(context, 'Set Exercises', Icons.fitness_center),
            _buildFlatButton(context, 'Analytics', Icons.analytics),
            _buildFlatButton(context, 'Message', Icons.message),
            _buildFlatButton(context, 'Team', Icons.people),
          ],
        ),
      ),
    );
  }

  Widget _buildFlatButton(BuildContext context, String label, IconData icon) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton.icon(
        onPressed: () {
          // Handle button press
        },
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
