import 'package:flutter/material.dart';

// Ponto de entrada do aplicativo. O Flutter começa a execução por aqui e
// entrega a interface para a classe principal UniEventosApp.
void main() {
  runApp(const UniEventosApp());
}

// Enum usado para representar os três tipos de evento pedidos na atividade.
// Além do nome exibido na tela, deixei um ícone junto para manter a identidade
// visual consistente em cards, imagens de fallback e detalhes.
enum TipoEvento {
  palestra('Palestra', Icons.mic),
  workshop('Workshop', Icons.handyman),
  hackathon('Hackathon', Icons.code);

  final String nome;
  final IconData icone;

  const TipoEvento(this.nome, this.icone);
}

// Modelo principal da atividade. A classe guarda os dados que precisam aparecer
// tanto na lista quanto na tela de detalhes.
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

  // Construtor nomeado para palestra. Ele evita repetir a categoria toda vez
  // que um evento desse tipo é criado.
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

  // Construtor nomeado para workshop. Segue a mesma ideia: o tipo já nasce
  // correto, deixando o mock mais legível.
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

  // Construtor nomeado para hackathon, fechando os três tipos de evento do
  // cenário proposto pela universidade.
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

// Classe principal do app. Aqui ficam o MaterialApp, as rotas nomeadas e o tema
// universitário, que são pontos avaliados no trabalho.
class UniEventosApp extends StatelessWidget {
  const UniEventosApp({super.key});

  static const rotaPrincipal = '/';
  static const rotaDetalhes = '/detalhes';

  // Azul mais sóbrio para dar cara de sistema acadêmico/universitário.
  static const azulUniversitario = Color(0xFF0B3D91);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniEventos',
      debugShowCheckedModeBanner: false,
      initialRoute: rotaPrincipal,
      // Rotas nomeadas: a lista abre em "/" e a tela de detalhes em
      // "/detalhes", exatamente como o enunciado pede.
      routes: {
        rotaPrincipal: (context) => const TelaPrincipal(),
        rotaDetalhes: (context) => const TelaDetalhesEvento(),
      },
      // O ThemeData centraliza a identidade visual para o app não parecer uma
      // coleção de telas soltas. Se mudar a cor aqui, o app inteiro acompanha.
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

// Repositório simples para concentrar a criação dos dados de teste.
// Em um app real ele poderia buscar de uma API, mas na atividade o mock com
// List.generate é suficiente e ajuda a testar performance com muitos itens.
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

  // Gera 50 eventos, como pedido no desafio da Fase 1.
  List<Evento> listarEventos() {
    return List.generate(totalEventos, _criarEvento);
  }

  // Cada índice vira um evento diferente. O uso de módulo (%) alterna entre
  // palestra, workshop e hackathon sem precisar escrever 50 objetos à mão.
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

// Tela inicial do aplicativo. É Stateful porque ela precisa guardar estados
// simples da interface: eventos favoritados e filtro de favoritos.
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
    // A lista é criada uma vez no ciclo de vida da tela. Isso evita recriar os
    // 50 eventos a cada build e deixa a rolagem mais estável.
    _eventos = _repository.listarEventos();
  }

  void _alternarFavorito(int eventoId) {
    // setState avisa o Flutter que a cor/ícone do coração precisa atualizar.
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
    // Quando o switch de favoritos está ligado, mostramos apenas os eventos
    // que estão no Set. O Set foi escolhido porque a busca por id é rápida.
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
                // Switch.adaptive cumpre o requisito de widget adaptativo:
                // ele tenta respeitar o estilo de cada plataforma.
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
                    // ListView.builder é a escolha performática para centenas
                    // de eventos, pois constrói os cards sob demanda.
                    itemCount: eventosVisiveis.length,
                    itemBuilder: (context, index) {
                      final evento = eventosVisiveis[index];
                      final favoritado = _favoritos.contains(evento.id);

                      return EventoCard(
                        evento: evento,
                        favoritado: favoritado,
                        onFavoritar: () => _alternarFavorito(evento.id),
                        onAbrirDetalhes: () {
                          // O objeto Evento inteiro é enviado como argumento
                          // para garantir consistência na tela de detalhes.
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

// Card de cada evento no catálogo. Ele junta o Card + ListTile exigidos na
// atividade e deixa claro onde estão título, tipo, data, local e favorito.
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
          // O coração muda entre preenchido e vazado conforme o estado salvo
          // na TelaPrincipal.
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

// Miniatura do evento dentro do card. Usei Stack para sobrepor o ícone da
// categoria na imagem, deixando a lista mais visual sem pesar a navegação.
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
              // Se a imagem da internet falhar, o app continua bonito e
              // funcional com um bloco colorido e o ícone da categoria.
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

// Tela de detalhes. Ela recebe o Evento pela rota nomeada e exibe os mesmos
// dados do card com mais espaço, mantendo a consistência pedida na avaliação.
class TelaDetalhesEvento extends StatelessWidget {
  const TelaDetalhesEvento({super.key});

  @override
  Widget build(BuildContext context) {
    // Extração do argumento enviado pelo Navigator.pushNamed.
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

// Cabeçalho visual da tela de detalhes. O Stack cria a sobreposição de imagem,
// degradê e textos, mostrando o uso de layout mais complexo da atividade.
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

// Pequeno bloco reutilizável para informações importantes do evento, como data
// e local. O Container dá destaque sem virar uma tela poluída.
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

// Formulário de inscrição rápida. Ele é Stateful porque os TextEditingController
// e o Switch têm ciclo de vida próprio e precisam ser descartados corretamente.
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
    // Boa prática importante: liberar controllers evita vazamento de memória.
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _confirmarInscricao() {
    // A GlobalKey permite chamar validate() no formulário inteiro.
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
              // Nome é obrigatório, como especificado no enunciado.
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
              // O trabalho pede uma validação simples: o e-mail precisa conter
              // "@". Mantive exatamente essa regra.
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
                  // Outro uso de widget adaptativo, agora dentro do formulário.
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
