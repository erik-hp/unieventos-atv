import 'package:flutter/material.dart';

class InscricaoForm extends StatefulWidget {
  final ValueChanged<InscricaoDados> onInscricaoValida;

  const InscricaoForm({super.key, required this.onInscricaoValida});

  @override
  State<InscricaoForm> createState() => _InscricaoFormState();
}

class _InscricaoFormState extends State<InscricaoForm> {
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

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      widget.onInscricaoValida(
        InscricaoDados(
          nome: _nomeController.text.trim(),
          email: _emailController.text.trim(),
          receberLembrete: _receberLembrete,
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
              onPressed: _enviar,
            ),
          ),
        ],
      ),
    );
  }
}

class InscricaoDados {
  final String nome;
  final String email;
  final bool receberLembrete;

  const InscricaoDados({
    required this.nome,
    required this.email,
    required this.receberLembrete,
  });
}
