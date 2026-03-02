

import '../../domain/entites/popularProverbs.dart';

class PopularProverbsModel extends PopularProverbs
{
  PopularProverbsModel({
   required super.titel, 
   required super.descrption, 
   });

  factory PopularProverbsModel.fromJson(Map<String,dynamic> json) =>PopularProverbsModel(

    titel: json["title"],
    descrption: json["description"],

  );

  Map<String,dynamic> toJson() =>{

    "titel":titel,
    "descrption":descrption,

  };
}