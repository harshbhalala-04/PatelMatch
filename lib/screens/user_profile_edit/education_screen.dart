import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

enum Education {
  PursuingBachelors,
  CompletedBachelors,
  PursuingMasters,
  CompletedMasters,
  Other,
}

class EducationScreen extends StatefulWidget {
  final String response;
  EducationScreen({required this.response});
  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  Education? _reply;
  String? educationAns = '';
  List<DropdownMenuItem<String>> educations = [
    DropdownMenuItem(
      value: "BBA- Bachelor of Business Administration",
      child: Text("BBA- Bachelor of Business Administration"),
    ),
    DropdownMenuItem(
      value: "BMS- Bachelor of Management Science",
      child: Text("BMS- Bachelor of Management Science"),
    ),
    DropdownMenuItem(
      value: "BFA- Bachelor of Fine Arts",
      child: Text("BFA- Bachelor of Fine Arts"),
    ),
    DropdownMenuItem(
      value: "BEM- Bachelor of Event Management",
      child: Text("BEM- Bachelor of Event Management"),
    ),
    DropdownMenuItem(
      value: "Integrated Law Course- BA + LL.B",
      child: Text("Integrated Law Course- BA + LL.B"),
    ),
    DropdownMenuItem(
      value: "BJMC- Bachelor of Journalism and Mass Communication",
      child: Text("BJMC- Bachelor of Journalism and Mass Communication"),
    ),
    DropdownMenuItem(
      value: "BFD- Bachelor of Fashion Designing",
      child: Text("BFD- Bachelor of Fashion Designing"),
    ),
    DropdownMenuItem(
      value: "BSW- Bachelor of Social Work",
      child: Text("BSW- Bachelor of Social Work"),
    ),
    DropdownMenuItem(
      value: "BBS- Bachelor of Business Studies",
      child: Text("BBS- Bachelor of Business Studies"),
    ),
    DropdownMenuItem(
      value: "BTTM- Bachelor of Travel and Tourism Management",
      child: Text("BTTM- Bachelor of Travel and Tourism Management"),
    ),
    DropdownMenuItem(
      value: "Aviation Courses",
      child: Text("Aviation Courses"),
    ),
    DropdownMenuItem(
      value: "B.Sc- Interior Design",
      child: Text("B.Sc- Interior Design"),
    ),
    DropdownMenuItem(
      value: "B.Sc.- Hospitality and Hotel Administration",
      child: Text("B.Sc.- Hospitality and Hotel Administration"),
    ),
    DropdownMenuItem(
      value: "Bachelor of Design (B. Design)",
      child: Text("Bachelor of Design (B. Design)"),
    ),
    DropdownMenuItem(
      value: "Bachelor of Performing Arts",
      child: Text("Bachelor of Performing Arts"),
    ),
    DropdownMenuItem(
      value: "BA in History",
      child: Text("BA in History"),
    ),
    DropdownMenuItem(
      value: "BE/B.Tech- Bachelor of Technology",
      child: Text("BE/B.Tech- Bachelor of Technology"),
    ),
    DropdownMenuItem(
      value: "B.Arch- Bachelor of Architecture",
      child: Text("B.Arch- Bachelor of Architecture"),
    ),
    DropdownMenuItem(
      value: "BCA- Bachelor of Computer Applications",
      child: Text("BCA- Bachelor of Computer Applications"),
    ),
    DropdownMenuItem(
      value: "B.Sc.- Information Technology",
      child: Text("B.Sc.- Information Technology"),
    ),
    DropdownMenuItem(
      value: "B.Sc- Nursing",
      child: Text("B.Sc- Nursing"),
    ),
    DropdownMenuItem(
      value: "BPharma- Bachelor of Pharmacy",
      child: Text("BPharma- Bachelor of Pharmacy"),
    ),
    DropdownMenuItem(
      value: "BDS- Bachelor of Dental Surgery",
      child: Text("BDS- Bachelor of Dental Surgery"),
    ),
    DropdownMenuItem(
      value: "Animation, Graphics and Multimedia",
      child: Text("Animation, Graphics and Multimedia"),
    ),
    DropdownMenuItem(
      value: "B.Sc. – Nutrition & Dietetics",
      child: Text("B.Sc. – Nutrition & Dietetics"),
    ),
    DropdownMenuItem(
      value: "BPT- Bachelor of Physiotherapy",
      child: Text("BPT- Bachelor of Physiotherapy"),
    ),
    DropdownMenuItem(
      value: "B.Sc- Applied Geology",
      child: Text("B.Sc- Applied Geology"),
    ),
    DropdownMenuItem(
      value: "BA/B.Sc. Liberal Arts",
      child: Text("BA/B.Sc. Liberal Arts"),
    ),
    DropdownMenuItem(
      value: "B.Sc.- Physics",
      child: Text("B.Sc.- Physics"),
    ),
    DropdownMenuItem(
      value: "B.Sc. Chemistry",
      child: Text("B.Sc. Chemistry"),
    ),
    DropdownMenuItem(
      value: "B.Sc. Mathematics",
      child: Text("B.Sc. Mathematics"),
    ),
    DropdownMenuItem(
      value: "B.Com- Bachelor of Commerce",
      child: Text("B.Com- Bachelor of Commerce"),
    ),
    DropdownMenuItem(
      value: "BBA- Bachelor of Business Administration",
      child: Text(
        "BBA- Bachelor of Business Administration",
      ),
    ),
    DropdownMenuItem(
      value: "B.Com (Hons.)",
      child: Text(
        "B.Com (Hons.)",
      ),
    ),
    DropdownMenuItem(
      value: "BA (Hons.) in Economics",
      child: Text(
        "BA (Hons.) in Economics",
      ),
    ),
    DropdownMenuItem(
      value: "Integrated Law Program- B.Com LL.B.",
      child: Text(
        "Integrated Law Program- B.Com LL.B.",
      ),
    ),
    DropdownMenuItem(
      value: "Integarted Law Program- BBA LL.B",
      child: Text(
        "Integarted Law Program- BBA LL.B",
      ),
    ),
    DropdownMenuItem(
      value: "CA- Chartered Accountancy",
      child: Text(
        "CA- Chartered Accountancy",
      ),
    ),
    DropdownMenuItem(
      value: "CS- Company Secretary",
      child: Text(
        "CS- Company Secretary",
      ),
    ),
    DropdownMenuItem(
      value:
          "Bachelor of Design in Accessory Design, fashion Design, Ceramic Design, Leather Design, Graphic Design, Industrial Design, Jewellery Design",
      child: Text(
        "Bachelor of Design in Accessory Design, fashion Design, Ceramic Design, Leather Design, Graphic Design, Industrial Design, Jewellery Design",
      ),
    ),
    DropdownMenuItem(
        value: "Bachelor in Foreign Language",
        child: Text("Bachelor in Foreign Language")),
    DropdownMenuItem(value: "Diploma Courses", child: Text("Diploma Courses")),
    DropdownMenuItem(
        value: "Advanced Program (Advanced Program)",
        child: Text("Advanced Program (Advanced Program)")),
    DropdownMenuItem(
        value: "Executive Fellow Program In Management (E.F.P.M)",
        child: Text("Executive Fellow Program In Management (E.F.P.M)")),
    DropdownMenuItem(
        value: "Executive Management Programme (E.M.P)",
        child: Text("Executive Management Programme (E.M.P)")),
    DropdownMenuItem(
        value: "Executive Post Graduate Certificate (Executive PG Certificate)",
        child: Text(
            "Executive Post Graduate Certificate (Executive PG Certificate)")),
    DropdownMenuItem(
        value: "Executive Post Graduate Programme (Executive PG Programme)",
        child:
            Text("Executive Post Graduate Programme (Executive PG Programme)")),
    DropdownMenuItem(
        value: "Fellow Programme (Fellow Programme)",
        child: Text("Fellow Programme (Fellow Programme)")),
    DropdownMenuItem(
        value: "International Programme (International Programme)",
        child: Text("International Programme (International Programme)")),
    DropdownMenuItem(
        value: "Master of Law (LL.M)", child: Text("Master of Law (LL.M)")),
    DropdownMenuItem(
        value: "Master of Arts (M.A)", child: Text("Master of Arts (M.A)")),
    DropdownMenuItem(
        value: "Master of Arts in Management (M.A.M)",
        child: Text("Master of Arts in Management (M.A.M)")),
    DropdownMenuItem(
        value: "Master of Arts in Personal Management (M.A.P.M)",
        child: Text("Master of Arts in Personal Management (M.A.P.M)")),
    DropdownMenuItem(
        value: "Master of Architecture (M.Arch)",
        child: Text("Master of Architecture (M.Arch)")),
    DropdownMenuItem(
        value: "Master of Business Administration (M.B.A)",
        child: Text("Master of Business Administration (M.B.A)")),
    DropdownMenuItem(
        value: "Master of Business Economics (M.B.E)",
        child: Text("Master of Business Economics (M.B.E)")),
    DropdownMenuItem(
        value: "Master of Business Laws (M.B.L)",
        child: Text("Master of Business Laws (M.B.L)")),
    DropdownMenuItem(
        value: "Master of Business Management (M.B.M)",
        child: Text("Master of Business Management (M.B.M)")),
    DropdownMenuItem(
        value: "Master of Business Studies (M.B.S)",
        child: Text("Master of Business Studies (M.B.S)")),
    DropdownMenuItem(
        value: "Master of Computer Applications (M.C.A)",
        child: Text("Master of Computer Applications (M.C.A)")),
    DropdownMenuItem(
        value: "Master Of Communication And Journalism (M.C.J)",
        child: Text("Master Of Communication And Journalism (M.C.J)")),
    DropdownMenuItem(
        value: "Master of Comparative Laws (M.C.L)",
        child: Text("Master of Comparative Laws (M.C.L)")),
    DropdownMenuItem(
        value: "Master of Computer Management (M.C.M)",
        child: Text("Master of Computer Management (M.C.M)")),
    DropdownMenuItem(
        value: "Master of Corporate Secretaryship (M.C.S)",
        child: Text("Master of Corporate Secretaryship (M.C.S)")),
    DropdownMenuItem(
        value: "Master of Chirurgical (M.Ch)",
        child: Text("Master of Chirurgical (M.Ch)")),
    DropdownMenuItem(
        value: "Master of Commerce (M.Com)",
        child: Text("Master of Commerce (M.Com)")),
    DropdownMenuItem(
        value: "Doctor of Medicine (M.D)",
        child: Text("Doctor of Medicine (M.D)")),
    DropdownMenuItem(
        value: "Management Development Programme (M.D.P)",
        child: Text("Management Development Programme (M.D.P)")),
    DropdownMenuItem(
        value: "Master of Dental Surgery (M.D.S)",
        child: Text("Master of Dental Surgery (M.D.S)")),
    DropdownMenuItem(
        value: "Masters in Design (M.Des)",
        child: Text("Masters in Design (M.Des)")),
    DropdownMenuItem(
        value: "Master of Engineering (M.E)",
        child: Text("Master of Engineering (M.E)")),
    DropdownMenuItem(
        value: "Master of Education (M.Ed)",
        child: Text("Master of Education (M.Ed)")),
    DropdownMenuItem(
        value: "Master of education in Artificial Intelligence (M.Ed AI)",
        child:
            Text("Master of education in Artificial Intelligence (M.Ed AI)")),
    DropdownMenuItem(
        value: "Master of Fine Arts (M.F.A)",
        child: Text("Master of Fine Arts (M.F.A)")),
    DropdownMenuItem(
        value: "Master of Finance And Control (M.F.C)",
        child: Text("Master of Finance And Control (M.F.C)")),
    DropdownMenuItem(
        value: "Master of Film Management (M.F.M)",
        child: Text("Master of Film Management (M.F.M)")),
    DropdownMenuItem(
        value: "Master of Financial Services (M.F.S)",
        child: Text("Master of Financial Services (M.F.S)")),
    DropdownMenuItem(
        value: "Master of Fishery Sciences (M.F.Sc)",
        child: Text("Master of Fishery Sciences (M.F.Sc)")),
    DropdownMenuItem(
        value: "Master of Foreign Trade (M.F.T)",
        child: Text("Master of Foreign Trade (M.F.T)")),
    DropdownMenuItem(
        value: "Master of Hospital Administration (M.H.A)",
        child: Text("Master of Hospital Administration (M.H.A)")),
    DropdownMenuItem(
        value: "Master of Hospitality And Hotel Management (M.H.H.M)",
        child: Text("Master of Hospitality And Hotel Management (M.H.H.M)")),
    DropdownMenuItem(
        value: "Master of Hospitality Management (M.H.M)",
        child: Text("Master of Hospitality Management (M.H.M)")),
    DropdownMenuItem(
        value: "Master of Human Resource Management (M.H.R.M)",
        child: Text("Master of Human Resource Management (M.H.R.M)")),
    DropdownMenuItem(
        value: "Master Of Health Science (M.H.Sc)",
        child: Text("Master Of Health Science (M.H.Sc)")),
    DropdownMenuItem(
        value: "Masters of Hospitality and Tourism Management (M.H.T.M)",
        child: Text("Masters of Hospitality and Tourism Management (M.H.T.M)")),
    DropdownMenuItem(
        value: "Master of International Business (M.I.B)",
        child: Text("Master of International Business (M.I.B)")),
    DropdownMenuItem(
        value: "Masters in International Management (M.I.M)",
        child: Text("Masters in International Management (M.I.M)")),
    DropdownMenuItem(
        value: "Master of Journalism (M.J)",
        child: Text("Master of Journalism (M.J)")),
    DropdownMenuItem(
        value: "Master of Laws (M.L)", child: Text("Master of Laws (M.L)")),
    DropdownMenuItem(
        value: "Master of Library and Information Science (M.L.I.Sc)",
        child: Text("Master of Library and Information Science (M.L.I.Sc)")),
    DropdownMenuItem(
        value: "Master of Labour Management (M.L.M)",
        child: Text("Master of Labour Management (M.L.M)")),
    DropdownMenuItem(
        value: "Master of Library Science (M.L.Sc)",
        child: Text("Master of Library Science (M.L.Sc)")),
    DropdownMenuItem(
        value: "Master of Marketing Management (M.M.M)",
        child: Text("Master of Marketing Management (M.M.M)")),
    DropdownMenuItem(
        value: "Master of Management Program (M.M.P)",
        child: Text("Master of Management Program (M.M.P)")),
    DropdownMenuItem(
        value: "Master of Management Studies (M.M.S)",
        child: Text("Master of Management Studies (M.M.S)")),
    DropdownMenuItem(
        value: "Master of Occupational Theraphy (M.O.T)",
        child: Text("Master of Occupational Theraphy (M.O.T)")),
    DropdownMenuItem(
        value: "Master of Performing Arts (M.P.A)",
        child: Text("Master of Performing Arts (M.P.A)")),
    DropdownMenuItem(
        value: "Master of Psychiatric Epidemiology (M.P.E)",
        child: Text("Master of Psychiatric Epidemiology (M.P.E)")),
    DropdownMenuItem(
        value: "Master Of Physical Education (M.P.Ed)",
        child: Text("Master Of Physical Education (M.P.Ed)")),
    DropdownMenuItem(
        value: "Master of Public Health (M.P.H)",
        child: Text("Master of Public Health (M.P.H)")),
    DropdownMenuItem(
        value: "Masters Programme in International Business (M.P.I.B)",
        child: Text("Masters Programme in International Business (M.P.I.B)")),
    DropdownMenuItem(
        value: "Master of Performance Management (M.P.M)",
        child: Text("Master of Performance Management (M.P.M)")),
    DropdownMenuItem(
        value: "Masters in Public Systems Management (M.P.S.M)",
        child: Text("Masters in Public Systems Management (M.P.S.M)")),
    DropdownMenuItem(
        value: "Master of Physiotheraphy (M.P.T)",
        child: Text("Master of Physiotheraphy (M.P.T)")),
    DropdownMenuItem(
        value: "Master of Pharmacy (M.Pharma)",
        child: Text("Master of Pharmacy (M.Pharma)")),
    DropdownMenuItem(
        value: "Master of Philosophy (M.Phil)",
        child: Text("Master of Philosophy (M.Phil)")),
    DropdownMenuItem(
        value: "Master of Science (M.S)",
        child: Text("Master of Science (M.S)")),
    DropdownMenuItem(
        value: "Master of Social Dynamics (M.S.D)",
        child: Text("Master of Social Dynamics (M.S.D)")),
    DropdownMenuItem(
        value: "Master of Social Work (M.S.W)",
        child: Text("Master of Social Work (M.S.W)")),
    DropdownMenuItem(
        value: "Master of Science (M.Sc)",
        child: Text("Master of Science (M.Sc)")),
    DropdownMenuItem(
        value: "Master of Tourism Administrations (M.T.A)",
        child: Text("Master of Tourism Administrations (M.T.A)")),
    DropdownMenuItem(
        value: "Master of Tourism Management (M.T.M)",
        child: Text("Master of Tourism Management (M.T.M)")),
    DropdownMenuItem(
        value: "Master of Technology (M.Tech)",
        child: Text("Master of Technology (M.Tech)")),
    DropdownMenuItem(
        value: "Master of Theology (M.Th)",
        child: Text("Master of Theology (M.Th)")),
    DropdownMenuItem(
        value: "Master of Visual Arts (M.V.A)",
        child: Text("Master of Visual Arts (M.V.A)")),
    DropdownMenuItem(
        value: "Master of Veterinary Science (M.V.Sc)",
        child: Text("Master of Veterinary Science (M.V.Sc)")),
    DropdownMenuItem(
        value: "Master of Business Administration (MBA)",
        child: Text("Master of Business Administration (MBA)")),
    DropdownMenuItem(
        value:
            "Master of Industrial Relation and Personal Management (MIR and PM)",
        child: Text(
            "Master of Industrial Relation and Personal Management (MIR and PM)")),
    DropdownMenuItem(
        value: "Master of Personnel Management (MPM)",
        child: Text("Master of Personnel Management (MPM)")),
    DropdownMenuItem(
        value:
            "Master of Personal Management and Industrial Relation (MPM and IR)",
        child: Text(
            "Master of Personal Management and Industrial Relation (MPM and IR)")),
    DropdownMenuItem(
        value: "Master of Personnel Management (MPM)",
        child: Text("Master of Personnel Management (MPM)")),
    DropdownMenuItem(
        value: "Post Graduate Programme (PG Programme)",
        child: Text("Post Graduate Programme (PG Programme)")),
    DropdownMenuItem(
        value: "Doctor of Philosophy (Ph.D)",
        child: Text("Doctor of Philosophy (Ph.D)")),
    DropdownMenuItem(value: "Other", child: Text("Other")),
  ];

  @override
  void initState() {
    if (widget.response != '') {
      setState(() {
        educationAns = widget.response;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'PM',
          style:
              TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Whats Your Education?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: SearchableDropdown.single(
                displayClearIcon: false,
                hint: educationAns == ''
                    ? Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        educationAns!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                isExpanded: true,
                items: educations,
                //value: heightAns == '' ? Text('') : Text(heightAns!),
                onChanged: (val) {
                  educationAns = val;
                  print(educationAns);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                if (educationAns == '') {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Please Select Your Education.'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close')),
                          ],
                        );
                      });
                } else {
                  final globalController = Get.put(GlobalController());
                  Get.find<GlobalController>().currentAppuser.value.education =
                      educationAns;
                  DataBaseMethods().addUserEducation(educationAns!);

                  // Navigator.pop(context);
                  Get.off(EditProfileScreen());
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 17),
              ),
              style: ButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
