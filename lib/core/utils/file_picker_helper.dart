import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<String?> pickDocument() async {
    final FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpg", "pdf"],
    );

    return result?.files.single.path;
  }
}
