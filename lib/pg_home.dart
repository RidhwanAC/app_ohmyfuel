import 'package:app_ohmyfuel/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double pgWidth;
  late double pgHeight;

  TextEditingController distanceController = TextEditingController();
  TextEditingController efficiencyController = TextEditingController();

  double fuelNeeded = 0.00;
  double cost = 0.00;
  String selectedFuel = 'Ron95';

  bool emptyDistance = false;
  bool emptyEfficiency = false;
  bool zeroEfficiency = false;

  Map<String, double> fuelPrices = {
    'Ron95': 2.60,
    'Ron97': 3.14,
    'Diesel': 2.15
  };

  @override
  Widget build(BuildContext context) {
    pgWidth = MediaQuery.of(context).size.width;
    pgHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.1 * pgHeight,
        title: Text(
          'Oh My Fuel!',
          style: TextStyle(
            fontSize: 0.04 * pgHeight,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(0.025 * pgHeight),
                margin: EdgeInsets.all(0.05 * pgHeight),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      controller: distanceController,
                      labelText: 'Distance (km)',
                      hintText: 'Enter travel distance',
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: emptyDistance ? Colors.red : Colors.black,
                            width: emptyDistance ? 2.0 : 1.0),
                      ),
                    ),
                    Visibility(
                      visible: emptyDistance,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.warning, color: Colors.red),
                            Text('Required field',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.025 * pgHeight),
                    MyTextField(
                      controller: efficiencyController,
                      labelText: 'Efficiency (km/l)',
                      hintText: 'Enter fuel efficiency',
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: emptyEfficiency || zeroEfficiency
                                ? Colors.red
                                : Colors.black,
                            width:
                                emptyEfficiency || zeroEfficiency ? 2.0 : 1.0),
                      ),
                    ),
                    Visibility(
                      visible: emptyEfficiency || zeroEfficiency,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning, color: Colors.red),
                            Text(
                                (emptyEfficiency)
                                    ? 'Required field'
                                    : 'Efficiency cannot be zero',
                                style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.025 * pgHeight),
                    Row(
                      children: [
                        Text(
                          'Select Fuel: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 0.02 * pgHeight,
                          ),
                        ),
                        SizedBox(width: 0.025 * pgWidth),
                        DropdownButton<String>(
                          value: selectedFuel,
                          items: fuelPrices.keys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedFuel = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 0.05 * pgHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: _calculate,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(
                                0.04 * pgWidth,
                                0.015 * pgHeight,
                                0.04 * pgWidth,
                                0.015 * pgHeight),
                          ),
                          child: Text(
                            'Calculate',
                            style: TextStyle(fontSize: 0.02 * pgHeight),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _clear,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(
                                0.04 * pgWidth,
                                0.015 * pgHeight,
                                0.04 * pgWidth,
                                0.015 * pgHeight),
                          ),
                          child: Text(
                            'Reset',
                            style: TextStyle(fontSize: 0.02 * pgHeight),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(0.025 * pgHeight),
                margin:
                    EdgeInsets.fromLTRB(0.05 * pgHeight, 0, 0.05 * pgHeight, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0.02 * pgHeight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Fuel Price: ${fuelPrices[selectedFuel]?.toStringAsFixed(2)} RM/litre',
                      style: TextStyle(fontSize: 0.02 * pgHeight),
                    ),
                    SizedBox(height: 0.015 * pgHeight),
                    Text(
                      'Estimated fuel needed: ${fuelNeeded.toStringAsFixed(2)} litres',
                      style: TextStyle(fontSize: 0.02 * pgHeight),
                    ),
                    SizedBox(height: 0.015 * pgHeight),
                    Text(
                      'Estimated Cost: RM ${cost.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 0.02 * pgHeight),
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  void _calculate() {
    double? distance, efficiency;

    cost = 0.00;
    fuelNeeded = 0.00;

    emptyDistance = distanceController.text.isEmpty;
    emptyEfficiency = efficiencyController.text.isEmpty;

    if (distanceController.text.isNotEmpty &&
        efficiencyController.text.isNotEmpty) {
      distance = double.parse(distanceController.text.trim());
      efficiency = double.parse(efficiencyController.text.trim());
      if (efficiency == 0) {
        zeroEfficiency = true;
      } else {
        zeroEfficiency = false;
        fuelNeeded = distance / efficiency;
        cost = fuelNeeded * fuelPrices[selectedFuel]!;
      }
      distanceController.text = distance.toString();
      efficiencyController.text = efficiency.toString();
    }
    setState(() {});
  }

  void _clear() {
    distanceController.clear();
    efficiencyController.clear();
    fuelNeeded = 0.00;
    cost = 0.00;
    emptyDistance = false;
    emptyEfficiency = false;
    zeroEfficiency = false;
    setState(() {});
  }
}
