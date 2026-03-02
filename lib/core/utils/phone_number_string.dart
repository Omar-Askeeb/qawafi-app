String getPhoneNumber(String phoneNo) {
  // ignore: prefer_interpolation_to_compose_strings
  return '218' +
      (phoneNo.substring(0, 1) == '0'
          ? phoneNo.replaceFirst('0', '')
          : phoneNo);
}
