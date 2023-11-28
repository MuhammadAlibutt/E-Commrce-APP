//user model
class OutfitModel {
  String? outfitId;
  String? userId;
  String? image;
  String? rating;
  List? filter;

  OutfitModel({
    this.outfitId,
    this.userId,
    this.image,
    this.rating,
    this.filter,

  });

  OutfitModel.fromJson(Map<String, dynamic>? json) {
    outfitId = json!['outfitId'];
    userId = json['userId'];
    image = json['image'];
    rating = json['rating'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    return {
      'outfitId': outfitId,
      'userId': userId,
      'image': image,
      'rating': rating,
      'filter': filter,
    };
  }
}
