import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/data_source/response_model.dart';
import '../../data/models/CryptoModel/crypto_data.dart';
import '../../logic/providers/choice_chip_provider.dart';
import '../../logic/providers/crypto_data_provider.dart';
import '../helpers/decimalRounder.dart';
import 'ui_helper/home_page_view.dart';
import 'ui_helper/themes_switcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(
    initialPage: 0,
  );

  var defaultChoiceIndex = 0;

  final List<String> _choicesList = [
    'Top MarketCaps',
    'Top Gainers',
    'Top Losers'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    var _size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: const [
          ThemesSwitcher(),
        ],
        backgroundColor: primaryColor,
        title: const Text("ExchangeBs"),
        titleTextStyle: textTheme.titleLarge,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                                dotWidth: 10, dotHeight: 10),
                            onDotClicked: (index) =>
                                _pageViewController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Marquee(
                  text: '🔊 this is place for news in application ',
                  style: textTheme.bodySmall,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 5,
                  left: 5,
                ),
                child: Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text("buy"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        backgroundColor: Colors.red[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text("sell"),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5, top: 1),
                child: Row(
                  children: [
                    Consumer<ChoiceChipProiver>(
                        builder: (context, data, child) {
                      return Wrap(
                        spacing: 8,
                        children: List.generate(_choicesList.length, (index) {
                          return ChoiceChip(
                            label: Text(
                              _choicesList[index],
                              style: textTheme.titleSmall,
                            ),
                            selected: defaultChoiceIndex == index,
                            selectedColor: Colors.blue,
                            onSelected: (value) {
                              defaultChoiceIndex =
                                  value ? index : defaultChoiceIndex;
                              Provider.of<ChoiceChipProiver>(context,
                                      listen: false)
                                  .selectNotify(context, index);
                            },
                          );
                        }),
                      );
                    })
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: Consumer<CryptoDataProvider>(
                  builder: (context, cryptoDataProvider, child) {
                    switch (cryptoDataProvider.state.status) {
                      case Status.LOADING:
                        return SizedBox(
                          height: 80,
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.white,
                              child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, bottom: 8, left: 8),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: SizedBox(
                                                    width: 25,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            width: 70,
                                            height: 40,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: SizedBox(
                                                    width: 25,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })),
                        );
                      case Status.COMPLETED:
                        List<CryptoData> model = cryptoDataProvider
                            .dataFuture.data!.cryptoCurrencyList!;

                        return ListView.separated(
                            itemBuilder: (context, index) {
                              var number = index + 1;
                              var tokenId = model[index].id;

                              MaterialColor filterColor =
                                  DecimalRounder.setColorFilter(
                                      model[index].quotes![0].percentChange24h);
                              var finalPrice =
                                  DecimalRounder.removePriceDecimals(
                                      model[index].quotes![0].price);

                              var percentChange =
                                  DecimalRounder.removePercentDecimals(
                                      model[index].quotes![0].percentChange24h);

                              var percentColor =
                                  DecimalRounder.setPercentChangesColor(
                                      model[index].quotes![0].percentChange24h);
                              var percentIcon =
                                  DecimalRounder.setPercentChangesIcon(
                                      model[index].quotes![0].percentChange24h);

                              return SizedBox(
                                height: _size.height * 0.075,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        number.toString(),
                                        style: textTheme.bodySmall,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 15),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                            const Duration(milliseconds: 500),
                                        height: 32,
                                        width: 32,
                                        imageUrl:
                                            "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model[index].name!.length > 10
                                                ? "${model[index]
                                                        .name!
                                                        .substring(0, 10)}.."
                                                : model[index].name!,
                                            style: textTheme.bodySmall,
                                          ),
                                          Text(
                                            model[index].symbol!,
                                            style: textTheme.labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                        fit: FlexFit.tight,
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                filterColor, BlendMode.srcATop),
                                            child: SvgPicture.network(
                                                "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg"))),
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "\$$finalPrice",
                                            style: textTheme.bodySmall,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              percentIcon,
                                              Text(
                                                "$percentChange%",
                                                style: GoogleFonts.ubuntu(
                                                    color: percentColor,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: model.length);
                      case Status.ERROR:
                        return const Text("Error .......");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
