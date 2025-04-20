import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apna_mandi/providers/language_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'language'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              title: Text('english'.tr()),
              leading: const Icon(Icons.language),
              trailing: Radio<String>(
                value: 'en',
                groupValue: context.locale.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    languageProvider.changeLanguage(value).then((_) {
                      if (context.mounted) {
                        context.setLocale(Locale(value));
                      }
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: Text('hindi'.tr()),
              leading: const Icon(Icons.language),
              trailing: Radio<String>(
                value: 'hi',
                groupValue: context.locale.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    languageProvider.changeLanguage(value).then((_) {
                      if (context.mounted) {
                        context.setLocale(Locale(value));
                      }
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: Text('punjabi'.tr()),
              leading: const Icon(Icons.language),
              trailing: Radio<String>(
                value: 'pa',
                groupValue: context.locale.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    languageProvider.changeLanguage(value).then((_) {
                      if (context.mounted) {
                        context.setLocale(Locale(value));
                      }
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: Text('gujarati'.tr()),
              leading: const Icon(Icons.language),
              trailing: Radio<String>(
                value: 'gu',
                groupValue: context.locale.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    languageProvider.changeLanguage(value).then((_) {
                      if (context.mounted) {
                        context.setLocale(Locale(value));
                      }
                    });
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
