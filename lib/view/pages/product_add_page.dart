import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/home_page_state.dart';

class ProductAddPage extends StatelessWidget {
  ProductAddPage({Key? key}) : super(key: key);
  final TextEditingController _textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomePageState mystate_pof =
        Provider.of<HomePageState>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(5.0),
              border: OutlineInputBorder(),
            ),
            controller: _textcontroller,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 50,
                    child: Consumer<HomePageState>(
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                value.addQuantity();
                              },
                              icon: const Icon(Icons.add),
                            ),
                            Text(
                              "${value.quantity}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                value.removeQuantity();
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Consumer<HomePageState>(
                    builder: (context, mystate, child) {
                      return DropdownButton<String>(
                        isExpanded: true,
                        value: mystate.changeDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        onChanged: (String? newValue) {
                          mystate.changeDropdownValue = newValue!;
                        },
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        items: dropDownItems(4),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_textcontroller.text.isNotEmpty) {
                  mystate_pof.addProduckts(_textcontroller.text);
                  FocusScope.of(context).unfocus();
                  _textcontroller.clear();
                  mystate_pof.quantity = 1;
                }
              },
              child: const Text("addItemList").tr(),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>>? dropDownItems(int itemCount) {
    List<DropdownMenuItem<String>> itemlist = [];
    for (int i = 1; i <= itemCount; i++) {
      itemlist.add(
        DropdownMenuItem(
          value: 'dropDownMenuItem$i'.tr(),
          child: Center(
            child: Text('dropDownMenuItem$i'.tr(), textAlign: TextAlign.center),
          ),
        ),
      );
    }
    return itemlist;
  }
}
