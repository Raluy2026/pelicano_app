import 'package:flutter/material.dart';

/// Transición global derecha a izquierda
class RightToLeftPageRoute extends PageRouteBuilder {
  final Widget page;
  RightToLeftPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
}

/// Helper global para navegar con transición uniforme
void navigateTo(BuildContext context, Widget page) {
  Navigator.of(context).push(
    RightToLeftPageRoute(page: page),
  );
}
