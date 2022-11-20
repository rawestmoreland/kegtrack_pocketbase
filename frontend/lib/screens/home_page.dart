import 'package:flutter/material.dart';
import 'package:frontend/screens/user_settings_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../models/keg_model.dart';
import '../services/keg_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final kegService = Provider.of<KegService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kegs"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const UserSettingsPage();
                },
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const UserSettingsPage();
              },
            ),
          ),
          icon: const Icon(Icons.person),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: kegService.status == KegStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: kegService.kegs.length,
                itemBuilder: (context, i) {
                  final keg = kegService.kegs[i];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: const Icon(MdiIcons.beer),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(keg.name),
                          ),
                          subtitle: Column(
                            children: [
                              LinearPercentIndicator(
                                lineHeight: 20.0,
                                barRadius: const Radius.circular(18),
                                progressColor: Colors.blueAccent,
                                percent:
                                    (keg.remainingVolume / keg.totalVolume),
                                center: Text(
                                  "${((keg.remainingVolume / keg.totalVolume) * 100).toStringAsFixed(0)}%",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
