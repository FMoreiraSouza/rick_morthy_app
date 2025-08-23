class InfoRequestDTO {
  final int page;
  final int? size;

  InfoRequestDTO({required this.page, this.size});

  Map<String, dynamic> toMap() {
    return {'page': page, if (size != null) 'size': size};
  }
}
