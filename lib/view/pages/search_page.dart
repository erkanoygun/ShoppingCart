import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/model/products.dart';
import 'package:shopping_cart/provider/home_page_state.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Product> allProduckts;

  CustomSearchDelegate({required this.allProduckts});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? null : query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> filterList = allProduckts
        .where((element) =>
            element.productname.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Consumer<HomePageState>(
      builder: (context, mystate, child) {
        return filterList.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: filterList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      mystate.productsList.removeWhere((element) {
                        return element.id == filterList[index].id;
                      });
                      mystate.productRemove(filterList[index]);
                      filterList.removeAt(index);
                    },
                    key: Key(filterList[index].id),
                    child: Card(
                      color: Colors.white70,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: filterList[index].isPurchased
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 32,
                                    )
                                  : const Icon(
                                      Icons.radio_button_unchecked,
                                      size: 32,
                                    ),
                              onPressed: () {
                                /*filterList içerisinde aranarak bulunan elemanın producktList içersinde kaçıncı indexte bulunduğunu
                                seçilen elemanın id değerini productList içerisindeki elemanların id değerleri ile karşılaştırarak 
                                buluyoruz ve bulunan index değerini yolluyoruz */
                                final int productsListIndex =
                                    mystate.productsList.indexWhere((element) =>
                                        element.id == filterList[index].id);
                                mystate.productIsPurshed(productsListIndex);
                                //mystate.productIsPurshed(filterList[index].id);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  filterList[index].productname,
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: filterList[index].isPurchased
                                          ? TextDecoration.lineThrough
                                          : null),
                                ),
                                Text(
                                  "${filterList[index].quantity} ${filterList[index].quantityType}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: const Text("notFoundItem").tr(),
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
