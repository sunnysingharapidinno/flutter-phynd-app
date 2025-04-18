import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Home',
      child: Center(
        child: Text('Welcome to Phynd!'),
      ),
    );
  }
}
