import 'dart:io';
import 'dart:typed_data';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/views/widgets/quot_widget_preview.dart';
import 'package:quotes_app/views/widgets/quot_widget_share.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../controllers/favorite_controller.dart';
import '../../models/quote_model.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';

enum SocialShare {
  telegram,
  whatsapp,
  facebook,
  facebookMessenger,
  twitter,
  instagramFeed,
  instagramDirect,
  facebookStories,
  instagramStories,
  tiktok,
  copyLink,
  system,
}

class QuoteDetailPage extends ConsumerStatefulWidget {
  QuoteDetailPage({super.key, required this.quote});
  final Quote quote;

  @override
  ConsumerState<QuoteDetailPage> createState() => _QuoteDetailPageState();
}

class _QuoteDetailPageState extends ConsumerState<QuoteDetailPage> {
  Quote get quote => widget.quote;

  // @override
  // void initState() {
  //   takeScreenshotQuotWidget();
  //
  //   super.initState();
  // }

  void onTapFavorite(bool isFavorite, WidgetRef ref) {
    print(isFavorite);

    ref
        .read(favoriteProvider.notifier)
        .toggleFavorite(quote, isFavorite)
        .then((_) {
      ref.refresh(favoriteProvider);
    });
  }

  AppinioSocialShare appinioSocialShare = AppinioSocialShare();

  void shareQuoteTo(SocialShare socialShare) async {
    String quot = "${quote.content}\n\n ~ ${quote.author}";

    // convert Uint8List to File
    final tempDir = await getTemporaryDirectory();
    final imagePath = await File('${tempDir.path}/quot-widget.png').create();
    await imagePath.writeAsBytes(memoryImage!);
    final filePath = imagePath.path;

    String fbAppID = dotenv.get('FACEBOOK_APP_ID');

    switch (socialShare) {
      case SocialShare.telegram:
        appinioSocialShare.shareToTelegram(quot, filePath: filePath);
        break;
      case SocialShare.whatsapp:
        appinioSocialShare.shareToWhatsapp(quot, filePath: filePath);
        break;
      case SocialShare.facebook:
        appinioSocialShare.shareToFacebook(quot, filePath);
        break;
      case SocialShare.instagramStories:
        appinioSocialShare.shareToInstagramStory(
          fbAppID,
          attributionURL: "https://quot.codemagic.app",
          backgroundImage: filePath,
        );
        break;
      case SocialShare.facebookMessenger:
        appinioSocialShare.shareToMessenger(quot);
        break;
      case SocialShare.twitter:
        appinioSocialShare.shareToTwitter(quot, filePath: filePath);
        break;
      case SocialShare.instagramFeed:
        appinioSocialShare.shareToInstagramFeed(filePath);
        break;
      case SocialShare.instagramDirect:
        appinioSocialShare.shareToInstagramDirect(quot);
        break;
      case SocialShare.tiktok:
        appinioSocialShare.shareToTiktokStatus(filePath);
        break;
      case SocialShare.copyLink:
        appinioSocialShare.copyToClipBoard(quot);
        break;
      default:
        appinioSocialShare.shareToSystem(
          "Share Quot",
          quot,
          filePath: filePath,
        );
    }
  }

  Widget socialShareMenuItem(
    BuildContext context,
    SocialShare socialShareType,
    IconData icon,
    Color iconColor,
    String title, {
    bool isHorizontal = false,
  }) {
    Widget child = Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(width: 20),
        Text(
          title,
          style: MyTypography.body1.copyWith(
            color: MyColors.black,
          ),
        ),
      ],
    );

    if (isHorizontal) {
      child = Column(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: MyTypography.body1.copyWith(
              color: MyColors.black,
            ),
          ),
        ],
      );
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        shareQuoteTo(socialShareType);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: child,
      ),
    );
  }

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? memoryImage;

  GlobalKey quotCardKey = GlobalKey();
  GlobalKey iconButtonKey = GlobalKey();

  Future<void> takeScreenshotQuotWidget() async {
    // Get size of body widget
    final keyContext = quotCardKey.currentContext;
    final iconButtonContext = iconButtonKey.currentContext;
    if (keyContext == null && iconButtonContext == null) {
      return;
    }

    RenderBox box = keyContext!.findRenderObject() as RenderBox;
    RenderBox iconButtonBox =
        iconButtonContext!.findRenderObject() as RenderBox;

    final cardWidget = QuotWidgetShare(
      quote: quote,
      height: box.size.height - iconButtonBox.size.height - 60,
      width: box.size.width,
    );

    final memoryImage =
        await screenshotController.captureFromWidget(cardWidget);

    setState(() {
      this.memoryImage = memoryImage;
    });
  }

  // share quote widget to social media
  WoltModalSheetPage shareQuotWidget(BuildContext woltContext) {
    //Capture Done
    return WoltModalSheetPage.withSingleChild(
      topBarTitle: Text(
        "Share Quot Widget",
        style: MyTypography.h3,
      ),
      isTopBarLayerAlwaysVisible: true,
      navBarHeight: 70,
      forceMaxHeight: true,
      child: QuotWidgetPreview(
        memoryImage: memoryImage!,
        menuWidget: Container(
          child: Row(
            children: [
              socialShareMenuItem(
                context,
                SocialShare.telegram,
                PhosphorIcons.regular.telegramLogo,
                Colors.blue,
                "Telegram",
                isHorizontal: true,
              ),
              socialShareMenuItem(
                context,
                SocialShare.whatsapp,
                PhosphorIcons.regular.whatsappLogo,
                Colors.green,
                "Whatsapp",
                isHorizontal: true,
              ),
              socialShareMenuItem(
                context,
                SocialShare.facebook,
                PhosphorIcons.regular.facebookLogo,
                Colors.blue,
                "Facebook",
                isHorizontal: true,
              ),
              socialShareMenuItem(
                context,
                SocialShare.instagramStories,
                PhosphorIcons.regular.instagramLogo,
                Colors.pinkAccent,
                "Instagram Stories",
                isHorizontal: true,
              ),
              socialShareMenuItem(
                context,
                SocialShare.facebookMessenger,
                PhosphorIcons.regular.messengerLogo,
                Colors.pinkAccent,
                "Facebook Messenger",
                isHorizontal: true,
              ),
              socialShareMenuItem(
                context,
                SocialShare.twitter,
                PhosphorIcons.regular.twitterLogo,
                Colors.blue,
                "Twitter",
                isHorizontal: true,
              ),
              socialShareMenuItem(
                context,
                SocialShare.instagramFeed,
                PhosphorIcons.regular.instagramLogo,
                Colors.pinkAccent,
                "Instagram Feed",
                isHorizontal: true,
              ),
              socialShareMenuItem(
                context,
                SocialShare.instagramDirect,
                PhosphorIcons.regular.instagramLogo,
                Colors.pinkAccent,
                "Instagram Direct",
                isHorizontal: true,
              ),
              socialShareMenuItem(
                context,
                SocialShare.tiktok,
                PhosphorIcons.regular.tiktokLogo,
                Colors.black,
                "Tiktok",
                isHorizontal: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // share quote to social media
  WoltModalSheetPage shareQuot(BuildContext woltContext) {
    return WoltModalSheetPage.withSingleChild(
      topBarTitle: Text(
        "Share Quot",
        style: MyTypography.h3,
      ),
      isTopBarLayerAlwaysVisible: true,
      navBarHeight: 70,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          children: [
            socialShareMenuItem(
              context,
              SocialShare.telegram,
              PhosphorIcons.regular.telegramLogo,
              Colors.blue,
              "Telegram",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.whatsapp,
              PhosphorIcons.regular.whatsappLogo,
              Colors.green,
              "Whatsapp",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.facebook,
              PhosphorIcons.regular.facebookLogo,
              Colors.blue,
              "Facebook",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.facebookMessenger,
              PhosphorIcons.regular.messengerLogo,
              Colors.pinkAccent,
              "Facebook Messenger",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.twitter,
              PhosphorIcons.regular.twitterLogo,
              Colors.blue,
              "Twitter",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.instagramFeed,
              PhosphorIcons.regular.instagramLogo,
              Colors.pinkAccent,
              "Instagram Feed",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.instagramDirect,
              PhosphorIcons.regular.instagramLogo,
              Colors.pinkAccent,
              "Instagram Direct",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.tiktok,
              PhosphorIcons.regular.tiktokLogo,
              Colors.black,
              "Tiktok",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.copyLink,
              PhosphorIcons.regular.copy,
              Colors.black,
              "Copy Link",
            ),
            const SizedBox(height: 10),
            socialShareMenuItem(
              context,
              SocialShare.system,
              PhosphorIcons.regular.shareNetwork,
              Colors.black,
              "More",
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);

    final favoriteQuotesState = ref.watch(favoriteProvider);

    final isFavorite = ref.watch(favoriteProvider.notifier).isFavorite(quote);

    // select share options
    WoltModalSheetPage selectShareOptions(BuildContext woltContext) {
      return WoltModalSheetPage.withSingleChild(
        hasTopBarLayer: false,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  pageIndexNotifier.value = 1;
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.regular.textAa,
                        color: MyColors.black,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Share Quot as Text",
                        style: MyTypography.body1.copyWith(
                          color: MyColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (memoryImage != null) {
                    pageIndexNotifier.value = 2;
                  }

                  print(memoryImage);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.regular.cards,
                        color: MyColors.black,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Share Quot as Widget",
                        style: MyTypography.body1.copyWith(
                          color: MyColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 76,
        leading: IconSolidLight(
          icon: PhosphorIcons.regular.caretLeft,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "Quote Detail",
          style: MyTypography.h3,
        ),
      ),
      body: Container(
        key: quotCardKey,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        decoration: BoxDecoration(
          color: Color(quote.backgroundColor),
          borderRadius: BorderRadius.circular(36),
        ),
        child: Column(
          children: [
            Icon(
              PhosphorIcons.fill.quotes,
              size: 70,
              color: Color(quote.textColor),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AutoSizeText(
                quote.content,
                maxFontSize: 28,
                minFontSize: 18,
                maxLines: 10,
                textAlign: quote.textAlign,
                style: GoogleFonts.getFont(
                  quote.fontFamily,
                  color: Color(quote.textColor),
                  fontSize: quote.fontSize ?? 28,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (quote.avatar == null)
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 35,
                    width: 35,
                    child: Center(
                      child: Text(
                        quote.author[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(quote.avatar!),
                  ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quote.author,
                        maxLines: 1,
                        style: MyTypography.body2.copyWith(
                          color: Color(quote.textColor),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (quote.profession != null && quote.profession != "")
                        const SizedBox(height: 5),
                      if (quote.profession != null && quote.profession != "")
                        Text(
                          quote.profession!,
                          style: MyTypography.body2.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(quote.textColor),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 60),
            Row(
              key: iconButtonKey,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (quote.id != null)
                  favoriteQuotesState.isLoading
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            color: MyColors.secondary,
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: MyColors.primaryDark,
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        )
                      : IconSolidLight(
                          onTap: () => onTapFavorite(isFavorite, ref),
                          icon: isFavorite
                              ? PhosphorIcons.fill.heart
                              : PhosphorIcons.regular.heart,
                        ),
                if (quote.id != null) const SizedBox(width: 16),
                // share button with icon
                ElevatedButton.icon(
                  onPressed: () {
                    takeScreenshotQuotWidget();

                    if (memoryImage == null) {
                      return;
                    }

                    WoltModalSheet.show(
                      context: context,
                      pageIndexNotifier: pageIndexNotifier,
                      pageListBuilder: (woltContext) => [
                        selectShareOptions(woltContext),
                        shareQuot(woltContext),
                        shareQuotWidget(woltContext),
                      ],
                    );
                  },
                  icon: Icon(PhosphorIcons.fill.shareFat),
                  label: const Text("Share"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
