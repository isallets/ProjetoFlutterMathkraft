import 'package:flutter/material.dart';

class MathKraftHeader extends StatelessWidget implements PreferredSizeWidget {
  const MathKraftHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false, // Não mostra o botão de voltar padrão
      title: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'MathKraft',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                'lib/assets/MathKraft.png',
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
