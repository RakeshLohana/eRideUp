import 'dart:convert';
/// status : true
/// card : {"card_number":"4242 4242 4242 4242","expiry":"12/27","cvc":"123","income":122,"spending":342,"available_balance":150}
/// transactions : [{"transaction_name":"Ride 1","amount":50,"date":"2025-06-24","time":"05:42 PM"},{"transaction_name":"Ride 2","amount":50,"date":"2025-06-23","time":"03:42 PM"}]

WalletSummaryModel walletSummaryModelFromJson(String str) => WalletSummaryModel.fromJson(json.decode(str));
String walletSummaryModelToJson(WalletSummaryModel data) => json.encode(data.toJson());
class WalletSummaryModel {
  WalletSummaryModel({
      bool? status, 
      Card? card, 
      List<Transactions>? transactions,}){
    _status = status;
    _card = card;
    _transactions = transactions;
}

  WalletSummaryModel.fromJson(dynamic json) {
    _status = json['status'];
    _card = json['card'] != null ? Card.fromJson(json['card']) : null;
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        _transactions?.add(Transactions.fromJson(v));
      });
    }
  }
  bool? _status;
  Card? _card;
  List<Transactions>? _transactions;
WalletSummaryModel copyWith({  bool? status,
  Card? card,
  List<Transactions>? transactions,
}) => WalletSummaryModel(  status: status ?? _status,
  card: card ?? _card,
  transactions: transactions ?? _transactions,
);
  bool? get status => _status;
  Card? get card => _card;
  List<Transactions>? get transactions => _transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_card != null) {
      map['card'] = _card?.toJson();
    }
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// transaction_name : "Ride 1"
/// amount : 50
/// date : "2025-06-24"
/// time : "05:42 PM"

Transactions transactionsFromJson(String str) => Transactions.fromJson(json.decode(str));
String transactionsToJson(Transactions data) => json.encode(data.toJson());
class Transactions {
  Transactions({
      String? transactionName, 
      num? amount, 
      String? date, 
      String? time,}){
    _transactionName = transactionName;
    _amount = amount;
    _date = date;
    _time = time;
}

  Transactions.fromJson(dynamic json) {
    _transactionName = json['transaction_name'];
    _amount = json['amount'];
    _date = json['date'];
    _time = json['time'];
  }
  String? _transactionName;
  num? _amount;
  String? _date;
  String? _time;
Transactions copyWith({  String? transactionName,
  num? amount,
  String? date,
  String? time,
}) => Transactions(  transactionName: transactionName ?? _transactionName,
  amount: amount ?? _amount,
  date: date ?? _date,
  time: time ?? _time,
);
  String? get transactionName => _transactionName;
  num? get amount => _amount;
  String? get date => _date;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_name'] = _transactionName;
    map['amount'] = _amount;
    map['date'] = _date;
    map['time'] = _time;
    return map;
  }

}

/// card_number : "4242 4242 4242 4242"
/// expiry : "12/27"
/// cvc : "123"
/// income : 122
/// spending : 342
/// available_balance : 150

Card cardFromJson(String str) => Card.fromJson(json.decode(str));
String cardToJson(Card data) => json.encode(data.toJson());
class Card {
  Card({
      String? cardNumber, 
      String? expiry, 
      String? cvc, 
      num? income, 
      num? spending, 
      num? availableBalance,}){
    _cardNumber = cardNumber;
    _expiry = expiry;
    _cvc = cvc;
    _income = income;
    _spending = spending;
    _availableBalance = availableBalance;
}

  Card.fromJson(dynamic json) {
    _cardNumber = json['card_number'];
    _expiry = json['expiry'];
    _cvc = json['cvc'];
    _income = json['income'];
    _spending = json['spending'];
    _availableBalance = json['available_balance'];
  }
  String? _cardNumber;
  String? _expiry;
  String? _cvc;
  num? _income;
  num? _spending;
  num? _availableBalance;
Card copyWith({  String? cardNumber,
  String? expiry,
  String? cvc,
  num? income,
  num? spending,
  num? availableBalance,
}) => Card(  cardNumber: cardNumber ?? _cardNumber,
  expiry: expiry ?? _expiry,
  cvc: cvc ?? _cvc,
  income: income ?? _income,
  spending: spending ?? _spending,
  availableBalance: availableBalance ?? _availableBalance,
);
  String? get cardNumber => _cardNumber;
  String? get expiry => _expiry;
  String? get cvc => _cvc;
  num? get income => _income;
  num? get spending => _spending;
  num? get availableBalance => _availableBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['card_number'] = _cardNumber;
    map['expiry'] = _expiry;
    map['cvc'] = _cvc;
    map['income'] = _income;
    map['spending'] = _spending;
    map['available_balance'] = _availableBalance;
    return map;
  }

}