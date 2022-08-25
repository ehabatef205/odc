class ProductIdModel {
  String? type;
  String? message;
  Data? data;

  ProductIdModel({this.type, this.message, this.data});

  ProductIdModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? productId;
  String? name;
  String? description;
  String? imageUrl;
  String? type;
  int? price;
  bool? available;
  List<Seed>? seed;
  Plant? plant;
  List<Tool>? tool;

  Data(
      {this.productId,
      this.name,
      this.description,
      this.imageUrl,
      this.type,
      this.price,
      this.available,
      this.seed,
      this.plant,
      this.tool});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    price = json['price'];
    available = json['available'];
    seed = json['seed'];
    plant = json['plant'] != null ? Plant.fromJson(json['plant']) : null;
    tool = json['tool'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['type'] = type;
    data['price'] = price;
    data['available'] = available;
    data['seed'] = seed;
    if (plant != null) {
      data['plant'] = plant!.toJson();
    }
    data['tool'] = tool;
    return data;
  }
}

class Plant {
  String? plantId;
  String? name;
  String? description;
  String? imageUrl;
  int? waterCapacity;
  int? sunLight;
  int? temperature;

  Plant(
      {this.plantId,
      this.name,
      this.description,
      this.imageUrl,
      this.waterCapacity,
      this.sunLight,
      this.temperature});

  Plant.fromJson(Map<String, dynamic> json) {
    plantId = json['plantId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plantId'] = plantId;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['waterCapacity'] = waterCapacity;
    data['sunLight'] = sunLight;
    data['temperature'] = temperature;
    return data;
  }
}

class Seed {
  String? seedId;
  String? name;
  String? description;
  String? imageUrl;

  Seed({
    this.seedId,
    this.name,
    this.description,
    this.imageUrl,
  });

  Seed.fromJson(Map<String, dynamic> json) {
    seedId = json['seedId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seedId'] = seedId;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class Tool {
  String? toolId;
  String? name;
  String? description;
  String? imageUrl;

  Tool({
    this.toolId,
    this.name,
    this.description,
    this.imageUrl,
  });

  Tool.fromJson(Map<String, dynamic> json) {
    toolId = json['toolId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toolId'] = toolId;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
