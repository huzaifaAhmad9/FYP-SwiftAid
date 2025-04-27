class AppRoutes {
  // static const String mapApi = "AIzaSyAbEwS-6kyBW66udi_E6PnlyTtTHg3NsWA";
  static const String mapApi = "AIzaSyDaaNW6khrCkxJesgZCZ9lEqGqfPS6373Q";
  static String nearbyHospitalsUrl(double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude&radius=3500&type=hospital&key=$mapApi';
  }
}
