
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsPageBanner extends StatefulWidget {
  const AdsPageBanner({Key? key}) : super(key: key);

  @override
  State<AdsPageBanner> createState() => _AdsPageBannerState();
}

class _AdsPageBannerState extends State<AdsPageBanner> {
  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );
  @override
  void initState() {
    myBanner.load();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 250,width: double.infinity,child: AdWidget(ad: myBanner))
        ],
      ),
    );
  }
}
