class ResultModel{
  final bool? acknowledged;
  final int? modifiedCount;
  final dynamic upsertedId;
  final int? upsertedCount;
  final int? matchedCount;

  ResultModel({this.acknowledged, this.modifiedCount, this.upsertedId,this.upsertedCount,this.matchedCount});

  //mapping json data
  factory ResultModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = ResultModel(
        acknowledged: jsonMap["acknowledged"],
        modifiedCount: jsonMap["modifiedCount"],
        upsertedId: jsonMap["upsertedId"],
        upsertedCount:jsonMap["upsertedCount"],
        matchedCount:jsonMap["matchedCount"],
    );
    return data;
  }
}