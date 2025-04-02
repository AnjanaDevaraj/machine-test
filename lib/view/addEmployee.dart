import 'package:flutter/material.dart';
import '../customWidgets/customHeaderBar.dart';
import '../customWidgets/customText.dart';
import '../customWidgets/customTextField.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // var provider = Provider.of<HomeProvider>(context, listen: false);
      // provider.clearAttendanceScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
            color: Colors.white,
            child: Column(
              children: [
                const CustomHeader(
                  text: 'Attendance',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.4, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const CustomText(
                                                text: 'Month:',
                                                weight: FontWeight.bold,
                                              ),

                                            ],
                                          )),
                                          const SizedBox(
                                            width: 8,
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

    );
  }
}

