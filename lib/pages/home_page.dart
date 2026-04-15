import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:billeterie_electronique/framework/user/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (authProvider.currentUser != null) ...[
              Text('Nom: ${authProvider.currentUser!.name}'),
              Text('Email: ${authProvider.currentUser!.email}'),
              if (authProvider.currentUser!.phoneNumber != null)
                Text('Téléphone: ${authProvider.currentUser!.phoneNumber}'),
            ],
            const SizedBox(height: 32),
            const Text(
              '🎫 Système de Billeterie Électronique',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}