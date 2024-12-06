// import 'package:flutter/material.dart';
// import 'package:weather/models/constants.dart';
// import 'package:weather/page/home.dart';

// class Welcome extends StatelessWidget {
//   const Welcome({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Constants myConstants = Constants();

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: myConstants.secondaryColor,
//         title: const Text('Welcome to Weather Prediction'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Welcome to Weather Prediction!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: myConstants.primaryColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Get accurate and reliable weather forecasts for your location.',
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: myConstants.secondaryColor,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 40, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => HomeScreen()),
//                   );
//                 },
//                 child: const Text(
//                   'Start',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
