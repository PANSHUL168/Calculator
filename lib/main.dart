import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


// COLOURS USED IN UI
    const operatorColor = Color(0xff272727);
    const buttonColor = Color(0xff191919);
    const greenColor = Color.fromARGB(255, 1, 254, 26);

void main(){
  runApp(const MaterialApp(
    home:Calculator()
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() 
  => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {


String num = "";
String opper = "";
String displayString = "0";
bool rShown = false;


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(


        // OUTPUT AREA
        children: [
          Expanded(
            child:Container(
              width: double.infinity,
              padding:const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$displayString",
                    style:TextStyle(
                      color:Colors.white,
                      fontSize: 50
                    ),
                  )
                ],
              )
            )
          ),


          //SPACING IN BETWEEN
          const SizedBox(
            height:40
          ),



          //BUTTON AREA
          // button() widget used is defined below
          Row(
            children: [
              button(text:'AC',tColor:greenColor,buttonBgColor: operatorColor),
              button(text:'<',tColor:greenColor,buttonBgColor: operatorColor),
              button(text:'/',tColor:greenColor,buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text:'7', value: 7),
              button(text:'8', value: 8),
              button(text:'9', value: 9),
              button(text:'*',tColor:greenColor,buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text:'4', value:4),
              button(text:'5', value: 5),
              button(text:'6', value: 6),
              button(text:'-',tColor:greenColor,buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text:'1', value: 1),
              button(text:'2', value: 2),
              button(text:'3', value: 3),
              button(text:'+',tColor:greenColor,buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text:'%',tColor:greenColor,buttonBgColor: operatorColor),
              button(text:'0', value: 0),
              button(text:'.'),
              button(text:'=',buttonBgColor:greenColor)
            ],
          ),
        ],
      ),
    );
  }



  //BUTTON LAYOUT DEFINED IN A FUNNCTION 
  Widget button(
    {text , tColor = Colors.white , buttonBgColor = buttonColor, value= ""}
  ){

    if (text == "<") text = "⌫";

    return Expanded(
      child:Container(
        margin:const EdgeInsets.all(8),
        child:ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            padding:const EdgeInsets.all(22),
            backgroundColor: buttonBgColor,
          ),
          child:Text(
            text,
            style:TextStyle(
              color:tColor,
              fontSize:25,
              fontWeight: FontWeight.bold
            ),
          ),


          // ON PRESSED FUNCTION
          onPressed:(){

            if (value == "") {

              if (text == "AC") {
                setState(() {
                  displayString = "0";
                  num = "";
                });
                
                return;
              }


              if (text == "=") {
                setState(() {
                calculate();
                });
              
                return;
              }
              setState(() {
                opper = text;
                oppClicked();
              });
              return;
            }


            if (value >= 0 && value <= 9){
              setState(() {
                num = value.toString();

              });
              numClicked();
            }


          },
          //...............


        )
      )
    );
  }

void calculate() {

  Parser p = Parser();
  Expression exp = p.parse(displayString);
  ContextModel cm = ContextModel();
  double result = exp.evaluate(EvaluationType.REAL, cm);

  setState(() {
    displayString = result.toString();
    rShown = true;    
  });

}

void numClicked() {


  if (displayString == "0" || rShown) {
    setState(() {
      rShown = false;
      displayString = num;
    });
    return;

  }

  setState(() {
      
      displayString += num;
  });
  

  setState(() {
    num = "";
  });

  return;
}

void oppClicked() {
 

  setState(() {
    displayString +=  " " + opper + " ";
    num = "";
  });
  
  return;
}


void update() {

}
}



