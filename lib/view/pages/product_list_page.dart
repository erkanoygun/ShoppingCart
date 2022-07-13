import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/home_page_state.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyListBuilder();
  }
}

class MyListBuilder extends StatelessWidget {
  const MyListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageState>(
      builder: (context, mystate, child) {
        return mystate.isDataLoading
            ? const SizedBox()
            : mystate.productsList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: mystate.productsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        onDismissed: (direction) {
                          mystate.productRemove(mystate.productsList[index]);
                          mystate.productsList.removeAt(index);
                        },
                        key: Key(mystate.productsList[index].id),
                        child: Card(
                          color: Colors.white70,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: mystate.productsList[index].isPurchased
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
                                    mystate.productIsPurshed(index);
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      mystate.productsList[index].productname,
                                      style: TextStyle(
                                          fontSize: 18,
                                          decoration: mystate
                                                  .productsList[index]
                                                  .isPurchased
                                              ? TextDecoration.lineThrough
                                              : null),
                                    ),
                                    Text(
                                      "${mystate.productsList[index].quantity} ${mystate.productsList[index].quantityType}",
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
                    child: const Text(
                      "isEmptyList",
                      style: TextStyle(fontSize: 14),
                    ).tr(),
                  );
      },
    );
  }
}
