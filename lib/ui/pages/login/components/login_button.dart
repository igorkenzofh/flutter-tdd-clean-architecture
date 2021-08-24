import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_arch_app/ui/pages/pages.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColorLight,
                      Theme.of(context).primaryColorDark
                    ]),
              ),
            ),
          ),
          StreamBuilder<bool>(
              stream: presenter.isFormValidStream,
              builder: (context, snapshot) {
                return TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 2),
                  ),
                  onPressed: snapshot.data == true ? presenter.auth : null,
                  child: Text('Entrar',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                );
              }),
        ],
      ),
    );
  }
}
