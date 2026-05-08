enum PatternCategory { roleBased, chainOfThought, fewShot, risen, cato }

class PromptPattern {
  const PromptPattern({
    required this.id,
    required this.name,
    required this.category,
    required this.template,
  });

  final String id;
  final String name;
  final PatternCategory category;
  final String template;

  String transform(String rawPrompt) =>
      template.replaceAll('{{rawPrompt}}', rawPrompt.trim());

  static const roleBased = PromptPattern(
    id: 'role-based',
    name: 'Role-based',
    category: PatternCategory.roleBased,
    template: 'You are a world-class expert in the domain most relevant to this task. '
        'Respond with the depth, precision, and authority of that expert.\n\n'
        'Task: {{rawPrompt}}',
  );

  static const chainOfThought = PromptPattern(
    id: 'chain-of-thought',
    name: 'Chain of Thought',
    category: PatternCategory.chainOfThought,
    template: 'Think through this step-by-step, showing your reasoning at each stage '
        'before giving a final answer.\n\n'
        'Question: {{rawPrompt}}\n\n'
        "Let's work through this carefully:",
  );

  static const fewShot = PromptPattern(
    id: 'few-shot',
    name: 'Few-Shot',
    category: PatternCategory.fewShot,
    template: 'Here are examples of high-quality responses, followed by a new request.\n\n'
        'Request: {{rawPrompt}}\n\n'
        'Provide 2–3 concrete examples first, then give a comprehensive answer.',
  );

  static const risen = PromptPattern(
    id: 'risen',
    name: 'RISEN',
    category: PatternCategory.risen,
    template: 'Role: Act as a specialist in the most relevant field.\n'
        'Instructions: {{rawPrompt}}\n'
        'Steps: Break this into clear, actionable steps.\n'
        'End goal: Provide a complete, implementable solution.\n'
        'Narrowing: Focus only on what matters most.',
  );

  static const cato = PromptPattern(
    id: 'cato',
    name: 'CATO',
    category: PatternCategory.cato,
    template: 'Context: You are helping with the following: {{rawPrompt}}\n'
        'Action: Provide a clear, structured response.\n'
        'Target: Address all aspects of the request.\n'
        'Output: Format your response for maximum clarity and usefulness.',
  );

  static const all = [roleBased, chainOfThought, fewShot, risen, cato];

  static PromptPattern autoSelect(String rawPrompt) {
    final lower = rawPrompt.toLowerCase();
    if (_matches(lower, ['step', 'how', 'explain', 'why', 'process', 'guide', 'work'])) {
      return chainOfThought;
    }
    if (_matches(lower, ['example', 'like', 'similar', 'compare', 'instance'])) {
      return fewShot;
    }
    if (_matches(lower, ['expert', 'as a', 'act as', 'you are', 'role', 'specialist'])) {
      return roleBased;
    }
    if (_matches(lower, ['goal', 'achieve', 'improve', 'plan', 'result', 'strategy'])) {
      return risen;
    }
    return cato;
  }

  static bool _matches(String text, List<String> keywords) =>
      keywords.any(text.contains);
}
