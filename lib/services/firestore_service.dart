import '../data/sample_items.dart';
import '../models/item_model.dart';

class FirestoreService {
  static List<ItemModel> getItems() {
    return sampleItems;
  }

  static void addItem(ItemModel item) {
    sampleItems.insert(0, item);
  }

  static void deleteItem(String id) {
    sampleItems.removeWhere((item) => item.id == id);
  }
}
