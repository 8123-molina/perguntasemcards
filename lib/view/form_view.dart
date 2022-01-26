import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/povider/uses.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avataUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChandeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRouter.of(context).setting.arguments;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          const IconButton(
            icon: Icon(Icons.save);
            onPressd: () async {
              final isValid = _form.currentState.validate();

              if (isValid){
                _form.currentState.save();

                setState((){
                  _isLoading = true;
                });

                await Povider.of<Users>(context, listen: false).put(
                  User(
                    id:   _formData      ['id'],
                    name: _formData      ['name'],
                    email: _formData     ['email'],
                    avatarUrl: _formData ['avatarUrl']

                  ),
                );

                setState((){
                  _isLoading = false;
                });

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator())  
      : Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty){
                    return 'Nome inválido';
                  }

                  if(value.trim().length < 3){
                    return 'Nome muito pequeno. No mínimo 3 caracteres.';
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
