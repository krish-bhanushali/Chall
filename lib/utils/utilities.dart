class MyUtils {
  static String getUsername(String email){

    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String name){

    print(name);
    List<String> nameSplit = name.split(" ");
    print(nameSplit);
    String firstNameInitial = nameSplit[0][0];
    String LastNameInitial = nameSplit[1][0];

    return firstNameInitial+LastNameInitial;
  }
}