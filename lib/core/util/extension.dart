import '../core.dart';

toGenderString(Gender gender) {
  switch (gender) {
    case Gender.male:
      return "male";
    case Gender.female:
      return "female";
    case Gender.other:
      return "other";
    case Gender.noanswer:
      return "no answer";
    default:
      print("Invalid gender");
  }
}

toQuestationString(Questation questation) {
  switch (questation) {
    case Questation.stronglyAgree:
      return "Strongly agree";
    case Questation.somewhatAgree:
      return "Somewhat agree";
    case Questation.neither:
      return "Neither agree nor disagree";
    case Questation.somewhatDisagree:
      return "Somewhat disagree";
    case Questation.stronglyDisagree:
      return "Strongly disagree";
    default:
      print("Invalid questation");
  }
}
