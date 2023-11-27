import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../utils/utils.dart';

class ListContainer extends StatelessWidget {
  const ListContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, int i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) => {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteScanById(scans[i].id!)
        },
        child: ListTile(
          leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
          title: Text(scans[i].value),
          subtitle: Text('${scans.length.toString()} - ${scans[i].type}'),
          trailing: Icon(Icons.arrow_right_sharp,
              color: Theme.of(context).primaryColor),
          onTap: () => launchUrlFuture(context, scans[i]),
        ),
      ),
    );
  }
}
