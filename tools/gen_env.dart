// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  _createJsonFile('dev');
  _createJsonFile('stg');
  _createJsonFile('prod');
}

void _createJsonFile(String filename) {
  final File file = File('config/$filename.json');
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync('''{
  "FLAVOR": "$filename"
}
''');
    print('File $filename.json created');
  } else {
    print('!!! File $filename.json already exists !!!');
  }
}
