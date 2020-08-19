import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  double _interest = 0.0;
  int _lengthOfLoan = 0;
  double _homePrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mortgage Payments"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              height: 130,
              child: Card(
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Monthly Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25
                    ),),
                    SizedBox(height: 9),
                    Text("\$123456")
                    //Text(" ${ ( _homePrice > 0 && _interest > 0.0) ? "\$${calculateMonthlyPayment(_homePrice, _interest, _lengthOfLoan)}" : ""}")
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixText: "Home Price",
                         // prefixText: "Home Price",
                          prefixIcon: Icon(Icons.home)),
                      onChanged: (String value) {
                        try {
                          _homePrice = double.parse(value);

                        }catch (exception) {
                          _homePrice = 0.0;
                        }

                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Length of Loan (years)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),),

                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if(_lengthOfLoan > 0) {
                                    _lengthOfLoan -= 5;
                                  }else {
                                    // do nothing
                                  }
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.blueGrey.withOpacity(0.2)
                                ),
                                child: Center(child: Text("-",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30
                                ),)),
                              ),
                            ),
                            Text("$_lengthOfLoan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),),
                            InkWell(
                              onTap: () {
                                setState(() {

                                  _lengthOfLoan += 5;
                                });
                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                  child: Center(child:Text("+",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24
                                  ),))

                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    //Interest
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Interest",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),),
                        Padding(padding: EdgeInsets.all(18), child:Text("${_interest.toStringAsFixed(2)} %",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),) )
                      ],
                    ),

                    //Slider
                    Column(
                      children: <Widget>[
                        Slider(
                            min: 0.0,
                            max: 10.0,
                            activeColor: Colors.red ,
                            inactiveColor: Colors.grey,
                            // divisions: 10,
                            value: _interest,
                            onChanged: (double newValue) {
                              setState(() {

                                _interest = newValue;
                              });
                            })
                      ],
                    )

                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );

  }

//  Monthly Payment Formula
//
//   n = number of payments
//   c = monthly interest rate
//
//   int n = 12 * years;
//   double c = rate / 12.0 / 100.0;
//   double payment = loan * c * Math.pow(1 + c, n) /
//                    (Math.pow(1 + c, n) - 1);
//
  calculateMonthlyPayment(double homePrice, double interest, int loanLength ) {
    int n = 12 * loanLength;
    double c = interest / 12.0 / 100.0;
    double monthlyPayment = 0.0;

    if (homePrice < 0 || homePrice.toString().isEmpty || homePrice == null) {
      //no go!
      // _homePrice = 0.0;
    }else {
      monthlyPayment = homePrice * c * pow(1 + c, n) / (pow(1 + c, n) - 1);
    }


    return monthlyPayment.toStringAsFixed(2);
  }
}
