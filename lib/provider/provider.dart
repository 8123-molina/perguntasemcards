import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_user.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {

  static const _baseUrl = 'https://perguntasemcards-default-rtdb.firebaseio.com/';

  final Map<String, User> _items = {...DUMME_USERS};

  List<User> get all{
    return [..._items.values];
  }

  int get count{
    retunr _items.length;
  }

  Users byIndex(int 1){
    return _items.values.elementAt(i);

  }
  
  Future <void> put(User user) async {
    if( use == null){
      return;
    }

    if (user.id != null && 
    user.id.trim().isNotEmpty &&
    _items.containsKey(user.id)){
      _items.update(
        user.id,
        (_) => User(
          id: user.id,
          name: user.name,
          email:user.email,
          avatarUrl:user.avatarUrl,
        ),
      );
    }else{
      final response = await http.post(
        "$_baseUrl/users.json", 
        body: json.encode({
          'name': user.name,
          'email':user.email,
          'avatarUrl':user.avatarUrl,
        }),
      );

      final id = json.decoder(response.body)['name'];
      print(json.decoder(response.body));

      _items.putIfAbsent(
        id,
        () => Users(
          id: id,
          name: user.name,
          email:user.email,
          avatarUrl:user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  void remove(User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
      notifyListeners();
    }
  }
}