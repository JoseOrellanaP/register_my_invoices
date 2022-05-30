import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class create_sheets_page extends StatefulWidget {
  
  @override
  
  _create_sheets_pageState createState() => _create_sheets_pageState();
}



class _create_sheets_pageState extends State<create_sheets_page> {

  final myController = TextEditingController();

  String total = "";
  double subtotal = 0;
  double iva = 0;
  double valueIva = 1.12;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 45.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(55, 18, 55, 18),
              child: TextField(
                controller: myController,
                autofocus: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0
                ),
              ),
            ),
            SizedBox(height: 25.0,),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  total = myController.text;


                  subtotal = double.parse(total) / valueIva;
                  iva = double.parse(total) - double.parse(subtotal.toStringAsFixed(2));
                  
                });
              }, 
              child: Text(
                'Calculate'
              )
              ),
            SizedBox(height: 35.0,),
            Text("Subtotal: ${subtotal.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 20.0
              ),),
      
            SizedBox(height: 35.0,),
            Text("Iva: ${iva.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 20.0
              ),),
              
      
            SizedBox(height: 35.0,),
            Text("Total: $total",
              style: TextStyle(
                fontSize: 20.0
              ),),
              
            
      
          ],
          ),
      ),
    );
  }
}