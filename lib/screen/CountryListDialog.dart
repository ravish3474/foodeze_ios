
import 'package:flutter/material.dart';
import 'package:foodeze_flutter/common/CommonWidgets.dart';
import 'package:foodeze_flutter/common/CustomTextField.dart';
import 'package:foodeze_flutter/common/Images.dart';
import 'package:foodeze_flutter/utils/Theme.dart';
import 'package:foodeze_flutter/utils/Util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodeze_flutter/extensions/UtilExtensions.dart';


class CountryListDialog extends StatefulWidget {
  @override
  _CountryListDialogState createState() => _CountryListDialogState();
}

class _CountryListDialogState extends State<CountryListDialog> {
  FocusNode messageFocus = FocusNode();
  List<CountryEntity> countries = codes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,

          padding: 16.paddingAll(),
      child: Column(children: [
        SizedBox(
          height: getstatusBarHeight(context),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff7D6592), width: 0.8),
              borderRadius: BorderRadius.circular(25)),
          child: CustomTextField(
            boarder: true,
            onTextChanged: (query) {
              var list = codes();
              var flist = list.where((a) => a.countryCode!.toUpperCase().contains(query.toUpperCase()) || a.countryName!.toUpperCase().contains(query.toUpperCase() ));
              setState(() {
                countries = flist.toList();
              });
            },
            focusNode: messageFocus,
            activePrefix: Images.search,
            inActivePrefix: Images.search,
            hint: 'Search ..',
            textStyle: GoogleFonts.poppins(
                fontSize: 14, color: colorPrimary, fontWeight: FontWeight.bold),
          ),
        ),
        16.horizontalSpace(),
        Expanded(
            child: CustomList(
              shrinkWrap: true,
                list: countries,
                child: (CountryEntity data, index) {
                  return GestureDetector(
                    onTap: (){
                      pressBack(result: data);
                    },
                    child: Container(
                      padding: 4.paddingAll(),
                      child: Text(
                        '${data.countryCode} (${data.dialCode}) : ${data.countryName}',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                  );

                     /*
                      .onTap((){
                    pressBack(result: data);
                  });*/


                }))
      ]),
    ));
  }
}

 List<CountryEntity> codes() {
  return [
    CountryEntity(countryName: "Israel", dialCode: "+972", countryCode: "IL"),
    CountryEntity(
        countryName: "Afghanistan", dialCode: "+93", countryCode: "AF"),
    CountryEntity(countryName: "Albania", dialCode: "+355", countryCode: "AL"),
    CountryEntity(countryName: "Algeria", dialCode: "+213", countryCode: "DZ"),
    CountryEntity(
        countryName: "AmericanSamoa", dialCode: "+1 684", countryCode: "AS"),
    CountryEntity(countryName: "Andorra", dialCode: "+376", countryCode: "AD"),
    CountryEntity(countryName: "Angola", dialCode: "+244", countryCode: "AO"),
    CountryEntity(
        countryName: "Anguilla", dialCode: "+1 264", countryCode: "AI"),
    CountryEntity(
        countryName: "Antigua and Barbuda",
        dialCode: "+1268",
        countryCode: "AG"),
    CountryEntity(countryName: "Argentina", dialCode: "+54", countryCode: "AR"),
    CountryEntity(countryName: "Armenia", dialCode: "+374", countryCode: "AM"),
    CountryEntity(countryName: "Aruba", dialCode: "+297", countryCode: "AW"),
    CountryEntity(countryName: "Australia", dialCode: "+61", countryCode: "AU"),
    CountryEntity(countryName: "Austria", dialCode: "+43", countryCode: "AT"),
    CountryEntity(
        countryName: "Azerbaijan", dialCode: "+994", countryCode: "AZ"),
    CountryEntity(
        countryName: "Bahamas", dialCode: "+1 242", countryCode: "BS"),
    CountryEntity(countryName: "Bahrain", dialCode: "+973", countryCode: "BH"),
    CountryEntity(
        countryName: "Bangladesh", dialCode: "+880", countryCode: "BD"),
    CountryEntity(
        countryName: "Barbados", dialCode: "+1 246", countryCode: "BB"),
    CountryEntity(countryName: "Belarus", dialCode: "+375", countryCode: "BY"),
    CountryEntity(countryName: "Belgium", dialCode: "+32", countryCode: "BE"),
    CountryEntity(countryName: "Belize", dialCode: "+501", countryCode: "BZ"),
    CountryEntity(countryName: "Benin", dialCode: "+229", countryCode: "BJ"),
    CountryEntity(
        countryName: "Bermuda", dialCode: "+1 441", countryCode: "BM"),
    CountryEntity(countryName: "Bhutan", dialCode: "+975", countryCode: "BT"),
    CountryEntity(
        countryName: "Bosnia and Herzegovina",
        dialCode: "+387",
        countryCode: "BA"),
    CountryEntity(countryName: "Botswana", dialCode: "+267", countryCode: "BW"),
    CountryEntity(countryName: "Brazil", dialCode: "+55", countryCode: "BR"),
    CountryEntity(
        countryName: "British Indian Ocean Territory",
        dialCode: "+246",
        countryCode: "IO"),
    CountryEntity(countryName: "Bulgaria", dialCode: "+359", countryCode: "BG"),
    CountryEntity(
        countryName: "Burkina Faso", dialCode: "+226", countryCode: "BF"),
    CountryEntity(countryName: "Burundi", dialCode: "+257", countryCode: "BI"),
    CountryEntity(countryName: "Cambodia", dialCode: "+855", countryCode: "KH"),
    CountryEntity(countryName: "Cameroon", dialCode: "+237", countryCode: "CM"),
    CountryEntity(countryName: "Canada", dialCode: "+1", countryCode: "CA"),
    CountryEntity(
        countryName: "Cape Verde", dialCode: "+238", countryCode: "CV"),
    CountryEntity(
        countryName: "Cayman Islands", dialCode: "+ 345", countryCode: "KY"),
    CountryEntity(
        countryName: "Central African Republic",
        dialCode: "+236",
        countryCode: "CF"),
    CountryEntity(countryName: "Chad", dialCode: "+235", countryCode: "TD"),
    CountryEntity(countryName: "Chile", dialCode: "+56", countryCode: "CL"),
    CountryEntity(countryName: "China", dialCode: "+86", countryCode: "CN"),
    CountryEntity(
        countryName: "Christmas Island", dialCode: "+61", countryCode: "CX"),
    CountryEntity(countryName: "Colombia", dialCode: "+57", countryCode: "CO"),
    CountryEntity(countryName: "Comoros", dialCode: "+269", countryCode: "KM"),
    CountryEntity(countryName: "Congo", dialCode: "+242", countryCode: "CG"),
    CountryEntity(
        countryName: "Cook Islands", dialCode: "+682", countryCode: "CK"),
    CountryEntity(
        countryName: "Costa Rica", dialCode: "+506", countryCode: "CR"),
    CountryEntity(countryName: "Croatia", dialCode: "+385", countryCode: "HR"),
    CountryEntity(countryName: "Cuba", dialCode: "+53", countryCode: "CU"),
    CountryEntity(countryName: "Cyprus", dialCode: "+537", countryCode: "CY"),
    CountryEntity(
        countryName: "Czech Republic", dialCode: "+420", countryCode: "CZ"),
    CountryEntity(countryName: "Denmark", dialCode: "+45", countryCode: "DK"),
    CountryEntity(countryName: "Djibouti", dialCode: "+253", countryCode: "DJ"),
    CountryEntity(
        countryName: "Dominica", dialCode: "+1 767", countryCode: "DM"),
    CountryEntity(
        countryName: "Dominican Republic",
        dialCode: "+1 849",
        countryCode: "DO"),
    CountryEntity(countryName: "Ecuador", dialCode: "+593", countryCode: "EC"),
    CountryEntity(countryName: "Egypt", dialCode: "+20", countryCode: "EG"),
    CountryEntity(
        countryName: "El Salvador", dialCode: "+503", countryCode: "SV"),
    CountryEntity(
        countryName: "Equatorial Guinea", dialCode: "+240", countryCode: "GQ"),
    CountryEntity(countryName: "Eritrea", dialCode: "+291", countryCode: "ER"),
    CountryEntity(countryName: "Estonia", dialCode: "+372", countryCode: "EE"),
    CountryEntity(countryName: "Ethiopia", dialCode: "+251", countryCode: "ET"),
    CountryEntity(
        countryName: "Faroe Islands", dialCode: "+298", countryCode: "FO"),
    CountryEntity(countryName: "Fiji", dialCode: "+679", countryCode: "FJ"),
    CountryEntity(countryName: "Finland", dialCode: "+358", countryCode: "FI"),
    CountryEntity(countryName: "France", dialCode: "+33", countryCode: "FR"),
    CountryEntity(
        countryName: "French Guiana", dialCode: "+594", countryCode: "GF"),
    CountryEntity(
        countryName: "French Polynesia", dialCode: "+689", countryCode: "PF"),
    CountryEntity(countryName: "Gabon", dialCode: "+241", countryCode: "GA"),
    CountryEntity(countryName: "Gambia", dialCode: "+220", countryCode: "GM"),
    CountryEntity(countryName: "Georgia", dialCode: "+995", countryCode: "GE"),
    CountryEntity(countryName: "Germany", dialCode: "+49", countryCode: "DE"),
    CountryEntity(countryName: "Ghana", dialCode: "+233", countryCode: "GH"),
    CountryEntity(
        countryName: "Gibraltar", dialCode: "+350", countryCode: "GI"),
    CountryEntity(countryName: "Greece", dialCode: "+30", countryCode: "GR"),
    CountryEntity(
        countryName: "Greenland", dialCode: "+299", countryCode: "GL"),
    CountryEntity(
        countryName: "Grenada", dialCode: "+1 473", countryCode: "GD"),
    CountryEntity(
        countryName: "Guadeloupe", dialCode: "+590", countryCode: "GP"),
    CountryEntity(countryName: "Guam", dialCode: "+1 671", countryCode: "GU"),
    CountryEntity(
        countryName: "Guatemala", dialCode: "+502", countryCode: "GT"),
    CountryEntity(countryName: "Guinea", dialCode: "+224", countryCode: "GN"),
    CountryEntity(
        countryName: "Guinea-Bissau", dialCode: "+245", countryCode: "GW"),
    CountryEntity(countryName: "Guyana", dialCode: "+595", countryCode: "GY"),
    CountryEntity(countryName: "Haiti", dialCode: "+509", countryCode: "HT"),
    CountryEntity(countryName: "Honduras", dialCode: "+504", countryCode: "HN"),
    CountryEntity(countryName: "Hungary", dialCode: "+36", countryCode: "HU"),
    CountryEntity(countryName: "Iceland", dialCode: "+354", countryCode: "IS"),
    CountryEntity(countryName: "India", dialCode: "+91", countryCode: "IN"),
    CountryEntity(countryName: "Indonesia", dialCode: "+62", countryCode: "ID"),
    CountryEntity(countryName: "Iraq", dialCode: "+964", countryCode: "IQ"),
    CountryEntity(countryName: "Ireland", dialCode: "+353", countryCode: "IE"),
    CountryEntity(countryName: "Israel", dialCode: "+972", countryCode: "IL"),
    CountryEntity(countryName: "Italy", dialCode: "+39", countryCode: "IT"),
    CountryEntity(
        countryName: "Jamaica", dialCode: "+1 876", countryCode: "JM"),
    CountryEntity(countryName: "Japan", dialCode: "+81", countryCode: "JP"),
    CountryEntity(countryName: "Jordan", dialCode: "+962", countryCode: "JO"),
    CountryEntity(
        countryName: "Kazakhstan", dialCode: "+7 7", countryCode: "KZ"),
    CountryEntity(countryName: "Kenya", dialCode: "+254", countryCode: "KE"),
    CountryEntity(countryName: "Kiribati", dialCode: "+686", countryCode: "KI"),
    CountryEntity(countryName: "Kuwait", dialCode: "+965", countryCode: "KW"),
    CountryEntity(
        countryName: "Kyrgyzstan", dialCode: "+996", countryCode: "KG"),
    CountryEntity(countryName: "Latvia", dialCode: "+371", countryCode: "LV"),
    CountryEntity(countryName: "Lebanon", dialCode: "+961", countryCode: "LB"),
    CountryEntity(countryName: "Lesotho", dialCode: "+266", countryCode: "LS"),
    CountryEntity(countryName: "Liberia", dialCode: "+231", countryCode: "LR"),
    CountryEntity(
        countryName: "Liechtenstein", dialCode: "+423", countryCode: "LI"),
    CountryEntity(
        countryName: "Lithuania", dialCode: "+370", countryCode: "LT"),
    CountryEntity(
        countryName: "Luxembourg", dialCode: "+352", countryCode: "LU"),
    CountryEntity(
        countryName: "Madagascar", dialCode: "+261", countryCode: "MG"),
    CountryEntity(countryName: "Malawi", dialCode: "+265", countryCode: "MW"),
    CountryEntity(countryName: "Malaysia", dialCode: "+60", countryCode: "MY"),
    CountryEntity(countryName: "Maldives", dialCode: "+960", countryCode: "MV"),
    CountryEntity(countryName: "Mali", dialCode: "+223", countryCode: "ML"),
    CountryEntity(countryName: "Malta", dialCode: "+356", countryCode: "MT"),
    CountryEntity(
        countryName: "Marshall Islands", dialCode: "+692", countryCode: "MH"),
    CountryEntity(
        countryName: "Martinique", dialCode: "+596", countryCode: "MQ"),
    CountryEntity(
        countryName: "Mauritania", dialCode: "+222", countryCode: "MR"),
    CountryEntity(
        countryName: "Mauritius", dialCode: "+230", countryCode: "MU"),
    CountryEntity(countryName: "Mayotte", dialCode: "+262", countryCode: "YT"),
    CountryEntity(countryName: "Mexico", dialCode: "+52", countryCode: "MX"),
    CountryEntity(countryName: "Monaco", dialCode: "+377", countryCode: "MC"),
    CountryEntity(countryName: "Mongolia", dialCode: "+976", countryCode: "MN"),
    CountryEntity(
        countryName: "Montenegro", dialCode: "+382", countryCode: "ME"),
    CountryEntity(
        countryName: "Montserrat", dialCode: "+1664", countryCode: "MS"),
    CountryEntity(countryName: "Morocco", dialCode: "+212", countryCode: "MA"),
    CountryEntity(countryName: "Myanmar", dialCode: "+95", countryCode: "MM"),
    CountryEntity(countryName: "Namibia", dialCode: "+264", countryCode: "NA"),
    CountryEntity(countryName: "Nauru", dialCode: "+674", countryCode: "NR"),
    CountryEntity(countryName: "Nepal", dialCode: "+977", countryCode: "NP"),
    CountryEntity(
        countryName: "Netherlands", dialCode: "+31", countryCode: "NL"),
    CountryEntity(
        countryName: "Netherlands Antilles",
        dialCode: "+599",
        countryCode: "AN"),
    CountryEntity(
        countryName: "New Caledonia", dialCode: "+687", countryCode: "NC"),
    CountryEntity(
        countryName: "New Zealand", dialCode: "+64", countryCode: "NZ"),
    CountryEntity(
        countryName: "Nicaragua", dialCode: "+505", countryCode: "NI"),
    CountryEntity(countryName: "Niger", dialCode: "+227", countryCode: "NE"),
    CountryEntity(countryName: "Nigeria", dialCode: "+234", countryCode: "NG"),
    CountryEntity(countryName: "Niue", dialCode: "+683", countryCode: "NU"),
    CountryEntity(
        countryName: "Norfolk Island", dialCode: "+672", countryCode: "NF"),
    CountryEntity(
        countryName: "Northern Mariana Islands",
        dialCode: "+1 670",
        countryCode: "MP"),
    CountryEntity(countryName: "Norway", dialCode: "+47", countryCode: "NO"),
    CountryEntity(countryName: "Oman", dialCode: "+968", countryCode: "OM"),
    CountryEntity(countryName: "Pakistan", dialCode: "+92", countryCode: "PK"),
    CountryEntity(countryName: "Palau", dialCode: "+680", countryCode: "PW"),
    CountryEntity(countryName: "Panama", dialCode: "+507", countryCode: "PA"),
    CountryEntity(
        countryName: "Papua New Guinea", dialCode: "+675", countryCode: "PG"),
    CountryEntity(countryName: "Paraguay", dialCode: "+595", countryCode: "PY"),
    CountryEntity(countryName: "Peru", dialCode: "+51", countryCode: "PE"),
    CountryEntity(
        countryName: "Philippines", dialCode: "+63", countryCode: "PH"),
    CountryEntity(countryName: "Poland", dialCode: "+48", countryCode: "PL"),
    CountryEntity(countryName: "Portugal", dialCode: "+351", countryCode: "PT"),
    CountryEntity(
        countryName: "Puerto Rico", dialCode: "+1 939", countryCode: "PR"),
    CountryEntity(countryName: "Qatar", dialCode: "+974", countryCode: "QA"),
    CountryEntity(countryName: "Romania", dialCode: "+40", countryCode: "RO"),
    CountryEntity(countryName: "Rwanda", dialCode: "+250", countryCode: "RW"),
    CountryEntity(countryName: "Samoa", dialCode: "+685", countryCode: "WS"),
    CountryEntity(
        countryName: "San Marino", dialCode: "+378", countryCode: "SM"),
    CountryEntity(
        countryName: "Saudi Arabia", dialCode: "+966", countryCode: "SA"),
    CountryEntity(countryName: "Senegal", dialCode: "+221", countryCode: "SN"),
    CountryEntity(countryName: "Serbia", dialCode: "+381", countryCode: "RS"),
    CountryEntity(
        countryName: "Seychelles", dialCode: "+248", countryCode: "SC"),
    CountryEntity(
        countryName: "Sierra Leone", dialCode: "+232", countryCode: "SL"),
    CountryEntity(countryName: "Singapore", dialCode: "+65", countryCode: "SG"),
    CountryEntity(countryName: "Slovakia", dialCode: "+421", countryCode: "SK"),
    CountryEntity(countryName: "Slovenia", dialCode: "+386", countryCode: "SI"),
    CountryEntity(
        countryName: "Solomon Islands", dialCode: "+677", countryCode: "SB"),
    CountryEntity(
        countryName: "South Africa", dialCode: "+27", countryCode: "ZA"),
    CountryEntity(
        countryName: "South Georgia and the South Sandwich Islands",
        dialCode: "+500",
        countryCode: "GS"),
    CountryEntity(countryName: "Spain", dialCode: "+34", countryCode: "ES"),
    CountryEntity(countryName: "Sri Lanka", dialCode: "+94", countryCode: "LK"),
    CountryEntity(countryName: "Sudan", dialCode: "+249", countryCode: "SD"),
    CountryEntity(
        countryName: "SuricountryName", dialCode: "+597", countryCode: "SR"),
    CountryEntity(
        countryName: "Swaziland", dialCode: "+268", countryCode: "SZ"),
    CountryEntity(countryName: "Sweden", dialCode: "+46", countryCode: "SE"),
    CountryEntity(
        countryName: "Switzerland", dialCode: "+41", countryCode: "CH"),
    CountryEntity(
        countryName: "Tajikistan", dialCode: "+992", countryCode: "TJ"),
    CountryEntity(countryName: "Thailand", dialCode: "+66", countryCode: "TH"),
    CountryEntity(countryName: "Togo", dialCode: "+228", countryCode: "TG"),
    CountryEntity(countryName: "Tokelau", dialCode: "+690", countryCode: "TK"),
    CountryEntity(countryName: "Tonga", dialCode: "+676", countryCode: "TO"),
    CountryEntity(
        countryName: "Trinidad and Tobago",
        dialCode: "+1 868",
        countryCode: "TT"),
    CountryEntity(countryName: "Tunisia", dialCode: "+216", countryCode: "TN"),
    CountryEntity(countryName: "Turkey", dialCode: "+90", countryCode: "TR"),
    CountryEntity(
        countryName: "Turkmenistan", dialCode: "+993", countryCode: "TM"),
    CountryEntity(
        countryName: "Turks and Caicos Islands",
        dialCode: "+1 649",
        countryCode: "TC"),
    CountryEntity(countryName: "Tuvalu", dialCode: "+688", countryCode: "TV"),
    CountryEntity(countryName: "Uganda", dialCode: "+256", countryCode: "UG"),
    CountryEntity(countryName: "Ukraine", dialCode: "+380", countryCode: "UA"),
    CountryEntity(
        countryName: "United Arab Emirates",
        dialCode: "+971",
        countryCode: "AE"),
    CountryEntity(
        countryName: "United Kingdom", dialCode: "+44", countryCode: "GB"),
    CountryEntity(
        countryName: "United States", dialCode: "+1", countryCode: "US"),
    CountryEntity(countryName: "Uruguay", dialCode: "+598", countryCode: "UY"),
    CountryEntity(
        countryName: "Uzbekistan", dialCode: "+998", countryCode: "UZ"),
    CountryEntity(countryName: "Vanuatu", dialCode: "+678", countryCode: "VU"),
    CountryEntity(
        countryName: "Wallis and Futuna", dialCode: "+681", countryCode: "WF"),
    CountryEntity(countryName: "Yemen", dialCode: "+967", countryCode: "YE"),
    CountryEntity(countryName: "Zambia", dialCode: "+260", countryCode: "ZM"),
    CountryEntity(countryName: "Zimbabwe", dialCode: "+263", countryCode: "ZW"),
    CountryEntity(countryName: "land Islands", dialCode: "", countryCode: "AX"),
    CountryEntity(countryName: "Antarctica", dialCode: null, countryCode: "AQ"),
    CountryEntity(
        countryName: "Bolivia, Plurinational State of",
        dialCode: "+591",
        countryCode: "BO"),
    CountryEntity(
        countryName: "Brunei Darussalam", dialCode: "+673", countryCode: "BN"),
    CountryEntity(
        countryName: "Cocos (Keeling) Islands",
        dialCode: "+61",
        countryCode: "CC"),
    CountryEntity(
        countryName: "Congo, The Democratic Republic of the",
        dialCode: "+243",
        countryCode: "CD"),
    CountryEntity(
        countryName: "Cote d'Ivoire", dialCode: "+225", countryCode: "CI"),
    CountryEntity(
        countryName: "Falkland Islands (Malvinas)",
        dialCode: "+500",
        countryCode: "FK"),
    CountryEntity(countryName: "Guernsey", dialCode: "+44", countryCode: "GG"),
    CountryEntity(
        countryName: "Holy See (Vatican City State)",
        dialCode: "+379",
        countryCode: "VA"),
    CountryEntity(
        countryName: "Hong Kong", dialCode: "+852", countryCode: "HK"),
    CountryEntity(
        countryName: "Iran, Islamic Republic of",
        dialCode: "+98",
        countryCode: "IR"),
    CountryEntity(
        countryName: "Isle of Man", dialCode: "+44", countryCode: "IM"),
    CountryEntity(countryName: "Jersey", dialCode: "+44", countryCode: "JE"),
    CountryEntity(
        countryName: "Korea, Democratic People's Republic of",
        dialCode: "+850",
        countryCode: "KP"),
    CountryEntity(
        countryName: "Korea, Republic of", dialCode: "+82", countryCode: "KR"),
    CountryEntity(
        countryName: "Lao People's Democratic Republic",
        dialCode: "+856",
        countryCode: "LA"),
    CountryEntity(
        countryName: "Libyan Arab Jamahiriya",
        dialCode: "+218",
        countryCode: "LY"),
    CountryEntity(countryName: "Macao", dialCode: "+853", countryCode: "MO"),
    CountryEntity(
        countryName: "Macedonia, The Former Yugoslav Republic of",
        dialCode: "+389",
        countryCode: "MK"),
    CountryEntity(
        countryName: "Micronesia, Federated States of",
        dialCode: "+691",
        countryCode: "FM"),
    CountryEntity(
        countryName: "Moldova, Republic of",
        dialCode: "+373",
        countryCode: "MD"),
    CountryEntity(
        countryName: "Mozambique", dialCode: "+258", countryCode: "MZ"),
    CountryEntity(
        countryName: "Palestinian Territory, Occupied",
        dialCode: "+970",
        countryCode: "PS"),
    CountryEntity(countryName: "Pitcairn", dialCode: "+872", countryCode: "PN"),
    CountryEntity(countryName: "Réunion", dialCode: "+262", countryCode: "RE"),
    CountryEntity(countryName: "Russia", dialCode: "+7", countryCode: "RU"),
    CountryEntity(
        countryName: "Saint Barthélemy", dialCode: "+590", countryCode: "BL"),
    CountryEntity(
        countryName: "Saint Helena, Ascension and Tristan Da Cunha",
        dialCode: "+290",
        countryCode: "SH"),
    CountryEntity(
        countryName: "Saint Kitts and Nevis",
        dialCode: "+1 869",
        countryCode: "KN"),
    CountryEntity(
        countryName: "Saint Lucia", dialCode: "+1 758", countryCode: "LC"),
    CountryEntity(
        countryName: "Saint Martin", dialCode: "+590", countryCode: "MF"),
    CountryEntity(
        countryName: "Saint Pierre and Miquelon",
        dialCode: "+508",
        countryCode: "PM"),
    CountryEntity(
        countryName: "Saint Vincent and the Grenadines",
        dialCode: "+1 784",
        countryCode: "VC"),
    CountryEntity(
        countryName: "Sao Tome and Principe",
        dialCode: "+239",
        countryCode: "ST"),
    CountryEntity(countryName: "Somalia", dialCode: "+252", countryCode: "SO"),
    CountryEntity(
        countryName: "Svalbard and Jan Mayen",
        dialCode: "+47",
        countryCode: "SJ"),
    CountryEntity(
        countryName: "Syrian Arab Republic",
        dialCode: "+963",
        countryCode: "SY"),
    CountryEntity(
        countryName: "Taiwan, Province of China",
        dialCode: "+886",
        countryCode: "TW"),
    CountryEntity(
        countryName: "Tanzania, United Republic of",
        dialCode: "+255",
        countryCode: "TZ"),
    CountryEntity(
        countryName: "Timor-Leste", dialCode: "+670", countryCode: "TL"),
    CountryEntity(
        countryName: "Venezuela, Bolivarian Republic of",
        dialCode: "+58",
        countryCode: "VE"),
    CountryEntity(countryName: "Viet Nam", dialCode: "+84", countryCode: "VN"),
    CountryEntity(
        countryName: "Virgin Islands, British",
        dialCode: "+1 284",
        countryCode: "VG"),
    CountryEntity(
        countryName: "Virgin Islands, U.S.",
        dialCode: "+1 340",
        countryCode: "VI")
  ];
}

class CountryEntity {
  String? countryName;
  String? dialCode;
  String? countryCode;

  CountryEntity({this.countryCode, this.dialCode, this.countryName});
}
