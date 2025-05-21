import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  // Getter singleton
  static Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDB();
  }

  // Init DB dan buat semua tabel
  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Tabel profil mahasiswa
        await db.execute('''
          CREATE TABLE user_profile (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nim TEXT,
            name TEXT,
            status TEXT
          )
        ''');

        // Tabel kendaraan
        await db.execute('''
          CREATE TABLE vehicles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            plate_number TEXT,
            vehicle_type TEXT
          )
        ''');

        // Tabel scan
        await db.execute('''
          CREATE TABLE scans (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT,
            timestamp TEXT
          )
        ''');

        // Tabel riwayat kehadiran
        await db.execute('''
          CREATE TABLE attendance_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            student_id TEXT,
            timestamp TEXT
          )
        ''');
        // Tabel serial number
        await db.execute('''
          CREATE TABLE serial_numbers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            serial TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  // ========== USER PROFILE ==========
  static Future<void> insertProfile(String nim, String name, String status) async {
    final db = await database;
    await db.delete('user_profile'); // hanya simpan satu profil
    await db.insert('user_profile', {
      'nim': nim,
      'name': name,
      'status': status,
    });
  }

  static Future<Map<String, dynamic>?> getProfile() async {
    final db = await database;
    final result = await db.query('user_profile', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  // ========== VEHICLES ==========
  static Future<void> insertVehicle(String plate, String type) async {
    final db = await database;
    await db.insert('vehicles', {
      'plate_number': plate,
      'vehicle_type': type,
    });
  }

  static Future<List<Map<String, dynamic>>> getVehicles() async {
    final db = await database;
    return await db.query('vehicles');
  }

  static Future<void> deleteVehicle(int id) async {
    final db = await database;
    await db.delete('vehicles', where: 'id = ?', whereArgs: [id]);
  }

  // ========== SCANS ==========
  static Future<void> insertScan(String content) async {
    final db = await database;
    await db.insert('scans', {
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  static Future<List<Map<String, dynamic>>> getAllScans() async {
    final db = await database;
    return await db.query('scans', orderBy: 'timestamp DESC');
  }

  // ========== ATTENDANCE HISTORY ==========
  static Future<void> insertAttendance(String studentId) async {
    final db = await database;
    await db.insert('attendance_history', {
      'student_id': studentId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  static Future<List<Map<String, dynamic>>> getAllAttendance() async {
    final db = await database;
    return await db.query('attendance_history', orderBy: 'timestamp DESC');
  }

  static Future<void> clearAllAttendance() async {
    final db = await database;
    await db.delete('attendance_history');
  }

  // ========== OPTIONAL: Clear All Data ==========
  static Future<void> clearAllData() async {
    final db = await database;
    await db.delete('user_profile');
    await db.delete('vehicles');
    await db.delete('scans');
    await db.delete('attendance_history');
  }

  // ========== SERIAL NUMBER ==========
static Future<void> insertSerialNumber(String serial) async {
  final db = await database;
  await db.insert('serial_numbers', {
    'serial': serial,
    'timestamp': DateTime.now().toIso8601String(),
  });
}

static Future<List<Map<String, dynamic>>> getAllSerialNumbers() async {
  final db = await database;
  return await db.query('serial_numbers', orderBy: 'timestamp DESC');
}

static Future<void> clearProfile() async {
  final db = await database;
  await db.delete('user_profile');
}


}
