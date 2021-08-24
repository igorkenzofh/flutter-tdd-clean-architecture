import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_arch_app/ui/pages/pages.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
              labelText: 'Email',
              icon: Icon(
                Icons.email,
                color: Theme.of(context).primaryColorLight,
              ),
              // só vai ser nulo se snapshot.data for diferente de nulo e isEmpty for true
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      },
    );
  }
}
