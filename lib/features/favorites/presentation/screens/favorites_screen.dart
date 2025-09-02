import 'package:flutter/material.dart';
import 'package:axion_tv/core/constants/app_constants.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: const Center(
        child: Text(
          'Tela de Favoritos',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
