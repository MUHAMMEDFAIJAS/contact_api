class ContactModel {
  String? sId;
  String? name;
  String? email;
  int? phone;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ContactModel({
    this.sId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ContactModel.fromJson(Map<String, dynamic> s) {
    sId = s['_id'];
    name = s['name'];
    email = s['email'];
    phone = s['phone'];
    address = s['address'];
    createdAt = s['createdAt'];
    updatedAt = s['updatedAt'];
    iV = s['__v'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}
