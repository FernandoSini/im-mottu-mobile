import 'package:flutter/material.dart';

class ResponseModel {
  int? code;
  String? status;
  String? copyright;
  String? attributionText;
  String? attributionHTML;
  Data? data;
  String? etag;

  ResponseModel(
      {this.code,
      this.status,
      this.copyright,
      this.attributionText,
      this.attributionHTML,
      this.data,
      this.etag});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json['status'];
    copyright = json['copyright'];
    attributionText = json['attributionText'];
    attributionHTML = json['attributionHTML'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    etag = json['etag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['status'] = status;
    data['copyright'] = copyright;
    data['attributionText'] = attributionText;
    data['attributionHTML'] = attributionHTML;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['etag'] = etag;
    return data;
  }
}

class Data {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<Character>? results;

  Data({this.offset, this.limit, this.total, this.count, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      results = <Character>[];
      json['results'].forEach((v) {
        results!.add(new Character.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = offset;
    data['limit'] = limit;
    data['total'] = total;
    data['count'] = count;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Character {
  int? id;
  String? name;
  String? description;
  String? modified;
  String? resourceURI;
  List<Urls>? urls;
  Thumbnail? thumbnail;
  Comics? comics;
  Comics? stories;
  Comics? events;
  Comics? series;

  Character(
      {this.id,
      this.name,
      this.description,
      this.modified,
      this.resourceURI,
      this.urls,
      this.thumbnail,
      this.comics,
      this.stories,
      this.events,
      this.series});

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    modified = json['modified'];
    resourceURI = json['resourceURI'];
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((v) {
        urls!.add(new Urls.fromJson(v));
      });
    }
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    comics =
        json['comics'] != null ? new Comics.fromJson(json['comics']) : null;
    stories =
        json['stories'] != null ? new Comics.fromJson(json['stories']) : null;
    events =
        json['events'] != null ? new Comics.fromJson(json['events']) : null;
    series =
        json['series'] != null ? new Comics.fromJson(json['series']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['modified'] = modified;
    data['resourceURI'] = resourceURI;
    if (urls != null) {
      data['urls'] = urls!.map((v) => v.toJson()).toList();
    }
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    if (comics != null) {
      data['comics'] = comics!.toJson();
    }
    if (stories != null) {
      data['stories'] = stories!.toJson();
    }
    if (events != null) {
      data['events'] = events!.toJson();
    }
    if (series != null) {
      data['series'] = series!.toJson();
    }
    return data;
  }
}

class Urls {
  String? type;
  String? url;

  Urls({this.type, this.url});

  Urls.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}

class Thumbnail {
  String? path;
  String? extension;

  Thumbnail({this.path, this.extension});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = path;
    data['extension'] = extension;
    return data;
  }
}

class Comics {
  int? available;
  int? returned;
  String? collectionURI;
  List<Items>? items;

  Comics({this.available, this.returned, this.collectionURI, this.items});

  Comics.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    returned = json['returned'];
    collectionURI = json['collectionURI'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = available;
    data['returned'] = returned;
    data['collectionURI'] = collectionURI;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? resourceURI;
  String? name;
  String? type;

  Items({this.resourceURI, this.name, this.type});

  Items.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resourceURI'] = resourceURI;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
