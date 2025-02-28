import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioBloc extends ChangeNotifier {
  PortfolioBloc();

  // Keys para identificar cada sección
  final sobreMiKey = GlobalKey();
  final educacionKey = GlobalKey();
  final skillsKey = GlobalKey();
  final proyectosKey = GlobalKey();
  final contactameKey = GlobalKey();

  final scrollController = ScrollController();

  void scrollToItem(int index) {
    double offset;

    switch (index) {
      case 0:
        offset = scrollController.position.minScrollExtent;
        break;
      case 1:
        offset = scrollController.position.maxScrollExtent * 0.2;
        break;
      case 2:
        offset = scrollController.position.maxScrollExtent * 0.4;
        break;
      case 3:
        offset = scrollController.position.maxScrollExtent * 0.6;
        break;
      case 4:
        offset = scrollController.position.maxScrollExtent * 0.8;
        break;
      default:
        offset = 0;
    }
    scrollController.animateTo(
      offset,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Future<void> downloadFile(BuildContext context) async {
    const String fileUrl =
        'https://drive.google.com/file/d/1OkDflrDMXIdiisdwg51QqcAYIw3GZEV5/view?usp=sharing';
    final Uri url = Uri.parse(fileUrl);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se puede abrir la URL')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se puede abrir la URL')),
        );
      }
    }
  }

  Future<void> laucherUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  final Map<String, String> socialLinks = const {
    'instagram':
        'https://www.instagram.com/jorge_grullon98/?utm_source=qr&igsh=YWU3eG1qcnJ5Y3Bs',
    'linkedin':
        'https://www.linkedin.com/in/jorge-grull%C3%B3n-289719282?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
    'whatsapp': 'https://wa.me/+50242909548',
    'youtube': 'https://www.youtube.com/@ingenieriachapina6283',
    'x': 'https://x.com/i/flow/login?redirect_after_login=%2FJorgeLuisGM8',
    'facebook':
        'https://www.facebook.com/IngenieroChapin2020?mibextid=qi2Omg&rdid=Km56BXybkMWe7K2A&share_url=https%3A%2F%2Fwww.facebook.com%2Fshare%2FjAVvopraGfLTRwfL%2F%3Fmibextid%3Dqi2Omg',
  };

  final listMenuItem = [
    'SOBRE MI',
    'EDUCACIÓN',
    'SKILLS',
    'PROYECTOS',
    'CONTACTAME',
  ];

  final listEducation = [
    {
      'title': '\nUniversidad Mariano Galvez',
      'content': '2017 - actualidad',
    },
    {
      'title': '\nColegio IMB-PC',
      'content': '2012 - 2016',
    },
  ];

  final listSkills = [
    {
      'skill': 'Flutter',
      'level': 0.95,
    },
    {
      'skill': 'Dart',
      'level': 0.95,
    },
    {
      'skill': 'GraphQL',
      'level': 0.6,
    },
    {
      'skill': 'Javascript',
      'level': 0.5,
    },
    {
      'skill': 'Prisma',
      'level': 0.2,
    },
    {
      'skill': 'Scrum',
      'level': 1.0,
    },
    {
      'skill': 'PostgreSQL',
      'level': 0.9,
    },
    {
      'skill': 'MySQL',
      'level': 0.6,
    },
    {
      'skill': 'Oracle',
      'level': 0.6,
    },
    {
      'skill': 'Git y Github',
      'level': 1.0,
    },
    {
      'skill': 'Apollo Server',
      'level': 0.4,
    },
  ];
}
