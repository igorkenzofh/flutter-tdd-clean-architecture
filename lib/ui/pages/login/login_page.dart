import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_arch_app/ui/pages/pages.dart';
import '../../components/components.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Aguarde...',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
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
                child: Form(
                  child: Column(
                    children: [
                      StreamBuilder<String>(
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
                                  errorText: snapshot.data?.isEmpty == true
                                      ? null
                                      : snapshot.data),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: presenter.validateEmail,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                        child: StreamBuilder<String>(
                            stream: presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Senha',
                                    icon: Icon(Icons.lock,
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data),
                                obscureText: true,
                                onChanged: presenter.validatePassword,
                              );
                            }),
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
                                stream: presenter.isFormValidStream,
                                builder: (context, snapshot) {
                                  return TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 2),
                                    ),
                                    onPressed: snapshot.data == true
                                        ? presenter.auth
                                        : null,
                                    child: Text('Entrar',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
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
              )
            ],
          ),
        );
      }),
    );
  }
}
