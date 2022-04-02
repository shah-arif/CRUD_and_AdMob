import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsPageInts extends StatefulWidget {
  const AdsPageInts({Key? key}) : super(key: key);

  @override
  State<AdsPageInts> createState() => _AdsPageIntsState();
}

class _AdsPageIntsState extends State<AdsPageInts> {
  final myInterstitialAds = InterstitialAd.load(
      adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712':'ca-app-pub-3940256099942544/4411468910',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad){
            print("Ads loaded successfully");
            ad.show();
          },
          onAdFailedToLoad: (LoadAdError error){
            print("InterstitialAd failed to load: $error");
          }
      )
  );
  @override
  void initState() {
    myInterstitialAds;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

        ],
      ),
    );
  }
}
