// ignore_for_file: file_names, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:online_ordering_app/data.dart';
class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}
class _DetailsState extends State<Details> {
  List<DropdownMenuItem> size=[DropdownMenuItem(value:"1" ,child: Text("200grams"),),DropdownMenuItem(value:"5" ,child: Text("500grams")),DropdownMenuItem(value:"10",child: Text("1Kg"))];
  var selected="1";
  var quantity=1;
  var fixedp=Data.prices[Data.snacks.indexOf(Data.itemselected)];
  var price=Data.prices[Data.snacks.indexOf(Data.itemselected)];
  var resetprice=Data.prices[Data.snacks.indexOf(Data.itemselected)];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        title:Text("Details of "+Data.itemselected) ,
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Hero(
              tag: Data.itemselected,
              child: Image(image: AssetImage("images/"+Data.itemselected+".jpg"),
              fit: BoxFit.fill,
              ),
            ),
            SizedBox(height:20),
            Text(Data.itemselected,
            style: TextStyle(
              fontWeight:FontWeight.bold,
              fontSize: 50
            ),
            ),
             Text(Data.description[Data.snacks.indexOf(Data.itemselected)],
            style: TextStyle(
              fontSize: 20
            ),
            ),
            SizedBox(height: 20,)
            ,
           DropdownButton(items: size,
           value:selected ,
            onChanged:(value) {
             setState(() {
              fixedp=resetprice;
              quantity=1;
              fixedp=(int.parse(fixedp)*int.parse(value)).toString();
              price=fixedp;
              selected=value;
             });
           }),
            Center(
              child: Row(
                children: [
                  SizedBox(width: 150,),
                  IconButton(onPressed: (){
                    setState(() {
                      //add if quantity is equal to one checkr
                      if(quantity==1)
                      {
                            //show an error to atleast buy one item
                            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                              backgroundColor: Colors.green[700],
                               content: Text("Please buy atleast one item"), duration: Duration(milliseconds: 500), ), );
                      }
                      else{
                      quantity=quantity-1;
                      price=(int.parse(price)-int.parse(fixedp)).toString();
                      }
                    });
                  }, icon: Icon(Icons.remove))
                  ,
                  Text(quantity.toString()),
                          IconButton(onPressed: (){
                    setState(() {
                      //add if quantity exceeds available
                      quantity=quantity+1;
                      price=(int.parse(price)+int.parse(fixedp)).toString();
                    });
                  }, icon: Icon(Icons.add))
                ],
              ),
            ), SizedBox(height: 20,),
            Center(
              child: Text("Total: Ksh."+price,
              style: TextStyle(
                fontWeight:FontWeight.bold,
                fontSize: 30
              ),
              ),
            ),
            SizedBox(height: 20,),
           ElevatedButton(
            style: ButtonStyle(
              //style this 
            ),
            onPressed: (){
            //navigate to the check out page
            Data.total=price;
            Navigator.pushNamed(context, "/checkout");
           }, 
           child:Row(
            children: [
              SizedBox(width: 150,)
              ,
              Text("Check out "),
              Icon(Icons.attach_money)
            ],
           ) 
           
           )
          ],
        ),
      ),
    );
  }
}