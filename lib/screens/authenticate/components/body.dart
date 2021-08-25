import 'package:bar_pub/screens/Guest/home_Guest.dart';
import 'package:bar_pub/screens/authenticate/components/background.dart';
import 'package:bar_pub/screens/authenticate/components/or_divider.dart';
import 'package:bar_pub/screens/authenticate/register.dart';
import 'package:bar_pub/screens/home/home.dart';
import 'package:bar_pub/services/auth.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/widgets/already_have_an_account_check.dart';
import 'package:bar_pub/widgets/constants.dart';
import 'package:bar_pub/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  GlobalPreferences gPref = GlobalPreferences();
  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            TextFieldContainer(
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'Insert Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.person, color: kPrimaryColor),
                    hintText: "Your Email",
                    border: InputBorder.none),
                cursorColor: Colors.purple[300],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldContainer(
                    child: TextFormField(
                      validator: (val) => val.length < 6
                          ? 'Inserisci password con più di 6 caratteri'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon:
                              Icon(Icons.visibility, color: kPrimaryColor),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          backgroundColor: kPrimaryColor,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var checkAuth = await _auth.signInWithEmailPassword(
                                email, password);
                            if (checkAuth == null) {
                              setState(() => error =
                                  "Email non registrata oppure non corretta");
                            } else {
                              gPref.addStringToSF(email);
                              //setState(() async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHome()));
                              //});
                            }
                          }
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Register();
                }));
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Enter as ",
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyHomeGuest()));
                  },
                  child: Text(
                    "Guest",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.35,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {},
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Register();
              }));
            },
          ),
          OrDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Enter as ",
                style: TextStyle(color: kPrimaryColor),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Guest",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
*/