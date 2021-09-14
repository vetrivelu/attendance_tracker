import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracer/Pages/profile/profile.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/models.dart/employee.dart';
import 'package:tracer/services/auth.dart';

import '../../db.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  bool isEdit = true;
  TextEditingController idController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController icNumController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Employee data;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF111343),
        body: Stack(
          children: [
            ListView(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => AuthenticationService().logout(),
                      child:
                          Text('Logout', style: TextStyle(color: Colors.white)),
                    ),
                    Spacer(),
                    Text(
                      'Add Employee',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/logo.png',
                      height: 60,
                      width: 60,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Center(
                //   child: Stack(
                //     children: [
                //       // CircleAvatar(
                //       //   backgroundImage: NetworkImage(
                //       //       'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                //       //   radius: 45,
                //       // ),
                //       Positioned(
                //         bottom: 0,
                //         right: 0,
                //         child: CircleAvatar(
                //           backgroundColor: Colors.red,
                //           child: IconButton(
                //             icon: Icon(
                //               Icons.camera_alt_outlined,
                //               color: Colors.white,
                //             ),
                //             onPressed: () {},
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36.0),
                      topRight: Radius.circular(36.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // ListTile(
                          //   // title: Text('Your Profile'),
                          //   trailing: TextButton.icon(
                          //       onPressed: () =>
                          //           setState(() => isEdit = !isEdit),
                          //       icon: Icon(
                          //         isEdit ? Icons.save : Icons.edit,
                          //         color: Color(0xFF111443),
                          //       ),
                          //       label: Text(
                          //         isEdit ? 'Save' : 'Edit Profile',
                          //         style: TextStyle(color: Color(0xFF111443)),
                          //       )),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          ResultWidget(
                            isedit: isEdit,
                            controller: nameController,
                            heading: 'Name',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                              isedit: isEdit,
                              controller: idController,
                              heading: 'ID',
                              text: ''),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: groupController,
                            heading: 'Group ID',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: icNumController,
                            heading: 'IC No',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: ageController,
                            heading: 'Age',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: departmentController,
                            heading: 'Department',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: phoneNumController,
                            heading: 'Phone No',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: address1Controller,
                            heading: 'Address Lane 1',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: address2Controller,
                            heading: 'Address Lane 2',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: stateController,
                            heading: 'State',
                            text: '',
                          ),
                          Divider(),
                          ResultWidget(
                            isedit: isEdit,
                            controller: postCodeController,
                            heading: 'Postal/Zip Code',
                            text: '',
                          ),
                          Divider(),
                          SizedBox(
                            height: 15.0,
                          ),
                          ElevatedButton(
                              onPressed: () => createProfile(
                                    Employee(
                                        age: int.parse(ageController.text),
                                        employeeId:
                                            int.parse(idController.text),
                                        name: nameController.text,
                                        isAdmin: false,
                                        deviceId: 'deviceId',
                                        groupId:
                                            int.parse(groupController.text),
                                        iCnumber: icNumController.text,
                                        pinCode: int.parse(
                                          postCodeController.text,
                                        ),
                                        uid: ''),
                                  ),
                              child: Text('Submit'))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
