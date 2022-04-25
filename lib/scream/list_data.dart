import 'package:flutter/material.dart';
import 'package:register_my_invoices/scream/add_new.dart';

class list_data extends StatelessWidget {
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
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
}