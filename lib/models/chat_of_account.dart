class ChartOfAccount {
  final String categoryCode;
  final String referenceCode;
  final String name;
  final String description;
  final List<ChartOfAccount> children;

  ChartOfAccount({
    this.categoryCode = "",
    required this.referenceCode,
    required this.name,
    required this.description,
    required this.children,
  });
}
