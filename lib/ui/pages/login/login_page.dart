import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_arch_app/ui/pages/pages.dart';
import 'package:provider/provider.dart';
import '../../components/components.dart';
import 'components/email_input.dart';
import 'components/password_input.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget.presenter.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error);
          }
        });

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginHeader(),
              Headline1(
                text: 'Login',
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Provider(
                  create: (_) => widget.presenter,
                  child: Form(
                    child: Column(
                      children: [
                        EmailInput(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                          child: PasswordInput(),
                        ),
                        ClipRRect(
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
                                  stream: widget.presenter.isFormValidStream,
                                  builder: (context, snapshot) {
                                    return TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 2),
                                      ),
                                      onPressed: snapshot.data == true
                                          ? widget.presenter.auth
                                          : null,
                                      child: Text('Entrar',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.person,
                                color: Theme.of(context).primaryColorLight),
                            label: Text(
                              'Criar conta',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
