
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:register_my_invoices/api/sheets/users_sheet_api.dart';
import 'package:register_my_invoices/model/user.dart';
import 'package:flutter_restart/flutter_restart.dart';


class add_new_data extends StatefulWidget {

  @override
  _add_new_dataState createState() => _add_new_dataState();
}

class _add_new_dataState extends State<add_new_data> {
  
  final controllerNumber = TextEditingController();
  final controllerTotal = TextEditingController();
  
  DateTime selectedDate = DateTime.now();

  

  Future<void> _selectedDate(BuildContext) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015,8),
      lastDate: DateTime(2101)
    );
    if(picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
  return Hero(
      tag: 'uniqueTag',
      child: Scaffold(
          appBar: AppBar(
            title: Text('Add new invoice'),
          ),
          body: ListView(
            children: [
              
              SizedBox(height: 46.0,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                  ElevatedButton(
                    onPressed: (){
                      _selectedDate(context);
                    },
                    child: Text("Selected date",
                    ),
                  ),
              
                  Text("${selectedDate.toLocal()}".split(" ")[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      fontSize:20.0
                    ),
                    ),
                  
                ],
              ),
              
              
              SizedBox(height: 25.0,),
              
              
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controllerNumber,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter numero de factura',
                      ),
                      validator: (value){
                        if(value.isNotEmpty){
                          return null;
                        }else{
                          return 'Please enter the number';
                        }
                      },
                    ),    
                  ),
              
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controllerTotal,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter valor total",
                    ),
                    validator: (value){
                      if(value.isNotEmpty){
                        return null;
                      }else{
                        return 'Please enter a total value';
                      }
                    },
              ),
              ),
              
              
              
                ],
              ),
              
              
              
              
          
              
              
              SizedBox(height: 35.0,),
              
              
              ElevatedButton(
                child: Text('Save'),
                onPressed: () async{
          
                  if(controllerNumber.text == '' || controllerTotal.text == ''){
                    
                    Fluttertoast.showToast(
                      msg: 'Ingresa todos los datos para guardar',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red
                    );
                    return;
                  }
          
                  String date = "${selectedDate.toLocal()}".split(" ")[0];
                  String month = DateFormat.M().format(selectedDate).toString();
                  String invoiceNumber = controllerNumber.text;
          
                  
                  String totalValue = controllerTotal.text;
                  double subTotalD = double.parse(totalValue) / 1.12;
                  String subTotal = subTotalD.toStringAsFixed(2);
                  double ivaValueD = double.parse(totalValue) - double.parse(subTotal);
                  String ivaValue = ivaValueD.toStringAsFixed(2);
          


                  final id = await UserSheetsApi.getRowCount();

                  print(id);

                  final user = User(
                    id: id + 1,
                    date: date,
                    month: month,
                    invoiceNumber: invoiceNumber,
                    subTotalValue: subTotal,
                    ivaValue: ivaValue,
                    totalValue: totalValue,
                  );


                  

                  await UserSheetsApi.insert([user.toJson()]);

                  Fluttertoast.showToast(
                      msg: 'Se guardo los datos',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green
                    );

                    controllerNumber.text = "";
                    controllerTotal.text = "";

                    setState(() async{
                      await FlutterRestart.restartApp();  
                    });


                    
                    

              
                },
              )
            ],
          ),
        ),
      );
  
  }
}

Widget addNewField (text){
  return  Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                    labelText: text,
                  ),
                ),
              );
            
}