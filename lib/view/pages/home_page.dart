import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/services/local_stroge_services.dart';
import 'package:shopping_cart/view/pages/product_add_page.dart';
import 'package:shopping_cart/view/pages/product_list_page.dart';
import 'package:shopping_cart/view/pages/search_page.dart';
import '../../main.dart';
import '../../provider/home_page_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocalStrogeServices _localStroge;
  late HomePageState mystate_pof;
  @override
  void initState() {
    _localStroge = locator<LocalStrogeServices>();
    mystate_pof = Provider.of<HomePageState>(context, listen: false);
    mystate_pof.getAllProductDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const MyBottomNavigationBar(),
      appBar: AppBar(
        title: const Text("tabbarTitle").tr(),
        actions: [
          IconButton(
              onPressed: () async {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      allProduckts: mystate_pof.productsList),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Selector<HomePageState, int>(
        selector: (_, model) => model.currentIndex,
        builder: (_, model, __) {
          return model == 0 ? const ProductListPage() : ProductAddPage();
        },
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageState>(
      builder: (context, value, child) {
        return BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.list_alt,size: 36,),
              label: 'bottomBarTab1'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.add_box_outlined,size: 36,),
              label: 'bottomBarTab2'.tr(),
            ),
          ],
          currentIndex: value.currentIndex,
          selectedItemColor: Colors.green,
          onTap: (index) {
            value.currentIndex = index;
          },
        );
      },
    );
  }
}
