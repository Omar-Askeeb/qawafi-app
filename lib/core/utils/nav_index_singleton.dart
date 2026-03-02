class NavSingleton {
  // Private constructor
  NavSingleton._privateConstructor();

  // Singleton instance
  static final NavSingleton _instance = NavSingleton._privateConstructor();

  // Factory method to access the singleton instance
  factory NavSingleton() {
    return _instance;
  }

  // Integer value storage
  int _intValue = 0;

  // Getter for integer value
  int get intValue => _intValue;

  // Setter for integer value
  set intValue(int value) {
    _intValue = value;
  }
}
