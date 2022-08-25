import 'package:flutter/material.dart';
import 'package:odc/shared/components/constants.dart';

class CustomDelegate extends SearchDelegate<String> {
  List<String> data = names;

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List listToShow;
    if (query.isNotEmpty) {
      listToShow =
          data.where((e) => e.contains(query) && e.startsWith(query)).toList();
    } else {
      listToShow = [];
    }

    return listToShow.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(image: AssetImage("assets/icons/frame.png")),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Not found",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: listToShow.length,
            itemBuilder: (_, i) {
              var noun = listToShow[i];
              return ListTile(
                title: Text(noun),
                onTap: () => close(context, noun),
              );
            },
          );
  }
}
