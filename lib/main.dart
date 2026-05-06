import 'package:flutter/material.dart';

void main() {
  runApp(const UniEventosApp());
}

enum TipoEvento {
  palestra('Palestra', Icons.mic),
  workshop('Workshop', Icons.handyman),
  hackathon('Hackathon', Icons.code);

  final String nome;
  final IconData icone;

  const TipoEvento(this.nome, this.icone);
}

class Evento {
  final int id;
  final String titulo;
  final String data;
  final String local;
  final String descricao;
  final String imagemUrl;
  final TipoEvento tipo;

  const Evento({
    required this.id,
    required this.titulo,
    required this.data,
    required this.local,
    required this.descricao,
    required this.imagemUrl,
    required this.tipo,
  });

  Evento.palestra({
    required int id,
    required String titulo,
    required String data,
    required String local,
    required String descricao,
    required String imagemUrl,
  }) : this(
         id: id,
         titulo: titulo,
         data: data,
         local: local,
         descricao: descricao,
         imagemUrl: imagemUrl,
         tipo: TipoEvento.palestra,
       );

  Evento.workshop({
    required int id,
    required String titulo,
    required String data,
    required String local,
    required String descricao,
    required String imagemUrl,
  }) : this(
         id: id,
         titulo: titulo,
         data: data,
         local: local,
         descricao: descricao,
         imagemUrl: imagemUrl,
         tipo: TipoEvento.workshop,
       );

  Evento.hackathon({
    required int id,
    required String titulo,
    required String data,
    required String local,
    required String descricao,
    required String imagemUrl,
  }) : this(
         id: id,
         titulo: titulo,
         data: data,
         local: local,
         descricao: descricao,
         imagemUrl: imagemUrl,
         tipo: TipoEvento.hackathon,
       );
}

class UniEventosApp extends StatelessWidget {
  const UniEventosApp({super.key});

  static const rotaPrincipal = '/';
  static const rotaDetalhes = '/detalhes';
  static const azulUniversitario = Color(0xFF0B3D91);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniEventos',
      debugShowCheckedModeBanner: false,
      initialRoute: rotaPrincipal,
      routes: {
        rotaPrincipal: (context) => const TelaPrincipal(),
        rotaDetalhes: (context) => const TelaDetalhesEvento(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: azulUniversitario,
          primary: azulUniversitario,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: azulUniversitario,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class EventoRepository {
  static const totalEventos = 50;
  static const _locais = [
    'Auditório Central',
    'Laboratório de Inovação',
    'Biblioteca Universitária',
    'Sala Maker',
    'Centro de Convenções',
  ];

  const EventoRepository();

  List<Evento> listarEventos() {
    return List.generate(totalEventos, _criarEvento);
  }

  Evento _criarEvento(int index) {
    final id = index + 1;
    final dia = (index % 28) + 1;
    final mes = 5 + (index % 4);
    final data =
        '${dia.toString().padLeft(2, '0')}/'
        '${mes.toString().padLeft(2, '0')}/2026 - ${14 + (index % 6)}h';
    final local = _locais[index % _locais.length];
    final imagemUrl = 'https://picsum.photos/seed/unieventos-$id/900/500';

    switch (index % 3) {
      case 0:
        return Evento.palestra(
          id: id,
          titulo: 'Palestra Acadêmica $id',
          data: data,
          local: local,
          imagemUrl: imagemUrl,
          descricao:
              'Encontro com especialistas para discutir pesquisa, carreira acadêmica e inovação na universidade.',
        );
      case 1:
        return Evento.workshop(
          id: id,
          titulo: 'Workshop Prático $id',
          data: data,
          local: local,
          imagemUrl: imagemUrl,
          descricao:
              'Atividade prática com exercícios guiados, monitores e aplicação direta dos conteúdos estudados.',
        );
      default:
        return Evento.hackathon(
          id: id,
          titulo: 'Hackathon Universitário $id',
          data: data,
          local: local,
          imagemUrl: imagemUrl,
          descricao:
              'Maratona colaborativa para criação de soluções digitais com equipes multidisciplinares.',
        );
    }
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final _repository = const EventoRepository();
  final Set<int> _favoritos = {};

  late final List<Evento> _eventos;
  bool _mostrarSomenteFavoritos = false;

  @override
  void initState() {
    super.initState();
    _eventos = _repository.listarEventos();
  }

  void _alternarFavorito(int eventoId) {
    setState(() {
      if (_favoritos.contains(eventoId)) {
        _favoritos.remove(eventoId);
      } else {
        _favoritos.add(eventoId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventosVisiveis = _mostrarSomenteFavoritos
        ? _eventos.where((evento) => _favoritos.contains(evento.id)).toList()
        : _eventos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UniEventos'),
        actions: [
          Row(
            children: [
              const Icon(Icons.favorite, size: 18),
              Switch.adaptive(
                value: _mostrarSomenteFavoritos,
                activeThumbColor: Colors.white,
                onChanged: (valor) {
                  setState(() {
                    _mostrarSomenteFavoritos = valor;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.school, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eventos acadêmicos disponíveis',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text('${eventosVisiveis.length} eventos no catálogo'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: eventosVisiveis.isEmpty
                ? const Center(
                    child: Text('Nenhum evento favoritado no momento.'),
                  )
                : ListView.builder(
                    itemCount: eventosVisiveis.length,
                    itemBuilder: (context, index) {
                      final evento = eventosVisiveis[index];
                      final favoritado = _favoritos.contains(evento.id);

                      return EventoCard(
                        evento: evento,
                        favoritado: favoritado,
                        onFavoritar: () => _alternarFavorito(evento.id),
                        onAbrirDetalhes: () {
                          Navigator.pushNamed(
                            context,
                            UniEventosApp.rotaDetalhes,
                            arguments: evento,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class EventoCard extends StatelessWidget {
  final Evento evento;
  final bool favoritado;
  final VoidCallback onFavoritar;
  final VoidCallback onAbrirDetalhes;

  const EventoCard({
    super.key,
    required this.evento,
    required this.favoritado,
    required this.onFavoritar,
    required this.onAbrirDetalhes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: EventoMiniatura(evento: evento),
        title: Text(
          evento.titulo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${evento.tipo.nome} • ${evento.data}'),
            Text(evento.local, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: IconButton(
          tooltip: favoritado ? 'Remover dos favoritos' : 'Favoritar evento',
          icon: Icon(
            favoritado ? Icons.favorite : Icons.favorite_border,
            color: favoritado ? Colors.red : Colors.grey,
          ),
          onPressed: onFavoritar,
        ),
        onTap: onAbrirDetalhes,
      ),
    );
  }
}

class EventoMiniatura extends StatelessWidget {
  final Evento evento;

  const EventoMiniatura({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            evento.imagemUrl,
            width: 58,
            height: 58,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 58,
                height: 58,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  evento.tipo.icone,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(evento.tipo.icone, size: 13, color: Colors.white),
        ),
      ],
    );
  }
}

class TelaDetalhesEvento extends StatelessWidget {
  const TelaDetalhesEvento({super.key});

  @override
  Widget build(BuildContext context) {
    final evento = ModalRoute.of(context)!.settings.arguments as Evento;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Evento')),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          EventoHero(evento: evento),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: EventoInfoCard(
                        icon: Icons.calendar_month,
                        titulo: 'Data',
                        valor: evento.data,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: EventoInfoCard(
                        icon: Icons.location_on,
                        titulo: 'Local',
                        valor: evento.local,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Descrição',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(evento.descricao),
                const SizedBox(height: 24),
                Text(
                  'Inscrição rápida',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                FormularioInscricao(evento: evento),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventoHero extends StatelessWidget {
  final Evento evento;

  const EventoHero({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          evento.imagemUrl,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 220,
              width: double.infinity,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                evento.tipo.icone,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          },
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.72),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  evento.tipo.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                evento.titulo,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EventoInfoCard extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String valor;

  const EventoInfoCard({
    super.key,
    required this.icon,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 92),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(titulo, style: Theme.of(context).textTheme.labelMedium),
          Text(
            valor,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class FormularioInscricao extends StatefulWidget {
  final Evento evento;

  const FormularioInscricao({super.key, required this.evento});

  @override
  State<FormularioInscricao> createState() => _FormularioInscricaoState();
}

class _FormularioInscricaoState extends State<FormularioInscricao> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  bool _receberLembrete = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _confirmarInscricao() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Inscrição realizada em ${widget.evento.titulo}!'),
          backgroundColor: Colors.green,
        ),
      );
      _nomeController.clear();
      _emailController.clear();
      setState(() {
        _receberLembrete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              prefixIcon: Icon(Icons.person),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Informe seu nome.';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'E-mail',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              final email = value?.trim() ?? '';
              if (email.isEmpty) {
                return 'Informe seu e-mail.';
              }
              if (!email.contains('@')) {
                return 'Informe um e-mail válido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_active),
                const SizedBox(width: 10),
                const Expanded(child: Text('Receber lembrete do evento')),
                Switch.adaptive(
                  value: _receberLembrete,
                  onChanged: (value) {
                    setState(() {
                      _receberLembrete = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              icon: const Icon(Icons.how_to_reg),
              label: const Text('Confirmar inscrição'),
              onPressed: _confirmarInscricao,
            ),
          ),
        ],
      ),
    );
  }
}
