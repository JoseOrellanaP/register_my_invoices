import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:register_my_invoices/api/sheets/users_sheet_api.dart';
import 'package:register_my_invoices/page/create_sheets_page.dart';
import 'package:register_my_invoices/screen/add_new.dart';


class list_data extends StatefulWidget {
  @override
  State<list_data> createState() => _list_dataState();
}

class _list_dataState extends State<list_data> {

  int lenght;
  String factureNumber;
  List factureNumbers = new List();
  List totalValues = new List();
  List dates = new List();
  

  @override
  void initState() {
    // TODO: implement initState
    
    getUsers();
    
    
    
    

  }



  getUsers() async{
    List factuN = new List();
    List totalI = new List();
    

    lenght = await UserSheetsApi.getRowCount();

    for (var i=0; i<lenght; i++){
      final user = await UserSheetsApi.getById(i+1);
      factuN.add(user.invoiceNumber);
      totalI.add(user.totalValue);

      dates.add(user.date);
      print(user.date);
      
    }
    factureNumbers = factuN;
    totalValues = totalI;
    setState(() {
      factureNumbers = factureNumbers;
      totalValues = totalValues;
      lenght = lenght;
      dates = dates;
    });

    


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Register'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => create_sheets_page()
                      ),
                    );

              },
              child: Icon(Icons.calculate_sharp),
            ),
            )
        ],
      ),
      body: getCard(),

      floatingActionButton: FloatingActionButton(
        heroTag: 'uniqueTag',
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => add_new_data()
              )
          );
        },
        
      ),

    );
  }

  Widget getCard(){

    return Container(
      child: ListView.builder(
        itemCount: factureNumbers.length,
        itemBuilder: (context, position){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      "${dates[position]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      ),
                    ),
                    SizedBox(height: 15.0,),

                    Text(
                      "Invoice Number: ${factureNumbers[position]}"
                    ),
                    SizedBox(height: 15.0,),
                    Text(
                      "Total value: ${totalValues[position]}"
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      
      ),
    );


    /*
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Factura numero ${factureNumbers[0]}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            ),
            SizedBox(height: 15.0,),
            Text('Valor total')
          ],
        ),
      ),
    );

*/

  }

}