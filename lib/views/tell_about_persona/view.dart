import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_expansion_tile.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/design/second_app_bar.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/challenges.dart';
import 'package:octify/views/tell_about_persona/components/general.dart';
import 'package:octify/views/tell_about_persona/components/my_colleague.dart';
import 'package:octify/views/tell_about_persona/components/my_partner.dart';

import '../select_persona.dart';
import 'components/my_child.dart';
import 'components/my_friend.dart';
import 'components/my_parent.dart';
import 'components/my_pet.dart';
import 'components/my_self.dart';

class TellAboutPersonaView extends StatefulWidget {
  final PersonaType personaType;

  const TellAboutPersonaView(
      {super.key,required this.personaType});

  @override
  State<TellAboutPersonaView> createState() => _TellAboutPersonaViewState();
}

class _TellAboutPersonaViewState extends State<TellAboutPersonaView> {
  List<int> selectedList = [];

  Widget get form {
    switch (widget.personaType) {
      case PersonaType.general:
        return GeneralSection(type: widget.personaType);
      case PersonaType.child:
        return MyChildSection(type: widget.personaType);
      case PersonaType.partner:
        return MyPartnerSection(type: widget.personaType);
      case PersonaType.parent:
        return MyParentSection(
             type: widget.personaType);
      case PersonaType.pet:
        return MyPetSection(
             type: widget.personaType);
      case PersonaType.friend:
        return MyFriendSection(
             type: widget.personaType);
      case PersonaType.myself:
        return MySelfSection(
             type: widget.personaType);
      case PersonaType.colleague:
        return MyColleagueSection(
             type: widget.personaType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Tell us more about Persona"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  const TextSpan(
                      text:
                          "Please provide the following details about the Persona to help us "),
                  TextSpan(
                    text: "understand your needs better.",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            form,
          ],
        ),
      ),
    );
  }
}

class PersonaModelData {
  late final String name;
  late final PersonaType type;
  late final String? interestsHobbies,
      sharedInterests,
      gender,
      challenges,
      personalityType,
      healthConditions,
      communicationStyle,
      workRelationship,
      educationLevel,
      petType,
      lifeStage,
      loveLanguage,
      anniversaryDate,
      breed,
      goals,
      favoriteActivities;
  late final String? age;

  PersonaModelData.fromJson(Map<String, dynamic> json) {
    age = json['age'] ?? 0;
    communicationStyle = json['communicationStyle'] ?? "";
    gender = json['gender'] ?? "";
    interestsHobbies = json['interestsHobbies'] ?? "";
    name = json['name'] ?? "";
    personalityType = json['personalityType'] ?? "";
    workRelationship = json['workRelationship'] ?? "";
    sharedInterests = json['sharedInterests'] ?? "";
    petType = json['petType'] ?? "";
    challenges = json['challenges'] ?? "";
    healthConditions = json['healthConditions'] ?? "";
    educationLevel = json['educationLevel'] ?? "";
    lifeStage = json['lifeStage'] ?? "";
    loveLanguage = json['loveLanguage'] ?? "";
    anniversaryDate = json['anniversaryDate'] ?? "";
    breed = json['breed'] ?? "";
    goals = json['goals'] ?? "";
    favoriteActivities = json['favoriteActivities'] ?? "";
    String myType = json["personaType"]??"";
    type = PersonaType.values.where((element) => element.name==myType,).first;
    print(type);
  }

  PersonaModelData({
    required this.name,
    this.gender,
    this.interestsHobbies,
    this.sharedInterests,
    this.petType,
    this.challenges,
    this.personalityType,
    this.healthConditions,
    this.communicationStyle,
    this.workRelationship,
    this.educationLevel,
    this.lifeStage,
    this.loveLanguage,
    this.anniversaryDate,
    this.breed,
    this.goals,
    required this.type,
    this.favoriteActivities,
    required this.age,
  });

  Map<String, dynamic> toMap() {

    final data = {
      "name":name,
      "gender":gender,
      "interestsHobbies":interestsHobbies,
      "sharedInterests":sharedInterests,
      "petType":petType,
      "challenges":challenges,
      "personalityType":personalityType,
      "healthConditions":healthConditions,
      "communicationStyle":communicationStyle,
      "workRelationship":workRelationship,
      "educationLevel":educationLevel,
      "lifeStage":lifeStage,
      "loveLanguage":loveLanguage,
      "anniversaryDate":anniversaryDate,
      "breed":breed,
      "goals":goals,
      "favoriteActivities":favoriteActivities,
      "age":age,
      "personaType":type.name,
    };
    data.removeWhere((key, value) => value==null,);
    return data;
  }
}
