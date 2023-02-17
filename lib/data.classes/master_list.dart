class FileMasterList {
  final String filepath;
  final String filename;

  const FileMasterList({
    required this.filepath,
    required this.filename,
  });

  Map<String, dynamic> toMap() {
    return {'filepath': filepath.toString(), 'filename': filename};
  }

  static FileMasterList toDataModel(Map<String, dynamic> data) =>
      FileMasterList(
        filename: data['filename'],
        filepath: data['filepath'],
      );
}
