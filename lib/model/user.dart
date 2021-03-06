import 'dart:convert';

class UserFields{
  static final String id = 'id';
  static final String date = 'date';
  static final String month = 'month';
  static final String invoiceNumber = 'invoiceNumber';
  static final String subTotalValue = 'subTotalValue';
  static final String ivaValue = 'ivaValue';
  static final String totalValue = 'totalValue';

  static List<String> getFields() => [id, date, month, invoiceNumber, subTotalValue, ivaValue, totalValue];
  

}

class User {
  final int id;
  final String date;
  final String month;
  final String invoiceNumber;
  final String subTotalValue;
  final String ivaValue;
  final String totalValue;

  const User({
    this.id,
    this.date,
    this.month,
    this.invoiceNumber,
    this.subTotalValue,
    this.ivaValue,
    this.totalValue
  });

  static User fromJson(Map<String, dynamic> json) =>  User(
    id: jsonDecode(json[UserFields.id]),
    date: json[UserFields.date],
    month: json[UserFields.month],
    invoiceNumber: json[UserFields.invoiceNumber],
    subTotalValue: json[UserFields.subTotalValue],
    ivaValue: json[UserFields.ivaValue],
    totalValue: json[UserFields.totalValue]
  );

  Map<String, dynamic>  toJson() => {
    UserFields.id: id,
    UserFields.date: date,
    UserFields.month: month,
    UserFields.invoiceNumber: invoiceNumber,
    UserFields.subTotalValue: subTotalValue,
    UserFields.ivaValue: ivaValue,
    UserFields.totalValue: totalValue,
  };
  
}