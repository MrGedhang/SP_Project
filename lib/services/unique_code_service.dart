import 'dart:math';

class UniqueCode {
  final String code;
  final DateTime createdAt;
  final Duration expiresIn;

  UniqueCode(
    this.code,
    this.createdAt, {
    this.expiresIn = const Duration(hours: 2),
  });

  bool get isExpired => DateTime.now().isAfter(createdAt.add(expiresIn));
}

class UniqueCodeService {
  final Map<String, UniqueCode> _activeCodes = {};
  final Set<String> _usedCodes = {};

  String generateUniqueCode() {
    String newCode;
    do {
      int randomPart = Random().nextInt(100000);
      newCode = '25${randomPart.toString().padLeft(4, '0')}';
    } while (_activeCodes.containsKey(newCode));
    _activeCodes[newCode] = UniqueCode(newCode, DateTime.now());
    return newCode;
  }

  bool validateCode(String code) {
    final existing = _activeCodes[code];
    if (existing == null || existing.isExpired || _usedCodes.contains(code)) {
      return false;
    }
    return true;
  }

  void markCodeAsUsed(String code) {
    if (_activeCodes.containsKey(code)) {
      _usedCodes.add(code);
    }
  }

  void cleanExpiredCodes() {
    _activeCodes.removeWhere((key, value) => value.isExpired);
  }
}
