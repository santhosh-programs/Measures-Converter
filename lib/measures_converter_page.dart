import 'dart:async';

import 'package:flutter/material.dart';
import 'package:measures_converter/constants.dart';

class MeasuresConverterPage extends StatefulWidget {
  const MeasuresConverterPage({super.key, required this.title});

  final String title;

  @override
  State<MeasuresConverterPage> createState() => _MeasuresConverterPageState();
}

class _MeasuresConverterPageState extends State<MeasuresConverterPage> {
  /// [valueTextCtrl] will be used to read and control the values in the value text field
  TextEditingController valueTextCtrl = TextEditingController();

  /// This stream controller will hold the values for the converted string that we display on press of convet
  /// This avoids the call for setState and only updates the widget that needs to be rebuilt
  /// leaving the other widget to be static without unnecessary rebuilds.
  StreamController<String> streamController = StreamController();

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Constants.value,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextFormField(
                controller: valueTextCtrl,
                // Setting the keyboard type to number only with decimals allowed so
                // users cannot type an invalid value
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              Text(
                Constants.from,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              DropdownButton(
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    child: Text(Constants.meters),
                  )
                ],
                onChanged: (val) {},
              ),
              const SizedBox(height: 20),
              Text(
                Constants.to,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              DropdownButton(
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    child: Text(Constants.feet),
                  )
                ],
                onChanged: (val) {},
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  updateConvertedTextResult();
                },
                child: const Text(Constants.convert),
              ),
              StreamBuilder(
                  stream: streamController.stream,
                  builder: (ctx, snapshot) => Text(
                        snapshot.hasData ? snapshot.requireData : '',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )),
            ],
          ),
        ),
      ),
    );
  }

  void updateConvertedTextResult() {
    double? meters = double.tryParse(valueTextCtrl.text);
    if (meters != null) {
      streamController.add('$meters meters are ${meters * 3.28084} feet');
    } else {
      streamController.add('');
    }
  }
}
