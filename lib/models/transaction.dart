class Transaction{
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({required this.id,required this.title,required this.amount,required this.date});


  //Mapping to JSON Encoding and decoding for shared preferences
  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  Transaction.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      title = json['title'],
      amount = json['amount'],
      date = DateTime.parse(json['date']);
}