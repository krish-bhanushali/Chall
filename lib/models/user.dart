class UserClass {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;

  UserClass({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
});

  Map toMap(UserClass userClass){
    var data = Map<String, dynamic>();
    data['uid'] = userClass.uid;
    data['name'] = userClass.name;
    data['username'] = userClass.username;
    data['status'] = userClass.status;
    data['state'] = userClass.state;
    data['profilePhoto'] = userClass.profilePhoto;
    return data;
  }

  UserClass.fromMap(Map<String,dynamic> mapData){
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.status = mapData['status'];
    this.state = mapData['state'];
    this.profilePhoto = mapData['profilePhoto'];
  }
}