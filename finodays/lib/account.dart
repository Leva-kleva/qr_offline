import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Account {
  final int id;
  final String name;
  late final String value;

  Account({required this.id, required this.name, required this.value});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      name: json['name'],
      value: json['offline_balance'],
    );
  }
}


Future<Account> CreateAccount(String name, int value) async {
  final response = await http.post(
    Uri.parse('https://clas.sinp.msu.ru/cgi-bin/almaz/innotex_test.py?name=' + name + '&balance=' + value.toString()),
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    // body: json.encode({
    //   'name': name,
    //   'value': value
    // }),
  );

  // if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  print(response.body);
    return Account.fromJson(jsonDecode(response.body));
  // } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
  //   throw Exception('Failed to create.');
  // }
}


class AccountState extends StatefulWidget {
  const AccountState({super.key});

  @override
  _GAccountState createState() => _GAccountState();
}


class _GAccountState extends State<AccountState> {
  final TextEditingController _controller_name = TextEditingController();
  final TextEditingController _controller_value = TextEditingController();
  Future<Account>? _futureAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Off Pay'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAccount == null) ? buildColumn() : buildFutureBuilder(),
        )
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller_name,
          decoration: const InputDecoration(hintText: 'Enter Name'),
        ),
        TextField(
          controller: _controller_value,
          decoration: const InputDecoration(hintText: 'Enter Money'),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAccount = CreateAccount(_controller_name.text, int.parse(_controller_value.text));
            });
          },
          child: const Text('Create Account'),
        ),
      ],
    );
  }

  FutureBuilder<Account> buildFutureBuilder() {
    return FutureBuilder<Account>(
      future: _futureAccount,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
