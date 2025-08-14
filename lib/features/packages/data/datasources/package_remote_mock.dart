import '../models/travel_package_model.dart';

/// Mock remote datasource for travel packages.
class PackageRemoteMock {
  final List<Map<String, dynamic>> _packages = [
    {
      "id": "pkg-001",
      "title": "Derawan Explorer 3D2N",
      "location": "Kep. Derawan, Kaltara",
      "gallery": ["img1", "img2", "img3"],
      "pricePerPax": 1450000,
      "overview":
          "Snorkeling spot terbaik, penginapan tepi pantai, guide lokal.",
      "latitude": 2.283,
      "longitude": 118.242,
      "minPax": 1,
      "maxPax": 12,
      "type": "open",
      "itinerary": [
        {
          "day": 1,
          "title": "Arrival & Check-in",
          "activities": ["Boat transfer", "Check-in", "Sunset walk"],
          "meals": ["L"]
        },
        {
          "day": 2,
          "title": "Island Hopping",
          "activities": [
            "Snorkeling 2 spot",
            "Turtle watching",
            "BBQ dinner"
          ],
          "meals": ["P", "S", "M"]
        },
        {
          "day": 3,
          "title": "Free & Easy",
          "activities": ["Photography", "Checkout"],
          "meals": ["P"]
        }
      ],
      "reviews": [
        {
          "userName": "Rina",
          "rating": 4.8,
          "comment": "Tripnya mantap!",
          "createdAt": "2025-07-10T00:00:00Z"
        },
        {
          "userName": "Akbar",
          "rating": 4.5,
          "comment": "Guide ramah.",
          "createdAt": "2025-07-12T00:00:00Z"
        }
      ]
    },
    {
      "id": "pkg-002",
      "title": "Maratua Getaway 2D1N",
      "location": "Pulau Maratua",
      "gallery": ["img1"],
      "pricePerPax": 950000,
      "overview": "Liburan singkat ke surga tersembunyi.",
      "latitude": 2.2,
      "longitude": 118.3,
      "minPax": 1,
      "maxPax": 8,
      "type": "private",
      "itinerary": [],
      "reviews": []
    }
  ];

  Future<TravelPackageModel> getPackage(String id) async {
    final json = _packages.firstWhere((e) => e['id'] == id);
    return TravelPackageModel.fromJson(json);
  }
}
