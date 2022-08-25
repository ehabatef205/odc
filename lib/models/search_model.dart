class SearchModel {
  String? type;
  String? message;
  Data? data;

  SearchModel({this.type, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
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
  List<Plants>? plants;
  List<Seeds>? seeds;
  List<Tools>? tools;

  Data({this.plants, this.seeds, this.tools});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['plants'] != null) {
      plants = <Plants>[];
      json['plants'].forEach((v) {
        plants!.add(Plants.fromJson(v));
      });
    }
    if (json['seeds'] != null) {
      seeds = <Seeds>[];
      json['seeds'].forEach((v) {
        seeds!.add(Seeds.fromJson(v));
      });
    }
    if (json['tools'] != null) {
      tools = <Tools>[];
      json['tools'].forEach((v) {
        tools!.add(Tools.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (plants != null) {
      data['plants'] = plants!.map((v) => v.toJson()).toList();
    }
    if (seeds != null) {
      data['seeds'] = seeds!.map((v) => v.toJson()).toList();
    }
    if (tools != null) {
      data['tools'] = tools!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plants {
  String? name;

  Plants({this.name});

  Plants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Seeds {
  String? name;

  Seeds({this.name});

  Seeds.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Tools {
  String? name;

  Tools({this.name});

  Tools.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
