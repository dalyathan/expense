import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../models/transactions.dart';

class LastTransactionTabContainer extends StatelessWidget {
  final double height;
  final Transaction transaction;
  const LastTransactionTabContainer(
      {Key? key, required this.height, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconDiameter = height * 0.75;
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(iconDiameter * 0.5),
            child: SizedBox(
                width: iconDiameter,
                height: iconDiameter,
                child: CachedNetworkImage(imageUrl: transaction.imageUrl)),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(
                flex: 3,
              ),
              SizedBox(
                  width: size.width * 0.35,
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        transaction.name,
                        style: GoogleFonts.sora(fontWeight: FontWeight.bold),
                      ))),
              const Spacer(
                flex: 4,
              ),
              SizedBox(
                  width: size.width * 0.4,
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "due ${transaction.dateTime}",
                        style: GoogleFonts.sora(color: Colors.grey),
                      ))),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
          const Spacer(
            flex: 5,
          ),
          SizedBox(
            height: height * 0.4,
            child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text('\$${transaction.amount.toStringAsFixed(2)}',
                    style: GoogleFonts.sora(fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}
