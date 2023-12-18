
class ListRequest {
  late int page;
  late int pageSize;
  late List<Map<String, dynamic>> filters;

  ListRequest.first(){
    page = 1;
    pageSize = 10;
    filters = [];
  }
  ListRequest(
      {
        required this.page,
        required this.pageSize,
        required this.filters,
      });

  Map<String, dynamic> toJson() => {
    "page": page,
    "pageSize": pageSize,
    "filters": filters,
  };

}
