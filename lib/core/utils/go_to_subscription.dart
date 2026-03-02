class RedirectSignupFlagSingleton {
  // Private constructor
  RedirectSignupFlagSingleton._privateConstructor();

  // Singleton instance
  static final RedirectSignupFlagSingleton _instance =
      RedirectSignupFlagSingleton._privateConstructor();

  // Factory method to access the singleton instance
  factory RedirectSignupFlagSingleton() {
    return _instance;
  }

  // Integer value storage
  bool _isRedirct = false;

  // Getter for integer value
  bool get isRedirect => _isRedirct;

  // Setter for integer value
  set isRedirect(bool value) {
    _isRedirct = value;
  }
}
