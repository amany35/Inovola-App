class Course {
  final int id;
  final String interest;
  final String title;
  final String date;
  final String address;
  final String trainerImg;
  final String trainerName;
  final String trainerInfo;
  final String occasionDetail;
  final List reservTypes;
  final List img;

  Course(
      {this.id,
      this.interest,
      this.title,
      this.date,
      this.address,
      this.trainerImg,
      this.trainerName,
      this.trainerInfo,
      this.occasionDetail,
      this.reservTypes,
      this.img});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      interest: json['interest'],
      title: json['title'],
      date: json['date'],
      address: json['address'],
      trainerImg: json['trainerImg'],
      trainerName: json['trainerName'],
      trainerInfo: json['trainerInfo'],
      occasionDetail: json['occasionDetail'],
      reservTypes: json['reservTypes'],
      img: json['img'],
    );
  }
}
