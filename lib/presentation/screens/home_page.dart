import 'package:animal_collectables/presentation/atomic/molecules/package.dart';
import 'package:animal_collectables/presentation/screens/my_stats_page.dart';
import 'package:animal_collectables/presentation/theme/decoration.dart';
import 'package:flutter/material.dart';

import '../theme/fonts.dart';
import 'add_new_card_page.dart';
import 'my_cards_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: scaffoldDecoration,
      child: Scaffold(
        appBar: const AppBarMolecule(),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            _button(
              'New card',
              Icons.photo_camera_outlined,
              context,
              route: const AddNewCardPage(),
            ),
            _button(
              'My collection',
              Icons.collections,
              context,
              route: const MyCardsPage(),
            ),
            _button(
              'Stats',
              Icons.insert_chart_outlined_sharp,
              context,
              route: const MyStatsPage(),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _button(String text, IconData icon, BuildContext context,
      {required Widget route}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Container(
        width: double.infinity,
        height: 180,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Icon(
              icon,
              size: 100,
            ),
            Text(
              text,
              style: h2Font,
            )
          ],
        ),
      ),
    );
  }
}
