import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portafolio_yasmin/features/portfolio/presentation/bloc/portafolio_bloc.dart';
import 'package:portafolio_yasmin/utils/custom_icon.dart';

class SocialNetworkIcons extends StatelessWidget {
  const SocialNetworkIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PortfolioBloc>();

    return Row(
      children: [
        IconButton(
          icon: const CustomIcon(path: 'instagram', ext: 'png'),
          onPressed: () => bloc.laucherUrl(bloc.socialLinks['instagram']!),
        ),
        IconButton(
          icon: const CustomIcon(path: 'linkedin', ext: 'png'),
          onPressed: () => bloc.laucherUrl(bloc.socialLinks['linkedin']!),
        ),
        IconButton(
          icon: const CustomIcon(path: 'facebook', ext: 'png'),
          onPressed: () => bloc.laucherUrl(bloc.socialLinks['facebook']!),
        ),
        IconButton(
          icon: const CustomIcon(path: 'whatsapp', ext: 'png'),
          onPressed: () => bloc.laucherUrl(bloc.socialLinks['whatsapp']!),
        ),
        IconButton(
          icon: const CustomIcon(path: 'youtube', ext: 'png'),
          onPressed: () => bloc.laucherUrl(bloc.socialLinks['youtube']!),
        ),
        IconButton(
          icon: const CustomIcon(path: 'x', ext: 'png'),
          onPressed: () => bloc.laucherUrl(bloc.socialLinks['x']!),
        ),
      ],
    );
  }
}
