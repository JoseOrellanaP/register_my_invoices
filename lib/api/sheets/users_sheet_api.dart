import 'package:gsheets/gsheets.dart';
import 'package:register_my_invoices/model/user.dart';

class UserSheetsApi{
  
  static const _credential = r'''
{
  "type": "service_account",
  "project_id": "register-invoice",
  "private_key_id": "a7ab394610dabe0dc8b2202f33cecd439dabfdc0",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCxo+K/nLrzXL+y\nD+0vkdh4qSPvOj0HCjhMkL+jts4T8I+jxeth8jawjH5FnUs4X4AJxxy1V8Uqz+zc\ndMgK/PdjGOwvC1AUeYMY2UQA+ksQE0YIHwNy8rt9TvuBW2oW8JZTkfOXLITaYHIr\npYyjrh4hCVlmQYQ+cSu2Tt5OTucyH0gdgxWqVt2zWLhfXGDxU11Q0XTsnSMuZHWU\nNxtxTbbV+7bNpwQVJ7HJu+NeIFTOSHCcQop2lEIpuqrg0A91q5LRPwKrvE5Di0bA\nGiYbFu3H40t9y9yl89HxInm53T5JI1UnXcqoycXXQoWIElfZZs9K7SHDwsuQ6XG4\nXFq2CSYXAgMBAAECggEAAepaejvJEvFfv8kcLZ8iTmrEexfjAJMY+E+3QUn/VDJh\nL3WQNtt9wM7traJ8j9G3zQ3bPrlWOZf0XeGEfASDm7XxFgYb3vH7JTwdLPAwpFkQ\n2urlW/VHau/RwRtTPDFr7YrCraaf6BrndZZbZd3CxWhsZlsz1IMz4stcP6E/gkgq\nIKqo/qXITDF1Ov+7OG9q/bIf4LrkMmjyhu0ECgdvL8/EMZ7PQDFVs1sxkJCWfHxj\n0mdlFUvB53kKW2WpQ0ozgjtNbrvHs29fC7XX9Ey8XMtxG6GpvX0aJAgD/JJBrOxB\nP4+iYqHkxvaElrFQPjN4f/sTqiFrAZEiqfhqEce4gQKBgQDi2AhbbVv5zLoBmnMx\nY21WEUu8cSzXfMKZ+NDNEFlfEbGmFBqg3BFHli3zVGCZqosbc/EyBT4AcZfdXOl8\nf2xGx6HlwoaG9VMLadoVBjHzylKCz9bv/GGclaDioXF9QQl0rNqIYPm6b2x065i7\npiGt9FoalBbzPEs9rrDKfRCBPwKBgQDIeOCGkICV5vM1ozvxquPSMhOkIJgM6bse\nTz+Oe7YTc4V5hUKnNQLkJ6NXAjT3IMP7wMCgKYutthppXy9FVZiblDASg1Y5lROW\n9c6txPJC2tvtuYLrCaDVTyHyLGDL9JBlYBwnYFh4Qe7cfVsVIYCHdDEajXfAEHYH\ncOMYmtvNKQKBgBWz0Wjd15TYj1sj6a1p88XuNa67rSyYlQ2iDmfwDnzX9oULG1kU\ndNrCdXb4NZ2+AT0JJKRCeCIWvA7Dmtr8XeGPq9+Ncs1qnx1SbTjhtNm8G5TESa4A\nGV6fuhq0k2UGWd89wlKV5I5/poKxH5WkWUiJPi2YyXFP7WrjUaqtuGyFAoGAPdCH\n6vZDr/U2qSNcKHh5Jycpx0IFoHWxrPbishyTWAwW7BGbK9O8wH04cGvNySXhSI92\n1ev5lebA3hzrhoWOOOrIp+y3eanuEG5a/FnuGY9CoVrCc5bUcPGllfb5IeqXW6r3\nA21B2lL6RCKjIzDhYOMDARz9/8sTmdfFLqERhYECgYEAmvkpL/lwuwCb9sx5JKCB\nq9buWWvIQReo+C8TPLIpFBW8Yi8KnkkhAZE/rnlJYD2D8kRh0o9kWPu3FKsSviT6\nbpalZ7mg+dT04igU/+JBIaWYcBncp99CLgq6MBTQG+ImpOlkoXo/tz+Q7QaFHOzQ\nmFIz5EtLh8IY4SCRR5R7NZg=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets2@register-invoice.iam.gserviceaccount.com",
  "client_id": "105994832963680802739",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets2%40register-invoice.iam.gserviceaccount.com"
}


  ''';

  static final _spreadSheetId = '1Q1kDiPRuQytcUwj3ZopohOG8tz2GbATmDJ3Q1uuNMRc';

  static final _gsheet = GSheets(_credential);
  static Worksheet _userSheet;

  static Future init() async{
    
    try{
      final spreadsheet = await _gsheet.spreadsheet(_spreadSheetId);
    _userSheet = await _getWorkSheet(spreadsheet, title: 'invoices');

    final firstRow = UserFields.getFields();
    _userSheet.values.insertRow(1, firstRow);
    } catch(e){
      print("Init Error: $e");
    }
    

  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet,{
    String title,
  }) async{
    try{
      return await spreadsheet.addWorksheet(title);
    }catch (e){
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async{
    
    if(_userSheet == null) return;

    _userSheet.values.map.appendRows(rowList);
    
  }

  static Future<int> getRowCount() async{
    if(_userSheet == null) return 0;

    final lastRow = await _userSheet.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;

  }

  static Future<User> getById(int id) async{
    if(_userSheet == null) return null;

    final json = await _userSheet.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null: User.fromJson(json);
    
  }


}