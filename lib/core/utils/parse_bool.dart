bool parseStringToBool(String? value) {
  if (value == null) {
    return true; // or a default value
  }
  return value.toLowerCase() == 'true';
}
