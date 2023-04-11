import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> currencies = ['Rupees', 'Dollar', 'Pound'];
  var currentItemSelected = '';
  String displayResult = '';

  @override
  void initState() {
    currentItemSelected = currencies[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/image.png',
                    height: 125,
                    width: 125,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: principalController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Please enter principal amount';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal Amount',
                      hintText: 'Enter principal amount e.g. 12000',
                      errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: roiController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Please rate of interest';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'Enter rate of interest in percent',
                      errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: termController,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: (value){
                          if(value==null||value.isEmpty){
                            return 'Please term';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Term in years',
                            errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        style: textStyle,
                        items: currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: currentItemSelected,
                        onChanged: (newValueSelected) {
                          setState(() {
                            currentItemSelected = newValueSelected!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if(_formKey.currentState!.validate()){
                              displayResult = calculateInterest();
                            }
                          });
                        },
                        child: Text(
                          'Calculate',
                          style: textStyle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          resetValue();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: Text(
                          'Reset',
                          style: textStyle,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  displayResult,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String calculateInterest() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalPayableAmount = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalPayableAmount $currentItemSelected';
    return result;
  }

  void resetValue() {
    setState(() {
      principalController.clear();
      roiController.clear();
      termController.clear();
      currentItemSelected = currencies[0];
      displayResult = '';
    });
  }
}
