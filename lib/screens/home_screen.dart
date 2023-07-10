// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:first/model/locale_storage.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter_vpn/flutter_vpn.dart';
// // import 'package:flutter_vpn/state.dart';
// import 'package:http/http.dart' as http;
// import 'package:system_network_proxy/system_network_proxy.dart';
//
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   String information = "";
//
//   // FlutterVpnState state = FlutterVpnState.disconnected;
//
//   @override
//   void initState() {
//     // FlutterVpn.prepare();
//     // FlutterVpn.onStateChanged.listen((s) => setState(() => state = s));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Text('current state'),
//             SizedBox(height: 45),
//             ElevatedButton(
//               onPressed: connectVPN,
//               child: Text('Connect/Disconnect'),
//               style: ElevatedButton.styleFrom(
//                 shape: CircleBorder(),
//                 padding: EdgeInsets.all(24),
//                 minimumSize: Size(100.0, 100.0),
//               ),
//             ),
//             SizedBox(height: 45),
//             Text(information)
//           ],
//         ),
//       ),
//     );
//   }
//
//   void connectVPN() async{
//     // if(state != FlutterVpnState.disconnected){
//     //   await FlutterVpn.disconnect();
//     //   return;
//     // }
//
//     if(await SystemNetworkProxy.getProxyEnable()){
//       await SystemNetworkProxy.setProxyEnable(!(await SystemNetworkProxy.getProxyEnable()));
//       return;
//     }
//
//     await SystemNetworkProxy.setProxyEnable(!(await SystemNetworkProxy.getProxyEnable()));
//
//     var url = 'http://95.164.17.135:8000/api/free_proxy';
//
//     var token = await Storage.getToken();
//
//     var response = await http.get(Uri.parse(url), headers: {'Auth' : token});
//
//
//     if (response.statusCode == 200) {
//       print('Connected');
//       final jsonData = jsonDecode(response.body);
//       final proxy = jsonData['proxy'];
//       final host = proxy['host'];
//       final port = proxy['port'];
//       final username = proxy['username'];
//       final password = proxy['password'];
//       final ad = jsonData['ad'];
//
//       setState(() {
//         information = 'Connecting';
//       });
//       try {
//         // await FlutterVpn.connectIkev2EAP(server: '$host', username: '$username', password: '$password', port: port);
//         await SystemNetworkProxy.setProxyServer('http://$username:${password}@$host:$port/');
//       }catch (e) {
//         setState(() {
//           information = e.toString();
//         });
//         return;
//       }
//       setState(() {
//         information = 'connected';
//       });
//       } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//   }
//
// }