import 'package:flutter/material.dart';

class DonationView extends StatefulWidget {
  const DonationView({Key? key}) : super(key: key);

  @override
  State<DonationView> createState() => _DonationViewState();
}

class _DonationViewState extends State<DonationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black87)
        ),
        title: Text('Scan to Donation', style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold
        )),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromRGBO(238, 238, 238, 1.0),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                    ),
                    child: Image.asset("assets/images/esewa.png", height: 30.0),
                  ),
                ),

                const SizedBox(width: 10.0),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(207 , 32, 39, 1), width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white
                    ),
                    child: Image.asset("assets/images/fonepay.png", height: 30.0),
                  ),
                ),

                const SizedBox(width: 10.0),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white
                    ),
                    child: Image.asset("assets/images/khalti.png", height: 30.0),
                  ),
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Image.asset("assets/images/qr_image.png"),
            ),
          ],
        ),
      ),
    );
  }
}
