part of 'package.dart';

class AppBarMolecule extends StatelessWidget implements PreferredSize {
  final String text;
  const AppBarMolecule({this.text = 'Bestiary', super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      clipBehavior: Clip.none,
      // title: Image.asset(
      //   'assets/images/bestiary-logo.png',
      //   height: 70,
      //   color: Colors.black,
      // ),
      title: Text(
        text,
        style: h2Font,
      ),
      actions: const [
        // MenuButton(),
        SignOutButtonAtom(),
      ],
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
