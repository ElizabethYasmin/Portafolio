import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:portafolio_yasmin/features/portfolio/presentation/bloc/portafolio_bloc.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/widgets/about_me_widget.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/widgets/contact_widget.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/widgets/education_widget.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/widgets/skill_bar.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/widgets/social_network_icon.dart';
import 'package:portafolio_yasmin/utils/data_info.dart';
import 'package:portafolio_yasmin/utils/download_file_button.dart';
import 'package:portafolio_yasmin/utils/title_widget.dart';

class MainDataWidget extends StatelessWidget {
  const MainDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PortfolioBloc>();

    return SingleChildScrollView(
      controller: bloc.scrollController,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Grullón ',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'DEV',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const DataInfo(
              title: 'BIENVENIDOS A MI PORTAFOLIO COMO DESARROLLADOR TRAINEE',
              content:
                  'Si quieres ponerte en contacto conmigo escríbeme a mis Redes Sociales',
            ),
            const SizedBox(height: 20),
            DownloadFileButton(
              backgroundColor: Colors.blue,
              buttonText: 'Descargar CV',
              onPressed: () => bloc.downloadFile(context),
            ),
            const SizedBox(height: 20),
            const SocialNetworkIcons(),
            const SizedBox(height: 20),
            TitleWidget(
              title: 'SOBRE MÍ',
              key: bloc.sobreMiKey,
            ),
            const AboutMeWidget(
                content: '\n\nHola, soy Jorge Luis Grullón Marroquín\n\n\n'
                    'Estudiante universitario responsable y puntual, 26 años con conocimientos indispensables para el manejo de hardware y software, '
                    'lenguajes de programación, fundamentos en desarrollo web, manejo de base de datos relacionales y no relaciones, como tambien '
                    'fundamentos en desarrollo movil.',
                secondContent:
                    '\n\nComo profesional, estoy dispuesto a dar lo mejor de mí y puedo adaptarme a cualquier proyecto o tarea que se me asigne.'
                    ' Soy un desarrollador de software con un enfoque versátil en la creación de aplicaciones móviles y web. Mi pasión por la tecnología'
                    ' me ha llevado a especializarme en varias áreas claves del desarrollo.'),
            const SizedBox(height: 20),
            TitleWidget(
              title: 'EDUCACIÓN',
              key: bloc.educacionKey,
            ),
            ...bloc.listEducation.map(
              (it) => EducationWidget(
                title: it['title']!,
                content: it['content']!,
              ),
            ),
            const SizedBox(height: 20),
            TitleWidget(
              title: 'HABILIDADES',
              key: bloc.skillsKey,
            ),
            ...bloc.listSkills.map(
              (skill) {
                final skillName = skill['skill'] as String;
                final skillLevel = skill['level'] as double;

                return SkillBar(
                  skill: skillName,
                  level: skillLevel,
                  color: Colors.yellow,
                );
              },
            ),
            const SizedBox(height: 20),
            TitleWidget(
              title: 'PROYECTOS',
              key: bloc.proyectosKey,
            ),
            const SizedBox(height: 20),
            TitleWidget(
              title: 'CONTACTAME',
              key: bloc.contactameKey,
            ),
            const ContactWidget(),
          ],
        ),
      ),
    );
  }
}
