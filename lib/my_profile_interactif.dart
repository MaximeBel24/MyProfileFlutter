import 'package:flutter/material.dart';

class MyProfileInteractif extends StatefulWidget {
  @override
  MyProfileInteractifState createState() => MyProfileInteractifState();
}

class MyProfileInteractifState extends State<MyProfileInteractif>{

  Color mainColor = Colors.green;
  Color secondColor = Colors.green.shade200;
  String prenom = "";
  String nom = "";
  String age = "";
  String secret = "";
  double taille = 0;
  bool genre = true;
  Map<String, bool> hobbies = {
    "Elden Ring" : false,
    "The Witcher" : false,
    "Zelda" : false,
    "One Piece" : false,
    "Les randonnées" : false,
    "APERO !!!!!" : false
  };
  int groupValue = 1;
  List<String> langs = ["Dart", "PHP", "Java", "C++", "JavaScript", "Python"];
  bool elevatedButtonPressed = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mon profil",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(1),
                child: myProfileCard(),
              ),
              myProfileDivider(),
              sectionTitle("Modifier les infos"),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Entrez votre prénom",
                      ),
                      onChanged: (newString) {
                        setState(() {
                          prenom = newString;
                        });
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Entrez votre nom de famile",
                      ),
                      onChanged: (newString) {
                        setState(() {
                          nom = newString;
                        });
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Entrez votre âge",
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (newString) {
                        setState(() {
                          age = newString;
                        });
                      },
                    ),
                    secretText(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((genre) ? "Genre: Féminin" : "Genre: Masculin"),
                        Switch(
                            value: genre,
                            activeColor: mainColor,
                            inactiveTrackColor: Colors.white,
                            inactiveThumbColor: mainColor,
                            onChanged: ((bool) {
                              setState(() {
                                genre = bool;
                              });
                            })
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Taille: ${taille.toInt()}cm"),
                        Slider(
                            activeColor: mainColor,
                            inactiveColor: secondColor,
                            value: taille,
                            min: 0,
                            max: 250,
                            onChanged: ((newValue) {
                              setState(() {
                                taille = newValue;
                              });
                            })
                        )
                      ],
                    )

                  ],
                ),
              ),
              myProfileDivider(),
              sectionTitle("Mes Hobbies"),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: hobbiesList(),
              ),
              myProfileDivider(),
              sectionTitle("Langage préféré"),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: languageRadios(),
              )

            ],
          ),
        ),
      ),
    );
  }



  ElevatedButton showSecret() {
    return ElevatedButton(
        onPressed: () {
          updateSecret();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3)
            )
        ),
        child: const Text(
          "Montrer Secret",
          style: TextStyle(
              color: Colors.white
          ),
        )
    );
  }

  updateSecret() {
    setState(()=>elevatedButtonPressed = !elevatedButtonPressed);
  }

  updateSecretText() {
    return(elevatedButtonPressed) ? "" : secret;
  }

  TextField secretText() {
    return TextField(
      obscureText: true,
      decoration: const InputDecoration(
          hintText: "Quelle est votre secret ?"
      ),
      onChanged: (newString) {
        setState(() {
          secret = newString;
        });
      },
    );
  }

  Divider myProfileDivider(){
    return Divider(
      thickness: 2,
      color: mainColor,
    );
  }

  Card myProfileCard() {
    return Card(
      color: secondColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 79
        ),
        child: Column(
          children: [
            Text("$prenom $nom"),
            Text("Age: $age ans"),
            Text("Taille: ${taille.toInt()}cm"),
            Text((genre) ? "Genre: Féminin" : "Genre: Masculin"),
            Text("Hobbies: ${getSelectedHobbies()}"),
            Text("Langage de programmation favori: ${langs[groupValue]}"),
            showSecret(),
            Text(updateSecretText())
          ],
        ),
      ),
    );
  }
  
  Text sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
          color: mainColor,
          fontSize: 25,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Column hobbiesList() {
    List<Widget> items = [];
    hobbies.forEach((hobbie, done) {
      Widget row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(hobbie),
          Checkbox(
              value: done,
              onChanged: ((newValue){
                setState(() {
                  hobbies[hobbie] = newValue ?? false;
                });
              }),
              activeColor: mainColor,
            checkColor: secondColor,
              ),
        ],
      );
      items.add(row);
    });
    return Column(children: items);
  }

  String getSelectedHobbies() {
    List<String> selected = [];
    hobbies.forEach((hobbie, done) {
      if (done) {
        selected.add(hobbie);
      }
    });
    return selected.join(', ');
  }

  Row languageRadios() {
    List<Widget> languageRadios = [];
    for (var i = 0; i < langs.length; i++){
      Column r = Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(langs[i]),
          Radio(
      value: i,
      groupValue: groupValue,
      activeColor: mainColor,
      onChanged: ((newValue){
        setState(() {
          groupValue = newValue as int;
        });
      }))
        ],
      );
      languageRadios.add(r);
    }
    return Row(
      children: languageRadios,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }



}
