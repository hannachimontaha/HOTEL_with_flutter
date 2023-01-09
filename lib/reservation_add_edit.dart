import 'package:firebase_formAuth/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ReservationAddEdit extends StatefulWidget {
  const ReservationAddEdit({Key? key}) : super(key: key);

  @override
  _ReservationAddEditState createState() => _ReservationAddEditState();
}

class _ReservationAddEditState extends State<ReservationAddEdit> {
  //ReservationModel? reservationModel;

  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isAPICallProcess = false;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ADD RESERVATION"),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: globalFormKey,
          child: reservationForm(),
        ),
        //inAsyncCall : isAPICallProcess,
        //  opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
   // reservationModel = ReservationModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    //    reservationModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget reservationForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "Id",
              "ID",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "ID can't be empty";
                }
                return null;
              },
                  (onSavedVal) {
             //   reservationModel!.id = int.parse(onSavedVal);
              },
           //   initialValue: reservationModel!.id == null ? "" : reservationModel!.id.toString(),
              backgroundColor: hexStringToColor("95326A"),
              borderFocusColor: hexStringToColor("632161"),
              borderColor: hexStringToColor("6647C2"),
              textColor: Colors.black,
              hintColor: Colors.white,
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.verified_user_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "ClientName",
              "Client Name",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Reservation can't be empty";
                }
                return null;
              },
                  (onSavedVal) => {
               // reservationModel!.client_name = onSavedVal,
              },
             // initialValue: reservationModel!.client_name ?? "",
              backgroundColor: hexStringToColor("632161"),
              borderFocusColor: hexStringToColor("632161"),
              borderColor: hexStringToColor("6647C2"),
              textColor: Colors.black,
              hintColor: Colors.white,
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.person),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "NbrNuits",
              "Nombre Nuits",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "nbr nuits can't be empty";
                }
                return null;
              },
                  (onSavedVal) {
             //   reservationModel!.nbr_nuits = int.parse(onSavedVal);
              },
             // initialValue: reservationModel!.nbr_nuits == null ? "" : reservationModel!.nbr_nuits.toString(),
              backgroundColor: hexStringToColor("632161"),
              borderFocusColor: hexStringToColor("632161"),
              borderColor: hexStringToColor("6647C2"),
              textColor: Colors.black,
              hintColor: Colors.white,
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.night_shelter),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "NbrChambres",
              "Nombre Chambres",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "nbr_chambres can't be empty";
                }
                return null;
              },
                  (onSavedVal) {
             //   reservationModel!.nbr_chambres = int.parse(onSavedVal);
              },
            //  initialValue: reservationModel!.nbr_chambres == null ? ""  : reservationModel!.nbr_chambres.toString(),
              backgroundColor: hexStringToColor("632161"),
              borderFocusColor: hexStringToColor("632161"),
              borderColor: hexStringToColor("6647C2"),
              textColor: Colors.black,
              hintColor: Colors.white,
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.meeting_room_rounded),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "NbrAdultes",
              "Nombre Adultes",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "nbr adultes can't be empty";
                }
                return null;
              },
                  (onSavedVal) {
              //  reservationModel!.nbr_adultes = int.parse(onSavedVal);
             },
             // initialValue: reservationModel!.nbr_adultes == null ? "" : reservationModel!.nbr_adultes.toString(),
              backgroundColor: hexStringToColor("632161"),
              borderFocusColor: hexStringToColor("632161"),
              borderColor: hexStringToColor("6647C2"),
              textColor: Colors.black,
              hintColor: Colors.white,
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.family_restroom),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "NbrEnfants",
              "Nombre Enfants",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "nbr enfants can't be empty";
                }
                return null;
              },
                  (onSavedVal) {
             //   reservationModel!.nbr_enfants = int.parse(onSavedVal);
              },
             // initialValue: reservationModel!.nbr_enfants == null  ? ""  : reservationModel!.nbr_enfants.toString(),

              backgroundColor: hexStringToColor("632161"),
              borderFocusColor: hexStringToColor("632161"),
              borderColor: hexStringToColor("6647C2"),
              textColor: Colors.black,
              hintColor: Colors.white,
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.child_friendly_rounded),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "DateReservation",
              "Date Reservation",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "date reservation can't be empty";
                }
                return null;
              },
                  (onSavedVal) => {
             //   reservationModel!.date_reservation = onSavedVal,
              },
            //  initialValue: reservationModel!.date_reservation ?? "",

              backgroundColor: hexStringToColor("632161"),
              borderFocusColor: hexStringToColor("632161"),
              borderColor: hexStringToColor("6647C2"),
              textColor: Colors.black,
              hintColor: Colors.white,
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.date_range_sharp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "UserId",
              "User ID",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "user id can't be empty";
                }
                return null;
              },
                  (onSavedVal) {
             //   reservationModel!.user_id = int.parse(onSavedVal);
              },
            //  initialValue: reservationModel!.user_id == null   ? ""   : reservationModel!.user_id.toString(),
              backgroundColor: hexStringToColor("632161"),
              borderFocusColor: hexStringToColor("632161"),
              borderColor: hexStringToColor("6647C2"),
              textColor: Colors.black,
              hintColor: Colors.white,
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.supervised_user_circle),
            ),
          ),
          Center(
              child: FormHelper.submitButton(
                "Save", () {
                if (validateAndSave()) {}

              },
                btnColor: hexStringToColor("632161"),
                borderColor: Colors.white,
                borderRadius: 10,
              )
          ),
        ],
      ),
    );
  }
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
