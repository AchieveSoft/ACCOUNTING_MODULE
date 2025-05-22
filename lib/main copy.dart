import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _buildMenuItem(IconData icon, String text) => SizedBox(
    width: 170,
    height: 90,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color(0XFF1CBD9D)),
            SizedBox(width: 8),
            Text(text, style: TextStyle(color: Color(0XFF818181))),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(width: double.infinity, color: Colors.white),
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Image.asset(
                'assets/images/default_nav_bg.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 16,
              left: 34,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 72,
                      child: Image.asset(
                        'assets/images/temp_logo.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 79,
                          child: CircleAvatar(
                            radius: 62,
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIKGoqaUJEJixGDrPNtmpFy1iBFyc0xPZirQ&s',
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Naruto',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Business Owner',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 32,
              child: Container(
                width: MediaQuery.of(context).size.width - 64,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMenuItem(Icons.dashboard, 'Dashboard'),
                    _buildMenuItem(Icons.attach_money, 'Revenue'),
                    _buildMenuItem(Icons.money_off, 'Expenses'),
                    _buildMenuItem(Icons.contacts, 'Contacts'),
                    _buildMenuItem(Icons.inventory, 'Products'),
                    _buildMenuItem(Icons.account_balance, 'Finances'),
                    _buildMenuItem(Icons.account_box, 'Accounts'),
                    _buildMenuItem(Icons.folder, 'File Vault'),
                    _buildMenuItem(Icons.settings, 'Settings'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
