class City {
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  City({
    required this.isSelected,
    required this.city,
    required this.country,
    required this.isDefault,
  });

  static List<City> citiesList = [
    City(
      isSelected: false,
      city: 'Balikpapan',
      country: 'Indonesia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Bontang',
      country: 'Indonesia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Samarinda',
      country: 'Indonesia',
      isDefault: true,
    ),
    City(
      isSelected: false,
      city: 'Berau',
      country: 'Indonesia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Kutai Barat',
      country: 'Indonesia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Kutai Kartanegara',
      country: 'Indonesia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Kutai Timur',
      country: 'Indonesia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Mahakam Ulu',
      country: 'Indonesia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Paser',
      country: 'Indonesia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Penajam Paser Utara',
      country: 'Indonesia',
      isDefault: false,
    ),
  ];

  static List<City> getSelectedCities() {
    List<City> selectedCities = City.citiesList;
    return selectedCities.where((city) => city.isSelected == true).toList();
  }
}