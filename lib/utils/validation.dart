String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) return "Name is required";
  return null;
}

String? validateYear(String? value) {
  if (value == null || value.trim().isEmpty) return "Year is required";
  final year = int.tryParse(value.trim());
  if (year == null) return "Enter a whole number";

  if (year < 1949 || year > DateTime.now().year + 1) return "Enter a valid year";
  return null;
}

String? validatePieces(String? value) {
  if (value == null || value.trim().isEmpty) return "Pieces is required";
  final pieces = int.tryParse(value.trim());
  if (pieces == null) return "Enter a whole number";
  if (pieces <= 0) return "Must be greater than 0";
  return null;
}

String? validatePrice(String? value) {
  if (value == null || value.trim().isEmpty) return "Price is required";
  final price = double.tryParse(value.trim());
  if (price == null || !price.isFinite) return "Enter a valid price";
  if (price < 0) return "Price can't be negative";
  return null;
}
