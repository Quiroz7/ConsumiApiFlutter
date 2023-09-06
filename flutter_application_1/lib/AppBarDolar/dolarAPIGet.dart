import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/AppBarDolar/dolarAPIModel.dart';
import 'package:http/http.dart' as http;

class DolarApiGet extends StatefulWidget {
  const DolarApiGet({Key? key}) : super(key: key);

  @override
  State<DolarApiGet> createState() => _DolarApiGetState();
}

class _DolarApiGetState extends State<DolarApiGet> {
  bool _isLoading = true;
  DolarModel? dataFromAPI;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      String url = "https://www.datos.gov.co/resource/ceyp-9c7c.json?vigenciadesde=2023-09-01";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          dataFromAPI = DolarModel.fromJson(json.decode(res.body));
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REST API Example"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Valor del dólar"),
                      Text("Vigencia desde"),
                      Text("Vigencia hasta"),
                    ],
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$${dataFromAPI!.dolars[index].valor.toString()}"),
                          Text(dataFromAPI!.dolars[index].vigenciadesde.toString()),
                          Text(dataFromAPI!.dolars[index].vigenciahasta.toString()),
                        ],
                      ),
                    );
                  },
                  itemCount: dataFromAPI!.dolars.length,
                ),
              ],
            ),
    );
  }
}
