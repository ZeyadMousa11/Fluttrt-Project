class ChangeFavModel
{
  bool? status;
  String? message;
  ChangeFavModel.fromjson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}