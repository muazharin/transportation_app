String? Function(String? v, String n)? valString = (v, n) {
  if (v!.isEmpty) {
    return "$n harus diisi";
  }
  return null;
};
String? Function(String? v, String n)? valNumber = (v, n) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (v!.isEmpty) {
    return "$n harus diisi";
  } else if (!regExp.hasMatch(v)) {
    return "$n harus berisi nomor";
  }
  return null;
};
String? Function(String? v, String n, int? min)? valNumberLimit = (v, n, min) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (v!.isEmpty) {
    return "$n harus diisi";
  } else if (!regExp.hasMatch(v)) {
    return "$n harus berisi nomor";
  } else if (v.length < min!) {
    return "$n minimal $min digit";
  }
  return null;
};
String? Function(String? v, String n)? valNumberTextOnly = (v, n) {
  String patttern = r'^(?=.*[A-Za-z])(?=.*\d).+$';
  RegExp regExp = RegExp(patttern);
  if (v!.isEmpty) {
    return "$n harus diisi";
  } else if (!regExp.hasMatch(v)) {
    return "$n harus berisi angka dan text";
  }
  return null;
};

String? Function(String? v, String n)? valEmail = (v, n) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n harus diisi";
  } else if (!regExp.hasMatch(v)) {
    return "$n tidak valid";
  }
  return null;
};

String? Function(String? v, String n)? valPassword = (v, n) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n harus diisi";
  } else if (!regExp.hasMatch(v)) {
    return "$n minimal 8 karakter dan memiliki setidaknya 1 huruf kecil, 1 huruf kapital, 1 nomor dan 1 spesial karakter ( ! @ # \$ & * ~ )";
  }
  return null;
};

String? Function(String? v, String? n, String? m)? valCPassword = (v, n, m) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n harus diisi";
  } else if (v != m) {
    return "$n doesn't match";
  } else if (!regExp.hasMatch(v)) {
    return "$n minimal 8 karakter dan memiliki setidaknya 1 huruf kecil, 1 huruf kapital, 1 nomor dan 1 spesial karakter ( ! @ # \$ & * ~ )";
  }
  return null;
};

String? Function(String? v, String n)? valPhone = (v, n) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (v!.isEmpty) {
    return "$n harus diisi";
  } else if (v.length < 10) {
    return "$n harus berisi minimal 10 digit";
  } else if (!regExp.hasMatch(v)) {
    return "$n harus berisi nomor";
  }
  return null;
};
