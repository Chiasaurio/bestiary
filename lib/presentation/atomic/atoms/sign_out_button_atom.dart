part of 'package.dart';

class SignOutButtonAtom extends StatelessWidget {
  const SignOutButtonAtom({
    super.key,
    this.color = Colors.white70,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'sign-out-button',
      child: Material(
        type: MaterialType.transparency,
        child: IconButton(
          onPressed: () {
            context.read<AuthModel>().signOut();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInPage(),
              ),
              (route) => false,
            );
          },
          icon: Icon(AppIcons.signOut, size: 30, color: color),
        ),
      ),
    );
  }
}
