import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String userid;
  final String username;
  final String phoneNumber;
  final String imageUrl;

  User({@required this.userid, this.username, this.phoneNumber, this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'username': username,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => [userid];
}
