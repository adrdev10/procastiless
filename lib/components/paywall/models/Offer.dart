import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final List<String> bulletInfo;
  final String description;
  final String name;
  final String offerId;
  final int price;

  Offer(this.bulletInfo, this.description, this.name, this.offerId, this.price);

  factory Offer.offerFromJson(Map<String, dynamic> data) {
    return Offer(data["bulletInfo"], data["description"], data["name"],
        data["offerId"], data["price"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'bulletInfo': this.bulletInfo,
      'description': this.description,
      'name': this.name,
      'offerId': this.offerId,
      'price': this.price,
    };
  }

  @override
  List<Object?> get props => [
        this.bulletInfo,
        this.description,
        this.name,
        this.name,
        this.offerId,
        this.price
      ];
}
