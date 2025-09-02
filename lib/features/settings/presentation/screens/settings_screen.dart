import 'package:flutter/material.dart';
import 'package:axion_tv/core/constants/app_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: const Center(
        child: Text(
          'Tela de Configurações',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
