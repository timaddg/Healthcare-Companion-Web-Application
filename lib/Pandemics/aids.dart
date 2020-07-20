import 'package:flutter/material.dart';
import 'aidsvisual.dart';

class AidsPage extends StatefulWidget {
  @override
  _AidsPageState createState() => _AidsPageState();
}

class _AidsPageState extends State<AidsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFB22222),
          leading: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text('Aids'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 18, 8, 8),
                  child: Text(
                    'HIV AIDS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Image.asset("images/aids.png"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    '     Human immunodeficiency virus infection and acquired immune deficiency syndrome (HIV/AIDS) is a spectrum of conditions caused by infection with the human immunodeficiency virus (HIV). Following initial infection a person may not notice any symptoms, or may experience a brief period of influenza-like illness. Typically, this is followed by a prolonged period with no symptoms. If the infection progresses, it interferes more with the immune system, increasing the risk of developing common infections such as tuberculosis, as well as other opportunistic infections, and tumors which are otherwise rare in people who have normal immune function.   These late symptoms of infection are referred to as acquired immunodeficiency syndrome (AIDS). This stage is often also associated with unintended weight loss.',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AidsVisual(),
                      ),
                    );
                  });
                },
                child: Icon(
                  Icons.graphic_eq,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    ' HIV is spread primarily by unprotected sexual contact, contaminated blood transfusions, hypodermic needles, and from mother to child during pregnancy, delivery, or breastfeeding. Some bodily fluids, such as saliva, sweat and tears, do not transmit the virus. HIV is a member of the group of viruses known as retroviruses.',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Image.asset("images/hivworld.png"),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    'Famous Cases',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Image.asset("images/magic.jpg"),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    '     Earvin Johnson (Magic), a retired NBA player, was diagnosed with this disease in 1991 which played a role in his retirement. Since then, Magic has been an advocate for HIV/AIDS prevention and safe sex, as well as an entrepreneur, philanthropist, broadcaster and motivational speaker. His public announcement of his HIV-positive status in 1991 helped dispel the stereotype, still widely held at the time, that HIV was a "gay disease" that heterosexuals need not worry about; his bravery in making this announcement was widely commended.',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    '     Charlie Sheen is a prominent American actor. On November 17, 2015, Sheen publicly revealed that he is HIV positive, having been diagnosed about four years earlier.',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Image.asset("images/charlie.jpg"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
