import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/AppBarDolar/dolarAPIModel.dart';
import 'package:http/http.dart' as http;

class DolarAPIConsumo extends StatefulWidget {
  const DolarAPIConsumo({Key? key}) : super(key: key);

  @override
  State<DolarAPIConsumo> createState() => _DolarAPIConsumoState();
}

class _DolarAPIConsumoState extends State<DolarAPIConsumo> {
  bool _isLoading = false;
  TextEditingController _vigenciaDesdeController = TextEditingController();
  
  List<DolarApi> _dataFromAPI = [];

  _getData(String vigenciaDesde) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String url =
          "https://www.datos.gov.co/resource/ceyp-9c7c.json?vigenciadesde=2023-09-01";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(res.body);
        _dataFromAPI = jsonData.map((json) => DolarApi.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consulta de Precio del Dólar"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _vigenciaDesdeController,
                    decoration: InputDecoration(
                      labelText: "Ingrese la vigencia desde (YYYY-MM-DD)",
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final vigenciaDesde = _vigenciaDesdeController.text;
                    _getData(vigenciaDesde);
                  },
                  child: const Text("Consultar"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _dataFromAPI.length,
                    itemBuilder: (context, index) {
                      final dolar = _dataFromAPI[index];
                      return ListTile(
                        title: Text("Valor del dólar: \$${dolar.valor} COP"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vigencia desde: ${dolar.vigenciadesde}"),
                            Text("Vigencia hasta: ${dolar.vigenciahasta}"),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}