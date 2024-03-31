// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomerAnalysisModal {
  String username;
  List<String> itemsBought;
  double totalSpend;
  CustomerAnalysisModal({
    required this.username,
    required this.itemsBought,
    required this.totalSpend,
  });

  @override
  String toString() =>
      'CustomerAnalysisModal(username: $username, itemsBought: $itemsBought, totalSpend: $totalSpend)';
}
