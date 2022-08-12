import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  static const String routeName = '/payment-screen';

  const PaymentScreen({Key? key}) : super(key: key);
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _values = 0;
  void submittButton() {
    if (_values == 0) {
      setState(() {});
    } else {
      Navigator.pushNamed(context, '/invoice-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select a payment method",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'CREDIT AND DEBIT CARD',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: _values == 1
                      ? Border.all(width: 2, color: Colors.orange)
                      : Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(children: [
                  Radio(
                      activeColor: Colors.orange,
                      value: 1,
                      groupValue: _values,
                      onChanged: ((value) {
                        setState(() {
                          _values = 1;
                        });
                      })),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Visa ******3061",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("Yash Gubreley"),
                      SizedBox(height: 5),
                      Text(
                        "Expires 08/2024",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ]),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: _values == 2
                      ? Border.all(width: 2, color: Colors.orange)
                      : Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(children: [
                  Radio(
                      activeColor: Colors.orange,
                      value: 2,
                      groupValue: _values,
                      onChanged: ((value) {
                        setState(() {
                          _values = 2;
                        });
                      })),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "RuPay ****8831",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("Mohammed sadiq"),
                      SizedBox(height: 5),
                      Text(
                        "Expires 09/2025",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ]),
              ),
              const SizedBox(height: 30),
              const Text(
                'MORE WAYS TO PAY',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: _values == 3
                      ? Border.all(width: 2, color: Colors.orange)
                      : Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(children: [
                  Radio(
                      activeColor: Colors.orange,
                      value: 3,
                      groupValue: _values,
                      onChanged: ((value) {
                        setState(() {
                          _values = 3;
                        });
                      })),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Other UPI / Net Banking",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ]),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: _values == 4
                      ? Border.all(width: 2, color: Colors.orange)
                      : Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(children: [
                  Radio(
                      activeColor: Colors.orange,
                      value: 4,
                      groupValue: _values,
                      onChanged: ((value) {
                        setState(() {
                          _values = 4;
                        });
                      })),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "EMI",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: _values == 5
                      ? Border.all(width: 2, color: Colors.orange)
                      : Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(children: [
                  Radio(
                      activeColor: Colors.orange,
                      value: 5,
                      groupValue: _values,
                      onChanged: ((value) {
                        setState(() {
                          _values = 5;
                        });
                      })),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Add Debit/Credit/ATM Card",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "You can save your cards as per new RBI guidelines.",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: _values == 6
                      ? Border.all(width: 2, color: Colors.orange)
                      : Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(children: [
                  Radio(
                      activeColor: Colors.orange,
                      value: 6,
                      groupValue: _values,
                      onChanged: ((value) {
                        setState(() {
                          _values = 6;
                        });
                      })),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Pay on Delivery",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 270,
                        child: Text(
                          "Pay using cash , Paylink (debit , credit card , UPI ) or Scan & Pay (Flat INR 25 back on first Sayaro Scan & pay transaction).",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _values == 0
                      ? null
                      : () {
                          print(_values);
                          submittButton();
                        },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
