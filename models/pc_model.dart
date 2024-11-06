class PCInventory {
  int? id;
  String cpuType;
  String ramSize;
  String storageType;

  PCInventory({this.id, required this.cpuType, required this.ramSize, required this.storageType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cpuType': cpuType,
      'ramSize': ramSize,
      'storageType': storageType,
    };
  }

  factory PCInventory.fromMap(Map<String, dynamic> map) {
    return PCInventory(
      id: map['id'],
      cpuType: map['cpuType'],
      ramSize: map['ramSize'],
      storageType: map['storageType'],
    );
  }
}
