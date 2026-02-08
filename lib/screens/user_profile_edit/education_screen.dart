import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/edit_profile_screen.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  List<String> educations = [
    "BBA- Bachelor of Business Administration",
    "BMS- Bachelor of Management Science",
    "BFA- Bachelor of Fine Arts",
    "BEM- Bachelor of Event Management",
    "Integrated Law Course- BA + LL.B",
    "BJMC- Bachelor of Journalism and Mass Communication",
    "BFD- Bachelor of Fashion Designing",
    "BSW- Bachelor of Social Work",
    "BBS- Bachelor of Business Studies",
    "BTTM- Bachelor of Travel and Tourism Management",
    "Aviation Courses",
    "B.Sc- Interior Design",
    "B.Sc.- Hospitality and Hotel Administration",
    "Bachelor of Design (B. Design)",
    "Bachelor of Performing Arts",
    "BA in History",
    "BE/B.Tech- Bachelor of Technology",
    "B.Arch- Bachelor of Architecture",
    "BCA- Bachelor of Computer Applications",
    "B.Sc.- Information Technology",
    "B.Sc- Nursing",
    "BPharma- Bachelor of Pharmacy",
    "BDS- Bachelor of Dental Surgery",
    "Animation, Graphics and Multimedia",
    "B.Sc. – Nutrition & Dietetics",
    "BPT- Bachelor of Physiotherapy",
    "B.Sc- Applied Geology",
    "BA/B.Sc. Liberal Arts",
    "B.Sc. Chemistry",
    "B.Sc. Mathematics" "B.Com- Bachelor of Commerce",
    "BBA- Bachelor of Business Administration",
    "B.Com (Hons.)",
    "BA (Hons.) in Economics",
    "Integrated Law Program- B.Com LL.B.",
    "Integarted Law Program- BBA LL.B",
    "CA- Chartered Accountancy",
    "CS- Company Secretary",
    "Bachelor of Design in Accessory Design, fashion Design, Ceramic Design, Leather Design, Graphic Design, Industrial Design, Jewellery Design",
    "Bachelor in Foreign Language",
    "Diploma Courses",
    "Advanced Program (Advanced Program)",
    "Executive Fellow Program In Management (E.F.P.M)",
    "Executive Management Programme (E.M.P)",
    "Executive Post Graduate Certificate (Executive PG Certificate)",
    "Executive Post Graduate Programme (Executive PG Programme)",
    "Fellow Programme (Fellow Programme)",
    "International Programme (International Programme)",
    "Master of Law (LL.M)",
    "Master of Arts (M.A)",
    "Master of Arts in Management (M.A.M)",
    "Master of Arts in Personal Management (M.A.P.M)",
    "Master of Architecture (M.Arch)",
    "Master of Business Administration (M.B.A)",
    "Master of Business Economics (M.B.E)",
    "Master of Business Laws (M.B.L)",
    "Master of Business Management (M.B.M)",
    "Master of Business Studies (M.B.S)",
    "Master of Computer Applications (M.C.A)",
    "Master Of Communication And Journalism (M.C.J)",
    "Master of Comparative Laws (M.C.L)",
    "Master of Computer Management (M.C.M)",
    "Master of Corporate Secretaryship (M.C.S)",
    "Master of Chirurgical (M.Ch)",
    "Master of Commerce (M.Com)",
    "Doctor of Medicine (M.D)",
    "Management Development Programme (M.D.P)",
    "Master of Dental Surgery (M.D.S)",
    "Masters in Design (M.Des)",
    "Master of Engineering (M.E)",
    "Master of Education (M.Ed)",
    "Master of education in Artificial Intelligence (M.Ed AI)",
    "Master of Fine Arts (M.F.A)",
    "Master of Finance And Control (M.F.C)",
    "Master of Film Management (M.F.M)",
    "Master of Financial Services (M.F.S)",
    "Master of Fishery Sciences (M.F.Sc)",
    "Master of Foreign Trade (M.F.T)",
    "Master of Hospital Administration (M.H.A)",
    "Master of Hospitality And Hotel Management (M.H.H.M)",
    "Master of Hospitality Management (M.H.M)",
    "Master of Human Resource Management (M.H.R.M)",
    "Master Of Health Science (M.H.Sc)",
    "Masters of Hospitality and Tourism Management (M.H.T.M)",
    "Master of International Business (M.I.B)",
    "Masters in International Management (M.I.M)",
    "Master of Journalism (M.J)",
    "Master of Laws (M.L)",
    "Master of Library and Information Science (M.L.I.Sc)",
    "Master of Labour Management (M.L.M)",
    "Master of Library Science (M.L.Sc)",
    "Master of Marketing Management (M.M.M)",
    "Master of Management Program (M.M.P)",
    "Master of Management Studies (M.M.S)",
    "Master of Occupational Theraphy (M.O.T)",
    "Master of Performing Arts (M.P.A)",
    "Master of Psychiatric Epidemiology (M.P.E)",
    "Master Of Physical Education (M.P.Ed)",
    "Master of Public Health (M.P.H)",
    "Masters Programme in International Business (M.P.I.B)",
    "Master of Performance Management (M.P.M)",
    "Masters in Public Systems Management (M.P.S.M)",
    "Master of Physiotheraphy (M.P.T)",
    "Master of Pharmacy (M.Pharma)",
    "Master of Philosophy (M.Phil)",
    "Master of Science (M.S)",
    "Master of Social Dynamics (M.S.D)",
    "Master of Social Work (M.S.W)",
    "Master of Science (M.Sc)",
    "Master of Tourism Administrations (M.T.A)",
    "Master of Tourism Management (M.T.M)",
    "Master of Technology (M.Tech)",
    "Master of Theology (M.Th)",
    "Master of Visual Arts (M.V.A)",
    "Master of Veterinary Science (M.V.Sc)",
    "Master of Business Administration (MBA)",
    "Master of Industrial Relation and Personal Management (MIR and PM)",
    "Master of Personnel Management (MPM)",
    "Master of Personal Management and Industrial Relation (MPM and IR)",
    "Master of Personnel Management (MPM)",
    "Post Graduate Programme (PG Programme)",
    "Doctor of Philosophy (Ph.D)",
    "Other",
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
              child: DropdownSearch<String>(
                itemAsString: (item) {
                  return item;
                },
                items: (_, __) {
                  return educations;
                },
                selectedItem: educationAns != null && educationAns!.isNotEmpty ? educationAns : null,
                onChanged: (val) {
                  setState(() {
                    educationAns = val ?? '';
                  });
                },
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem ?? 'Select',
                  style: TextStyle(
                    color: selectedItem == null ? Colors.grey : Colors.black,
                    fontSize: 18,
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  showSelectedItems: true,
                ),
                // selectedItem: "Brazil"
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
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 85, 115, 0.89),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
