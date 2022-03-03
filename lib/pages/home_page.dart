import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedDate = DateTime.now();
  var selected = false;
  var f = DateFormat("dd/MM/yyyy EEEE");

  var modVal = 0;
  var houseName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Mahabote"),
      ),
      body: _homeDesign(),
    );
  }

  TextStyle _selectedColor(val) => TextStyle(
      color: houseName == val ? Theme.of(context).primaryColor : Colors.black);

  Text _labelText(val) => Text(val, style: _selectedColor(val));

  Widget _mahaboteLayout() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(""),
                _labelText("အဓိပတိ"),
                Text(""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelText("အထွန်း"),
                _labelText("သိုက်"),
                _labelText("ရာဇ"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelText("မရဏ"),
                _labelText("ဘင်္ဂ"),
                _labelText("ပုတိ"),
              ],
            ),
          ],
        ),
      );

  String _houseResult(year, day) {
    var houses = ["ဘင်္ဂ", "အထွန်း", "ရာဇ", "အဓိပတိ", "မရဏ", "သိုက်", "ပုတိ"];
    return houses[(year - day - 1) % 7];
  }

  var isChecked = false;
  //1,4,0,3,6,2,5
  Widget _homeDesign() => ListView(
        children: <Widget>[
          Container(
            height: 120,
            color: Theme.of(context).primaryColor,
            child: ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2025),
                      helpText: 'Select Your Birthday', // Can be used as title
                      cancelText: 'Not now');
                  if (picked != null) {
                    var myanmarYear = picked.year - 638;
                    if (picked.month < 4) {
                      myanmarYear = picked.year - 637;
                    }

                    setState(() {
                      selectedDate = picked;
                      modVal = myanmarYear % 7;
                      houseName = _houseResult(myanmarYear, picked.weekday);
                      selected = true;
                    });
                  }
                },
                child: selected
                    ? Text(f.format(selectedDate))
                    : const Text("Select Your Birthday")),
          ),
          // Checkbox(
          //   checkColor: Colors.white,
          //   value: isChecked,
          //   onChanged: (bool? value) {
          //     setState(() {
          //       isChecked = value!;
          //     });
          //   },
          // ),
          Container(
            margin: const EdgeInsets.all(12),
            height: 150,
            child: Card(child: Center(child: _mahaboteLayout())),
          ),
          selected == false
              ? Container()
              : Container(
                  margin: const EdgeInsets.all(12),
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text("အကြွင်း $modVal"),
                              Text(
                                houseName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ))),
                )
        ],
      );
}
