import 'package:country/country.dart';
import 'package:flutter/material.dart';

class SelectCountryView extends StatefulWidget {
  const SelectCountryView({super.key});

  @override
  State<SelectCountryView> createState() => _SelectCountryViewState();
}

class _SelectCountryViewState extends State<SelectCountryView> {
  @override
  Widget build(BuildContext context) {
    var locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Select a region"),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: Countries.values.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.pop(context, index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Text(
                          Countries.values[index].flagEmoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            Countries.values[index]
                                .isoShortNameByLanguage[locale.languageCode]!,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
