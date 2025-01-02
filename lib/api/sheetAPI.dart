// sheetAPI.dart

import 'package:gsheets/gsheets.dart';

// 서비스 계정 JSON 파일을 통해 인증 정보를 설정합니다.
class TabacoSheetApi {
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "tabacodata",
    "private_key_id": "db5f6b81dd0f584de03ccdb43210017a3d7ed39f",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC9//ynIPkjZxXp\nHcMZYJTnJ2wdLy7j42dfIegxlkQjf6tb5lz+7I4jiq4J6idZ++pZG7dwBEahWu6U\nK143+wJRA2560qoHC3cQk7YE9ynUAd7/gdOgFeJgkvyZ3jfjCDuR79witjW9WFA9\n/eaesDwetT/dXw6K9Dsg56CK9LDyHOFdIyVve940EpoKoSc5Rql92M7xJPiG9q3A\nsTj3IknagE7AjWv3icc6ncaKOQ64L7uIPUe038HYo0/8RuvcyrCJX2/TvOFcUMMW\n/0aK1ZRj6Hvi389cf6HlE6TNFUKUZH/yr8tURK15BJ2RUHJsCpD+8Fzka67ezrwj\nKGG8HIUrAgMBAAECggEAA/7RRH8+E0kK29fRLSIazEodRG7GXreg8JaoE9pVFHsW\nig+nqT02ndWEMUI/iQ+LngdIPuPYIOpd71DG8vd6stuOjIal0O8Kp0HJQQStRyop\nTthOMEcSVTFKnotNuydkXY9lJwBhGGK+xLEWaGqIDFB2nKzWP1GFl3QURca0z7fc\nE5XWgBDW1mPTBQ6xabr/yVwcHgmPg6dVsZv0OX2VtHE9yIEWAdI3ZiTB1igh+cQQ\nJEZpQJC3Xy3903Rtnba3uTG9Orcjw0i3R3KPshEirwl/Z0//KP8YfNtnOUdlpj56\n0X94hrrRR1psv6Hyr0VHe58yky2DTGaDOZdMdGV6AQKBgQDhaLd71plIgW81eX9x\nyERbsAekkylljYAsdSvwjhxjDTUyTKIjj146fF3Pl2RUXapBEZJTYkX06OOrcLWE\nwiAH6E4vczJjFZRcXgXoBaV+SPSHx3Hl/tmiJNSdnTZD8Q4ifPj/Tz0gU5/A778t\nMp2NYAjiAJX83l5Cs+WtI1g2VwKBgQDXyRFq4NWcrUoQ4tgvUcZIPSSOhomzZJMV\noJ0qRZ2hRg8OjkivsYpVGOuoouk2Cb8Up5SgmXeh9X06EnsDCmgQRiVCbDZeBjOB\nC44JQHnnT8YTdheCDFZ3Y2Mf4KwSsTud3DlLQ52khRoxWeJGx/76vC1c7O7YYhWY\nuMxIOE8bTQKBgQDBBgRBxuYiQbyyxSVOkVmAToBs/Rww+3gsGfaTm45RgAjy1s7t\ntqLRYJiQ4SqoWEEoUVzFjN0tOZVkxTKbygTV4Ke7WGFomh0e7+EM7HDocJ79+tvd\nQVyqzfFIO00x5yXcgLpVH0zP9uxRsrw6fyKN4xQYPLoz/VQouJbQqfirJwKBgHN6\nJtgLekVed0SSIR8xo+sEzYt4dDiMmin4yiLVHoYv997SRhO/70ebDoIwrJ0+mgNz\nqxZHCr6hoWJygWIfL5GF+GqTfoTSzL1CccCBwLsI9fd0OyBdeehqR6HHmk5mioDw\nWbjtdm+Uy2+dqno2jT2hdqVEJo2l7+jK/IepmqwBAoGBAK122qYFOS/4AVOlR62h\nj4KxZj4KoRK8tdpuAlYJ+GP6OUPra08gKYft2OQX6+/ReQc3R5xfz1ki3b5foYbh\njjMJsJ3E/6uT0mav1YMQYrcZXTqMS3LeU+YBgOdmMqBGp7GcWb+IwI6oQC4vRux9\nTxIsifTwpu0W2fHCfS+pbobq\n-----END PRIVATE KEY-----\n",
    "client_email": "gsheets@tabacodata.iam.gserviceaccount.com",
    "client_id": "117422722033815789337",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40tabacodata.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  ''';

  static const _spreadsheetId =
      "1dsGLSI9pUdhMIEamk03mXKVS_Q6G0zaUUZgjQearSz4"; // 스프레드시트 ID
  static final _gsheets = GSheets(_credentials); // GSheets 객체 생성
  static Worksheet? _userSheet; // 워크시트 변수

  // Google Sheets API 초기화
  static Future init() async {
    // 스프레드시트를 가져옵니다.
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    // 'data'라는 이름의 워크시트를 가져옵니다.
    _userSheet = await _getWorkSheet(spreadsheet, title: 'data');
  }

  // 특정 워크시트 가져오기
  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    final worksheet = spreadsheet.worksheetByTitle(title);
    if (worksheet != null) {
      return worksheet;
    } else {
      throw Exception('워크시트를 찾을 수 없습니다.');
    }
  }

// _userSheet에서 값을 가져오는 코드
  static Future<List<Map<String, dynamic>>> fetchData() async {
    // 시트의 모든 데이터를 리스트 형태로 가져옴
    final List<List<dynamic>> rows = await _userSheet!.values.allRows();

    // 행 데이터를 맵으로 변환
    List<Map<String, dynamic>> products = [];

    for (var row in rows) {
      if (row.isNotEmpty) {
        Map<String, dynamic> product = {
          'name': row.isNotEmpty ? row[0] : 'Unknown', // A열은 'name'
          'barcode': row.length > 1 ? row[1] : 'Unknown', // B열은 'barcode'
          'price': row.length > 2 ? row[2] : 'Unknown', // C열은 'price'
        };
        products.add(product);
      }
    }

    return products;
  }
}
