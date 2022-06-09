class Joke {
  String setup;
  String punchline;
  bool nsfw;
  bool religious;
  bool political;
  bool racist;
  bool sexist;
  bool explicit;
  bool safe;

  Joke(
      {required this.setup,
      required this.punchline,
      required this.nsfw,
      required this.religious,
      required this.political,
      required this.racist,
      required this.sexist,
      required this.explicit,
      required this.safe});

  factory Joke.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Joke(
      setup: parsedJson['setup'] ?? "",
      punchline: parsedJson['punchline'] ?? "",
      nsfw: parsedJson['nsfw'] ?? false,
      religious: parsedJson['flag_religious'] ?? false,
      political: parsedJson['flag_political'] ?? false,
      racist: parsedJson['flag_racist'] ?? false,
      sexist: parsedJson['flag_sexist'] ?? false,
      explicit: parsedJson['flag_explicit'] ?? false,
      safe: parsedJson['safe'] ?? true,
    );
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "setup": setup,
      "punchline": punchline,
      "flag_nsfw": nsfw,
      "flag_religious": religious,
      "flag_political": political,
      "flag_racist": racist,
      "flag_sexist": sexist,
      "flag_explicit": explicit,
      "safe": safe,
    };
  }
}
