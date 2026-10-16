import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../data/sample_items.dart';
import '../models/item_model.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference<Map<String, dynamic>> _itemsCol =
      _firestore.collection('items');
  static StreamSubscription? _subscription;

  static CollectionReference<Map<String, dynamic>> get itemsCollection => _itemsCol;

  // Upload a new item to Cloud Firestore
  static Future<void> addItem(ItemModel item) async {
    try {
      await _itemsCol.doc(item.id).set(item.toMap());
      debugPrint('[FIRESTORE] Uploaded item ${item.id}: ${item.title}');
    } catch (e) {
      debugPrint('[FIRESTORE ERROR] addItem: $e');
    }
    final idx = sampleItems.indexWhere((i) => i.id == item.id);
    if (idx != -1) {
      sampleItems[idx] = item;
    } else {
      sampleItems.insert(0, item);
    }
  }

  // Update an existing item in Cloud Firestore
  static Future<void> updateItem(ItemModel item) async {
    try {
      await _itemsCol.doc(item.id).set(item.toMap(), SetOptions(merge: true));
      debugPrint('[FIRESTORE] Updated item ${item.id}');
    } catch (e) {
      debugPrint('[FIRESTORE ERROR] updateItem: $e');
    }
    final idx = sampleItems.indexWhere((i) => i.id == item.id);
    if (idx != -1) {
      sampleItems[idx] = item;
    }
  }

  // Delete an item from Cloud Firestore
  static Future<void> deleteItem(String id) async {
    try {
      await _itemsCol.doc(id).delete();
      debugPrint('[FIRESTORE] Deleted item $id');
    } catch (e) {
      debugPrint('[FIRESTORE ERROR] deleteItem: $e');
    }
    sampleItems.removeWhere((i) => i.id == id);
  }

  // Stream of items from Cloud Firestore
  static Stream<List<ItemModel>> getItemsStream() {
    return _itemsCol.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ItemModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Start real-time sync with Cloud Firestore
  static void startRealtimeSync({VoidCallback? onUpdate}) {
    _subscription?.cancel();
    _subscription = _itemsCol.snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final cloudItems = snapshot.docs
            .map((doc) => ItemModel.fromMap(doc.data(), doc.id))
            .toList();
        sampleItems.clear();
        sampleItems.addAll(cloudItems);
        debugPrint('[FIRESTORE] Synced ${cloudItems.length} items from cloud.');
        onUpdate?.call();
      }
    }, onError: (e) {
      debugPrint('[FIRESTORE SYNC ERROR] $e');
    });
  }

  // Initial sync & seed default items if Firestore is empty
  static Future<void> initialize() async {
    try {
      final snapshot = await _itemsCol.limit(1).get();
      if (snapshot.docs.isEmpty) {
        final batch = _firestore.batch();
        for (final item in sampleItems) {
          batch.set(_itemsCol.doc(item.id), item.toMap());
        }
        await batch.commit();
        debugPrint('[FIRESTORE] Seeded ${sampleItems.length} items to cloud database.');
      } else {
        final all = await _itemsCol.get();
        final cloudItems = all.docs
            .map((doc) => ItemModel.fromMap(doc.data(), doc.id))
            .toList();
        if (cloudItems.isNotEmpty) {
          sampleItems.clear();
          sampleItems.addAll(cloudItems);
          debugPrint('[FIRESTORE] Loaded ${cloudItems.length} items on startup.');
        }
      }
    } catch (e) {
      debugPrint('[FIRESTORE INIT ERROR] $e');
    }
  }
}
