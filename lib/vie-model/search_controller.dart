import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';

class SearchController extends GetxController {
  final ApiService apiService = ApiService();
  var searchQuery = ''.obs;
  var searchResults =
      <Map<String, dynamic>>[].obs; // Ensure this is a list of maps

  void updateQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchResults() async {
    // Call the find method with the current search query
    final result = await apiService.find(searchQuery.value);

    // Check if the result is a list and contains valid items
    if (result['result'] is List) {
      // Clear previous results
      searchResults.clear();

      // Assign the list to searchResults directly
      searchResults.addAll(List<Map<String, dynamic>>.from(result['result']));
    } else {
      searchResults.clear(); // Clear results if the expected format is not met
    }

    // Print the search results for debugging
    print("Search Results: ${searchResults}");
  }

  void printQuery() {
    print("Search Query: ${searchQuery.value}");
    fetchResults(); // Fetch results when the query is printed
  }
}
