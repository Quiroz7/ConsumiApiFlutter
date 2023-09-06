
import 'dart:convert';


DolarModel dataModelFromJson(String str) => DolarModel.fromJson(json.decode(str));

String dataModelToJson(DolarModel data) => json.encode(data.toJson());

class DolarModel {
    DolarModel({
        required this.dolars,
        
    });


    List<DolarApi> dolars;
   

    factory DolarModel.fromJson(List<dynamic> json) => DolarModel(
        dolars: List<DolarApi>.from(json.map((x) => DolarApi.fromJson(x))),
       
    );

    Map<String, dynamic> toJson() => {
        "dolars": List<dynamic>.from(dolars.map((x) => x.toJson())),
        
    };
}

class DolarApi {
    DolarApi({
    required this.valor,
    required this.vigenciadesde,
    required this.vigenciahasta,
        
        
    });

    String valor;
    String vigenciadesde;
    String vigenciahasta;
      
    
    factory DolarApi.fromJson(Map<String, dynamic> json) => DolarApi(
      valor: json["valor"],
      vigenciadesde: json["vigenciadesde"],
      vigenciahasta: json["vigenciahasta"],
        
    );

    Map<String, dynamic> toJson() => {
         "valor": valor,
        "vigenciadesde": vigenciadesde,
        "vigenciahasta": vigenciahasta,
        
        
    };
}

  

