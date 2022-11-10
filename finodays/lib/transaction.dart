import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:finodays/account.dart';


class Transaction {
  final String uuid;
  final int from;
  final int to;
  final int value;

  const Transaction({required this.uuid, required this.from, required this.to, required this.value});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      uuid: json['uuid'],
      from: json['from'],
      to: json['to'],
      value: json['value'],
    );
  }
}


Future<Account> SendTransactions(String data, Account account) async {
  final response = await http.post(
    Uri.parse('https://clas.sinp.msu.ru/cgi-bin/almaz/innotex_test.py?login=Sasha&password=1234&balance=140000'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data, // json type = string
  );

  if (response.statusCode == 201) {
    account.value = jsonDecode(response.body)['value'];
    return account;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create.');
  }
}
