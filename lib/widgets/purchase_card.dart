import 'package:flutter/material.dart';

class PurchaseCard extends StatelessWidget {
  final bool isPopular;
  final String timePeriod;
  final String currentPrice;
  final String originalPrice;
  final String discountPr;
  final bool fromBouquets;
  const PurchaseCard({
    Key? key,
    required this.isPopular,
    required this.timePeriod,
    required this.currentPrice,
    required this.originalPrice,
    required this.discountPr,
    required this.fromBouquets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Row(
              children: [
                fromBouquets ? Row(
                  children: [
                    Text(timePeriod),
                    SizedBox(width: 5,),
                    Transform.rotate(
                          angle: 0.2,
                          child: Image.asset(
                            'assets/bokay.png',
                            color: Colors.pink,
                            width: 15,
                            height: 20,
                          ),
                        ),
                  ],
                ) : Text(
                  timePeriod,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Color.fromRGBO(255, 85, 115, 1),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                isPopular
                    ? Container(
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Color.fromRGBO(255, 85, 115, 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text(
                            'POPULAR',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontSize: 12),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            subtitle: Row(
              children: [
                Text(
                  "₹$currentPrice",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "₹$originalPrice",
                  style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 3),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "-$discountPr%",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 85, 115, 1), fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
