enum Period { manha, dia, noite }

class TaskChoice {
  final String audioId;
  final String label;
  final String emoji;
  final String reaction;

  const TaskChoice({required this.audioId, required this.label, required this.emoji, required this.reaction});
}

class TaskStep {
  final String audioId;
  final String emoji;
  final String text;
  final List<TaskChoice>? choices;

  const TaskStep({required this.audioId, required this.emoji, required this.text, this.choices});
}

class RoutineTaskDef {
  final String id;
  final String label;
  final String emoji;
  final Period period;
  final List<TaskStep> steps;

  const RoutineTaskDef({
    required this.id,
    required this.label,
    required this.emoji,
    required this.period,
    required this.steps,
  });
}

const _escovarDentesSteps = [
  TaskStep(audioId: 'escovar_0', emoji: '🚰', text: 'Molhe a escovinha na torneira.'),
  TaskStep(audioId: 'escovar_1', emoji: '🪥', text: 'Coloque uma bolinha pequena de pasta de dente.'),
  TaskStep(audioId: 'escovar_2', emoji: '😁', text: 'Escove os dentes de cima, fazendo círculos.'),
  TaskStep(audioId: 'escovar_3', emoji: '😬', text: 'Agora escove os dentes de baixo, com carinho.'),
  TaskStep(audioId: 'escovar_4', emoji: '💧', text: 'Enxágue a boca com água. Prontinho!'),
];

const List<RoutineTaskDef> kDefaultTasks = [
  RoutineTaskDef(
    id: 'acordar',
    label: 'Acordar e se espreguiçar',
    emoji: '🌅',
    period: Period.manha,
    steps: [
      TaskStep(audioId: 'acordar_0', emoji: '👀', text: 'Hora de acordar! Abra os olhinhos devagar.'),
      TaskStep(audioId: 'acordar_1', emoji: '🙆', text: 'Espreguice bem os bracinhos e as perninhas.'),
      TaskStep(audioId: 'acordar_2', emoji: '😊', text: 'Dê um sorriso grande pro novo dia!'),
    ],
  ),
  RoutineTaskDef(
    id: 'escovar_manha',
    label: 'Escovar os dentes',
    emoji: '🪥',
    period: Period.manha,
    steps: _escovarDentesSteps,
  ),
  RoutineTaskDef(
    id: 'cafe',
    label: 'Tomar café da manhã',
    emoji: '🥣',
    period: Period.manha,
    steps: [
      TaskStep(
        audioId: 'cafe_0',
        emoji: '🥣',
        text: 'O que você vai tomar hoje no café da manhã?',
        choices: [
          TaskChoice(audioId: 'cafe_choice_leite', label: 'Leite', emoji: '🥛', reaction: 'Leite é ótimo pra ficar forte e crescer!'),
          TaskChoice(audioId: 'cafe_choice_suco', label: 'Suco', emoji: '🧃', reaction: 'Que delícia, suco dá uma energia boa pro dia!'),
          TaskChoice(audioId: 'cafe_choice_vitamina', label: 'Vitamina', emoji: '🥤', reaction: 'Vitamina é supersaudável, adorei essa escolha!'),
        ],
      ),
      TaskStep(audioId: 'cafe_1', emoji: '🪑', text: 'Sente-se direitinho à mesa.'),
      TaskStep(audioId: 'cafe_2', emoji: '🥄', text: 'Coma um pouquinho de cada vez, com calma.'),
      TaskStep(audioId: 'cafe_3', emoji: '🧽', text: 'Depois de comer, limpe a boca com o guardanapo.'),
    ],
  ),
  RoutineTaskDef(
    id: 'vestir',
    label: 'Se vestir sozinho(a)',
    emoji: '👕',
    period: Period.manha,
    steps: [
      TaskStep(audioId: 'vestir_0', emoji: '👚', text: 'Escolha a roupa que vai usar hoje.'),
      TaskStep(audioId: 'vestir_1', emoji: '👕', text: 'Coloque a camiseta, primeiro a cabeça.'),
      TaskStep(audioId: 'vestir_2', emoji: '💪', text: 'Agora os bracinhos, um de cada vez.'),
      TaskStep(audioId: 'vestir_3', emoji: '👖', text: 'Vista a calça ou o short, uma perna de cada vez.'),
      TaskStep(audioId: 'vestir_4', emoji: '🎉', text: 'Prontinho, você se vestiu sozinho!'),
    ],
  ),
  RoutineTaskDef(
    id: 'lavar_maos',
    label: 'Lavar as mãos antes de comer',
    emoji: '🧼',
    period: Period.dia,
    steps: [
      TaskStep(audioId: 'lavar_maos_0', emoji: '🚰', text: 'Molhe as mãozinhas na água.'),
      TaskStep(audioId: 'lavar_maos_1', emoji: '🧼', text: 'Passe o sabonete e esfregue bem.'),
      TaskStep(audioId: 'lavar_maos_2', emoji: '🤲', text: 'Não esqueça de esfregar entre os dedinhos!'),
      TaskStep(audioId: 'lavar_maos_3', emoji: '🧻', text: 'Enxágue e seque as mãos na toalha.'),
    ],
  ),
  RoutineTaskDef(
    id: 'guardar_brinquedos',
    label: 'Guardar os brinquedos',
    emoji: '🧸',
    period: Period.dia,
    steps: [
      TaskStep(audioId: 'guardar_brinquedos_0', emoji: '🧸', text: 'Hora de arrumar os brinquedos!'),
      TaskStep(audioId: 'guardar_brinquedos_1', emoji: '🖐️', text: 'Pegue um brinquedo de cada vez.'),
      TaskStep(audioId: 'guardar_brinquedos_2', emoji: '📦', text: 'Coloque cada um no seu lugar certinho.'),
      TaskStep(audioId: 'guardar_brinquedos_3', emoji: '✨', text: 'Muito bem, o quarto ficou arrumado!'),
    ],
  ),
  RoutineTaskDef(
    id: 'banheiro',
    label: 'Ir ao banheiro sozinho(a)',
    emoji: '🚽',
    period: Period.dia,
    steps: [
      TaskStep(audioId: 'banheiro_0', emoji: '🚪', text: 'Vá até o banheiro.'),
      TaskStep(audioId: 'banheiro_1', emoji: '🩲', text: 'Abaixe a roupinha com cuidado.'),
      TaskStep(audioId: 'banheiro_2', emoji: '🚽', text: 'Depois de terminar, dê descarga.'),
      TaskStep(audioId: 'banheiro_3', emoji: '🧼', text: 'Lave bem as mãos com sabonete.'),
    ],
  ),
  RoutineTaskDef(
    id: 'banho',
    label: 'Tomar banho',
    emoji: '🛁',
    period: Period.noite,
    steps: [
      TaskStep(audioId: 'banho_0', emoji: '🚿', text: 'Entre no banho com cuidado.'),
      TaskStep(audioId: 'banho_1', emoji: '💦', text: 'Molhe todo o corpinho.'),
      TaskStep(audioId: 'banho_2', emoji: '🧼', text: 'Passe o sabonete e esfregue bem.'),
      TaskStep(audioId: 'banho_3', emoji: '🧴', text: 'Lave o cabelo com shampoo.'),
      TaskStep(audioId: 'banho_4', emoji: '🧻', text: 'Enxágue tudo e seque-se com a toalha.'),
    ],
  ),
  RoutineTaskDef(
    id: 'jantar',
    label: 'Jantar',
    emoji: '🍽️',
    period: Period.noite,
    steps: [
      TaskStep(audioId: 'jantar_0', emoji: '🪑', text: 'Sente-se à mesa para jantar.'),
      TaskStep(audioId: 'jantar_1', emoji: '🍽️', text: 'Coma um pouquinho de cada coisa.'),
      TaskStep(audioId: 'jantar_2', emoji: '🥄', text: 'Use o garfo ou a colher com calma.'),
      TaskStep(audioId: 'jantar_3', emoji: '😋', text: 'Depois de comer, agradeça e limpe a boca.'),
    ],
  ),
  RoutineTaskDef(
    id: 'escovar_noite',
    label: 'Escovar os dentes de novo',
    emoji: '🪥',
    period: Period.noite,
    steps: _escovarDentesSteps,
  ),
  RoutineTaskDef(
    id: 'pijama',
    label: 'Vestir o pijama',
    emoji: '🌙',
    period: Period.noite,
    steps: [
      TaskStep(audioId: 'pijama_0', emoji: '🌙', text: 'Escolha o pijama pra dormir.'),
      TaskStep(audioId: 'pijama_1', emoji: '👕', text: 'Tire a roupa do dia.'),
      TaskStep(audioId: 'pijama_2', emoji: '🩳', text: 'Vista o pijama, com calma.'),
      TaskStep(audioId: 'pijama_3', emoji: '😴', text: 'Agora você está pronto pra dormir!'),
    ],
  ),
  RoutineTaskDef(
    id: 'dormir',
    label: 'Hora de dormir',
    emoji: '😴',
    period: Period.noite,
    steps: [
      TaskStep(audioId: 'dormir_0', emoji: '🛏️', text: 'Deite-se na sua caminha.'),
      TaskStep(audioId: 'dormir_1', emoji: '🤗', text: 'Dê boa noite pra família.'),
      TaskStep(audioId: 'dormir_2', emoji: '😌', text: 'Feche os olhinhos e respire devagar.'),
      TaskStep(audioId: 'dormir_3', emoji: '⭐', text: 'Durma bem, amanhã tem mais aventuras!'),
    ],
  ),
];

String periodLabel(Period p) {
  switch (p) {
    case Period.manha:
      return 'Manhã';
    case Period.dia:
      return 'Dia';
    case Period.noite:
      return 'Noite';
  }
}
