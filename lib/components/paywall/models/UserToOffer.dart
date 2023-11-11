import 'package:cloud_firestore/cloud_firestore.dart';

class UserToOffer {
  final Timestamp timestamp;
  final String offerId;
  final String userId;
  UserToOffer(this.offerId, this.userId, this.timestamp);

  factory UserToOffer.fromJson(Map<String, dynamic> data) {
    return UserToOffer(data["paywall_to_offerId"], data["paywall_to_userId"],
        data["last_updated"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "paywall_to_offerId": this.offerId,
      "paywall_to_userId": this.userId,
      "last_updated": this.timestamp
    };
  }
}
