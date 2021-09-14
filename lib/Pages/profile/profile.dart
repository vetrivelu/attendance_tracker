import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracer/constants/controller.dart';
import 'package:tracer/db.dart';
import 'package:get/get.dart';
import 'package:tracer/models.dart/employee.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    Employee data;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //   appBar: AppBar(
        //     centerTitle: true,
        //     title: Row(
        //       children: [
        //         Image.asset(
        //           'assets/logo.png',
        //           height: 50,
        //           width: 50,
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Text('SAFE@CAMPUS'),
        //       ],
        //     ),
        //     actions: [
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(Icons.notifications),
        //       ),
        //     ],
        //   ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: getPersonProfile(authController.auth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                DocumentSnapshot<Map<String, dynamic>> document =
                    snapshot.data!;
                data = Employee.fromJson(document.data()!);

                profileController.idController.text;

                profileController.groupController.text =
                    data.groupId.toString();

                profileController.nameController.text = data.name;

                profileController.icNumController.text =
                    data.iCnumber.toString();

                profileController.phoneNumController.text =
                    data.phone.toString();

                profileController.address1Controller.text =
                    data.address1.toString();

                profileController.address2Controller.text =
                    data.address2.toString();

                profileController.ageController.text = data.age.toString();

                profileController.stateController.text = data.state.toString();

                profileController.postCodeController.text =
                    data.pinCode.toString();
                profileController.idController.text =
                    data.employeeId.toString();
                return Stack(
                  children: [
                    ListView(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Color(0xffcd2122),
                                size: 27,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Profile',
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
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                                radius: 45,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    // title: Text('Your Profile'),
                                    trailing: TextButton.icon(
                                        onPressed: () async {
                                          if (isEdit) {
                                            // updateProfile();
                                            await users
                                                .doc(employeeController
                                                    .employee.uid)
                                                .update({
                                              'Name': profileController
                                                  .nameController.text,
                                              'EmployeeID': int.parse(
                                                  profileController
                                                      .idController.text),
                                              'groupID': int.parse(
                                                profileController
                                                    .groupController.text,
                                              ),
                                              'iCnumber': profileController
                                                  .icNumController.text,
                                              'Age': int.parse(
                                                profileController
                                                    .ageController.text,
                                              ),
                                              'phone': profileController
                                                  .phoneNumController.text,
                                              'address1': profileController
                                                  .address1Controller.text,
                                              'address2': profileController
                                                  .address2Controller.text,
                                              'State': profileController
                                                  .stateController.text,
                                              'pinCode': int.parse(
                                                profileController
                                                    .postCodeController.text,
                                              ),
                                            });
                                          }
                                          setState(() => isEdit = !isEdit);
                                        },
                                        icon: Icon(
                                          isEdit ? Icons.save : Icons.edit,
                                          color: Color(0xFF111443),
                                        ),
                                        label: Text(
                                          isEdit ? 'Save' : 'Edit Profile',
                                          style: TextStyle(
                                              color: Color(0xFF111443)),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.nameController,
                                    heading: 'Name',
                                    text: data.name,
                                  ),
                                  Divider(),
                                  ResultWidget(
                                      isedit: isEdit,
                                      controller:
                                          profileController.idController,
                                      heading: 'ID',
                                      text: data.deviceId),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.groupController,
                                    heading: 'Group ID',
                                    text: data.groupId.toString(),
                                  ),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.icNumController,
                                    heading: 'IC No',
                                    text: data.iCnumber,
                                  ),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller: profileController.ageController,
                                    heading: 'Age',
                                    text: data.age.toString(),
                                  ),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.departmentController,
                                    heading: 'Department',
                                    text: 'Department',
                                  ),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.phoneNumController,
                                    heading: 'Phone No',
                                    text: data.phone!,
                                  ),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.address1Controller,
                                    heading: 'Address Lane 1',
                                    text: data.address1!,
                                  ),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.address2Controller,
                                    heading: 'Address Lane 2',
                                    text: data.address2!,
                                  ),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.stateController,
                                    heading: 'State',
                                    text: data.state!,
                                  ),
                                  Divider(),
                                  ResultWidget(
                                    isedit: isEdit,
                                    controller:
                                        profileController.postCodeController,
                                    heading: 'Postal/Zip Code',
                                    text: data.pinCode.toString(),
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
            } else {
              return Center(
                  child: CircularProgressIndicator(color: Colors.white));
            }
          },
        ),
      ),
    );
  }
}

class Profile_field extends StatelessWidget {
  final TextEditingController controller;
  final String textFieldName;
  final String headingName;
  final Icon icon;
  const Profile_field(
      {Key? key,
      required this.textFieldName,
      required this.icon,
      required this.headingName,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            headingName,
            style: TextStyle(
              color: Color(0xFF111443),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),

          height: 36,
          // width: 40,
          child: TextField(
            controller: controller,
            maxLines: 1,
            style: TextStyle(fontSize: 17),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: icon,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              contentPadding: EdgeInsets.zero,
              hintText: textFieldName,
            ),
          ),
        ),
      ],
    );
  }
}

class ResultWidget extends StatelessWidget {
  final String heading;
  final bool isedit;
  final TextEditingController controller;
  final String text;
  const ResultWidget({
    Key? key,
    required this.text,
    required this.isedit,
    required this.controller,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          readOnly: !isedit,
          controller: controller,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Color(0xFF111443),
          ),
          decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              labelText: heading,
              floatingLabelBehavior: FloatingLabelBehavior.auto),
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(
    //         heading,
    //         style: TextStyle(
    //           color: Color(0xFF111443),
    //           fontSize: 16,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       Text(
    //         text,
    //         textAlign: TextAlign.start,
    //         style: TextStyle(
    //           color: Color(0xFF111443),
    //           fontSize: 16,
    //           fontWeight: FontWeight.normal,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
