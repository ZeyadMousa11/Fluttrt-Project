
class CategoriesModel
{
  bool? status;
  CategoriesModelData? data;
  CategoriesModel.fromJson(Map<String,dynamic>json)
  {
    status= json['status'];
    data=CategoriesModelData.fromJson(json['data']) ;
  }
}

class CategoriesModelData
{
  dynamic currentPage;
  List<DataModel>? dataList=[];
  CategoriesModelData.fromJson(Map<String,dynamic>json)
  {
    currentPage=json['current_page'];
    json['data'].forEach((element)
    {
      dataList?.add(DataModel.fromJson(element));
    });

  }
}
class DataModel {
  int? id;
  String? image;
  String? name;

  DataModel.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}
