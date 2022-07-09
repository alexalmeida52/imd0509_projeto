import 'package:flutter/material.dart';
import 'package:imd0509_projeto/views/components/update_birthday_component.dart';
import 'package:imd0509_projeto/views/components/update_email_component.dart';
import 'package:imd0509_projeto/views/components/update_name_last_name_component.dart';
import 'package:imd0509_projeto/views/components/update_phone_component.dart';

class EditFieldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(title: Text('Atualizar dados')),
        body: getWidgetFieldUpade(arg));
  }

  Widget getWidgetFieldUpade(Map arg) {
    print(arg['field1']);
    switch (arg['field1']) {
      case 'name':
        return UpdateNameLastNameComponent(arg);
      case 'birthday':
        return UpdateBirthdayComponent(arg);
      case 'email':
        return UpdateEmailComponent(arg);
      case 'phone':
        return UpdatePhoneComponent(arg);
      default:
        return UpdateNameLastNameComponent(arg);
    }
  }
}
