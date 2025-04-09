import 'package:flutter/material.dart';
import 'ProfileWithBadgeWidget.dart';

class DeliveryAddressWidget extends StatelessWidget {
  final String address;

  const DeliveryAddressWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu_sharp,
            color: Colors.black,
            size: 32,
          ),
          Spacer(),
          Column(
            children: [
              SizedBox(width: 4),
              Row(
                children: [
                  Text(
                    'Deliver to',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                      size: 24,
                    ),
                  )
                ],
              ),
              Text(
                address,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          Spacer(),
          ProfileWithBadge(
            image: AssetImage('assets/images/profile.png'),
            badgeCount: 3,
          )
        ],
      ),
    );
  }
}
