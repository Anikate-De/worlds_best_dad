class Joke {
  String setup;
  String delivery;

  Joke({required this.setup, required this.delivery});

  factory Joke.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Joke(
        setup: parsedJson['setup'] ?? "",
        delivery: parsedJson['delivery'] ?? "");
  }

  Map<String, dynamic> toJsonMap() {
    return {
      "setup": setup,
      "delivery": delivery,
    };
  }
}
