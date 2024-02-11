class ComicsResponse {
  ComicsResponse({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHTML,
    required this.etag,
    required this.data,
  });
  late final int code;
  late final String status;
  late final String copyright;
  late final String attributionText;
  late final String attributionHTML;
  late final String etag;
  late final Data data;

  ComicsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    copyright = json['copyright'];
    attributionText = json['attributionText'];
    attributionHTML = json['attributionHTML'];
    etag = json['etag'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    _data['copyright'] = copyright;
    _data['attributionText'] = attributionText;
    _data['attributionHTML'] = attributionHTML;
    _data['etag'] = etag;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });
  late final int offset;
  late final int limit;
  late final int total;
  late final int count;
  late final List<Comics> results;

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    results =
        List.from(json['results']).map((e) => Comics.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['offset'] = offset;
    _data['limit'] = limit;
    _data['total'] = total;
    _data['count'] = count;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Comics {
  Comics({
    required this.id,
    required this.digitalId,
    required this.title,
    required this.issueNumber,
    required this.variantDescription,
    this.description,
    required this.modified,
    required this.isbn,
    required this.upc,
    required this.diamondCode,
    required this.ean,
    required this.issn,
    required this.format,
    required this.pageCount,
    required this.textObjects,
    required this.resourceURI,
    required this.urls,
    required this.series,
    required this.variants,
    required this.collections,
    required this.collectedIssues,
    required this.dates,
    required this.prices,
    required this.thumbnail,
    required this.images,
    required this.creators,
    required this.characters,
    required this.stories,
    required this.events,
  });
  late final int id;
  late final int digitalId;
  late final String title;
  late final int issueNumber;
  late final String variantDescription;
  late final String? description;
  late final String modified;
  late final String isbn;
  late final String upc;
  late final String diamondCode;
  late final String ean;
  late final String issn;
  late final String format;
  late final int pageCount;
  late final List<TextObjects> textObjects;
  late final String resourceURI;
  late final List<Urls> urls;
  late final Series series;
  late final List<Variants> variants;
  late final List<dynamic> collections;
  late final List<CollectedIssues> collectedIssues;
  late final List<Dates> dates;
  late final List<Prices> prices;
  late final Thumbnail thumbnail;
  late final List<Images> images;
  late final Creators creators;
  late final Characters characters;
  late final Stories stories;
  late final Events events;

  Comics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    digitalId = json['digitalId'];
    title = json['title'];
    issueNumber = json['issueNumber'];
    variantDescription =
        json['variantDescription'] ?? ''; // Valor por defecto si es null
    description = json['description']; // Ya es nullable
    modified = json['modified'];
    isbn = json['isbn'] ?? ''; // Valor por defecto si es null
    upc = json['upc'] ?? ''; // Valor por defecto si es null
    diamondCode = json['diamondCode'] ?? ''; // Valor por defecto si es null
    ean = json['ean'] ?? ''; // Valor por defecto si es null
    issn = json['issn'] ?? ''; // Valor por defecto si es null
    format = json['format'] ?? ''; // Valor por defecto si es null
    pageCount = json['pageCount'];
    textObjects = (json['textObjects'] as List)
        .map((e) => TextObjects.fromJson(e))
        .toList();
    resourceURI = json['resourceURI'];
    urls = (json['urls'] as List).map((e) => Urls.fromJson(e)).toList();
    series = Series.fromJson(json['series']);
    variants =
        (json['variants'] as List).map((e) => Variants.fromJson(e)).toList();
    collections = json['collections'] ?? []; // Lista vacía si es null
    collectedIssues = (json['collectedIssues'] as List)
        .map((e) => CollectedIssues.fromJson(e))
        .toList();
    dates = (json['dates'] as List).map((e) => Dates.fromJson(e)).toList();
    prices = (json['prices'] as List).map((e) => Prices.fromJson(e)).toList();
    thumbnail = Thumbnail.fromJson(json['thumbnail']);
    images = (json['images'] as List).map((e) => Images.fromJson(e)).toList();
    creators = Creators.fromJson(json['creators']);
    characters = Characters.fromJson(json['characters']);
    stories = Stories.fromJson(json['stories']);
    events = Events.fromJson(json['events']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['digitalId'] = digitalId;
    _data['title'] = title;
    _data['issueNumber'] = issueNumber;
    _data['variantDescription'] = variantDescription;
    _data['description'] = description;
    _data['modified'] = modified;
    _data['isbn'] = isbn;
    _data['upc'] = upc;
    _data['diamondCode'] = diamondCode;
    _data['ean'] = ean;
    _data['issn'] = issn;
    _data['format'] = format;
    _data['pageCount'] = pageCount;
    _data['textObjects'] = textObjects.map((e) => e.toJson()).toList();
    _data['resourceURI'] = resourceURI;
    _data['urls'] = urls.map((e) => e.toJson()).toList();
    _data['series'] = series.toJson();
    _data['variants'] = variants.map((e) => e.toJson()).toList();
    _data['collections'] = collections;
    _data['collectedIssues'] = collectedIssues.map((e) => e.toJson()).toList();
    _data['dates'] = dates.map((e) => e.toJson()).toList();
    _data['prices'] = prices.map((e) => e.toJson()).toList();
    _data['thumbnail'] = thumbnail.toJson();
    _data['images'] = images.map((e) => e.toJson()).toList();
    _data['creators'] = creators.toJson();
    _data['characters'] = characters.toJson();
    _data['stories'] = stories.toJson();
    _data['events'] = events.toJson();
    return _data;
  }
}

class TextObjects {
  TextObjects({
    required this.type,
    required this.language,
    required this.text,
  });
  late final String type;
  late final String language;
  late final String text;

  TextObjects.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    language = json['language'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['language'] = language;
    _data['text'] = text;
    return _data;
  }
}

class Urls {
  Urls({
    required this.type,
    required this.url,
  });
  late final String type;
  late final String url;

  Urls.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['url'] = url;
    return _data;
  }
}

class Series {
  Series({
    required this.resourceURI,
    required this.name,
  });
  late final String resourceURI;
  late final String name;

  Series.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['resourceURI'] = resourceURI;
    _data['name'] = name;
    return _data;
  }
}

class Variants {
  Variants({
    required this.resourceURI,
    required this.name,
  });
  late final String resourceURI;
  late final String name;

  Variants.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['resourceURI'] = resourceURI;
    _data['name'] = name;
    return _data;
  }
}

class CollectedIssues {
  CollectedIssues({
    required this.resourceURI,
    required this.name,
  });
  late final String resourceURI;
  late final String name;

  CollectedIssues.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['resourceURI'] = resourceURI;
    _data['name'] = name;
    return _data;
  }
}

class Dates {
  Dates({
    required this.type,
    required this.date,
  });
  late final String type;
  late final String date;

  Dates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['date'] = date;
    return _data;
  }
}

class Prices {
  Prices({
    required this.type,
    this.price, // Cambiado a double? para permitir valores nulos y de punto flotante
  });
  late final String type;
  late final double? price; // Permitir valores nulos y de punto flotante

  Prices.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    // Se verifica si el precio es null, en cuyo caso se deja como null,
    // de lo contrario, se convierte a double con toDouble(),
    // permitiendo que sea un valor de punto flotante.
    price = json['price']?.toDouble(); // Convertir a double si no es null
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['price'] = price;
    return _data;
  }
}

class Thumbnail {
  Thumbnail({
    required this.path,
    required this.extension,
  });
  late final String path;
  late final String extension;

  Thumbnail.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['path'] = path;
    _data['extension'] = extension;
    return _data;
  }
}

class Images {
  Images({
    required this.path,
    required this.extension,
  });
  late final String path;
  late final String extension;

  Images.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['path'] = path;
    _data['extension'] = extension;
    return _data;
  }
}

class Creators {
  Creators({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });
  late final int available;
  late final String collectionURI;
  late final List<Items> items;
  late final int returned;

  Creators.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['available'] = available;
    _data['collectionURI'] = collectionURI;
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['returned'] = returned;
    return _data;
  }
}

class Items {
  Items({
    required this.resourceURI,
    required this.name,
    required this.role,
  });
  late final String resourceURI;
  late final String name;
  late final String role;

  Items.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'] as String? ??
        ''; // Proporciona un valor predeterminado si es null
    name = json['name'] as String? ??
        ''; // Proporciona un valor predeterminado si es null
    role = json['role'] as String? ??
        ''; // Proporciona un valor predeterminado si es null
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['resourceURI'] = resourceURI;
    _data['name'] = name;
    _data['role'] = role;
    return _data;
  }
}

class Characters {
  Characters({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });
  late final int available;
  late final String collectionURI;
  late final List<Items> items;
  late final int returned;

  Characters.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['available'] = available;
    _data['collectionURI'] = collectionURI;
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['returned'] = returned;
    return _data;
  }
}

class Stories {
  Stories({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });
  late final int available;
  late final String collectionURI;
  late final List<Items> items;
  late final int returned;

  Stories.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['available'] = available;
    _data['collectionURI'] = collectionURI;
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['returned'] = returned;
    return _data;
  }
}

class Events {
  Events({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });
  late final int available;
  late final String collectionURI;
  late final List<dynamic> items;
  late final int returned;

  Events.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    items = List.castFrom<dynamic, dynamic>(json['items']);
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['available'] = available;
    _data['collectionURI'] = collectionURI;
    _data['items'] = items;
    _data['returned'] = returned;
    return _data;
  }
}
