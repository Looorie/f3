import 'package:f3/menu_page.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("登录", context),
      body: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _globalKey = GlobalKey<FormState>();
  final _user = TextEditingController();
  final _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user.text = "user";
    _pass.text = "password";
  }

  @override
  void dispose() {
    super.dispose();
    _user.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _globalKey,
        child: Column(
          children: [
            TextFormField(
                controller: _user,
                // initialValue: "user",
                maxLines: 1,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    labelText: "账户",
                    hintText: "用户名/手机/邮箱"),
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "请输入账号";
                  }
                }),
            TextFormField(
                obscureText: true,
                controller: _pass,
                // initialValue: "password",
                maxLines: 1,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    labelText: "密码",
                    hintText: "密码"),
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  submit();
                },
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "请输入密码";
                  }
                }),
            SizedBox.fromSize(
              size: const Size(16, 16),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    submit();
                  },
                  child: const Text("提交")),
            )
          ],
        ));
  }

  submit() {
    if ((_globalKey.currentState as FormState).validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("用户名：${_user.text}  \n密码：${_pass.text}  "),
        duration: const Duration(seconds: 2),
      ));

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MenuPage();
      }));
    }
  }
}
