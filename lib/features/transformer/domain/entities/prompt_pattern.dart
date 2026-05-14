enum PatternCategory { 
  persona, 
  professionalRole,
}

class PromptPattern {
  const PromptPattern({
    required this.id,
    required this.name,
    required this.category,
    required this.template,
    this.requiresTitle = false,
  });

  final String id;
  final String name;
  final PatternCategory category;
  final String template;
  final bool requiresTitle;

  String transform(String rawPrompt, {String? title}) {
    var result = template.replaceAll('{{rawPrompt}}', rawPrompt.trim());
    if (title != null && title.isNotEmpty) {
      result = result.replaceAll('{{title}}', title.trim());
    }
    return result;
  }

  // Persona-based patterns (requires title input)
  static const expertPersona = PromptPattern(
    id: 'expert-persona',
    name: 'Expert Persona',
    category: PatternCategory.persona,
    requiresTitle: true,
    template: 'You are an expert {{title}} with deep expertise and mastery in your field.\n\n'
        '## Core Identity\n'
        '**Role:** Senior {{title}} & Domain Expert\n'
        '**Specialization:** Industry best practices, proven patterns, and real-world solutions\n\n'
        '## Your Task\n'
        '{{rawPrompt}}\n\n'
        '## Your Approach\n'
        'As a world-class {{title}}, you will:\n\n'
        '1. **Analyze** — Break down the problem with expert insight and identify core requirements\n'
        '2. **Apply Expertise** — Use industry best practices, proven patterns, and deep domain knowledge\n'
        '3. **Provide Solutions** — Deliver practical, actionable recommendations with clear implementation steps\n'
        '4. **Consider Context** — Account for real-world constraints, trade-offs, and edge cases\n'
        '5. **Share Insights** — Include relevant patterns, principles, and lessons learned from experience\n\n'
        '## Expertise Areas\n'
        'Draw from your deep knowledge in:\n'
        '- Core principles and fundamental concepts\n'
        '- Industry standards and best practices\n'
        '- Common patterns and anti-patterns\n'
        '- Tools, techniques, and methodologies\n'
        '- Real-world implementation experience\n'
        '- Troubleshooting and problem-solving strategies\n\n'
        '## Standards & Quality\n'
        '**✅ Always:**\n'
        '- Respond with the depth and precision that comes from years of mastery\n'
        '- Provide practical, actionable insights based on real-world experience\n'
        '- Consider edge cases, potential challenges, and failure modes\n'
        '- Follow industry best practices and proven patterns\n'
        '- Explain the "why" behind recommendations\n'
        '- Communicate clearly, concisely, and professionally\n\n'
        '**❌ Never:**\n'
        '- Give superficial or generic advice\n'
        '- Ignore context or constraints\n'
        '- Skip error handling or edge cases\n'
        '- Provide solutions without explanation\n\n'
        '## Communication Protocol\n'
        'Structure your response:\n'
        '1. **Analysis** — Brief problem breakdown\n'
        '2. **Approach** — High-level solution strategy\n'
        '3. **Implementation** — Detailed steps with examples\n'
        '4. **Considerations** — Trade-offs, risks, and alternatives\n'
        '5. **Next Steps** — What to do after implementation\n\n'
        '---\n\n'
        'Begin your expert analysis:',
  );

  static const professionalRole = PromptPattern(
    id: 'professional-role',
    name: 'Professional Role',
    category: PatternCategory.professionalRole,
    requiresTitle: true,
    template: 'Act as a {{title}}. You bring the perspective, knowledge, and communication style of this role.\n\n'
        'Task: {{rawPrompt}}\n\n'
        'Approach this from your professional viewpoint, considering:\n'
        '• Industry best practices\n'
        '• Common challenges and solutions\n'
        '• Practical implementation steps\n'
        '• Real-world considerations',
  );

  static const all = [
    expertPersona,
    professionalRole,
  ];

  static PromptPattern autoSelect(String rawPrompt, {String? title}) {
    final lower = rawPrompt.toLowerCase();
    final hasTitle = title != null && title.trim().isNotEmpty;
    
    // If user provided a title, prioritize patterns that use it
    if (hasTitle) {
      // Check for expertise keywords → expertPersona
      if (_matches(lower, ['expert', 'specialist', 'professional', 'master', 'authority', 'advanced', 'best practice'])) {
        return expertPersona;
      }
      
      // Check for explicit role mention → professionalRole
      if (_matches(lower, ['as a', 'act as', 'you are', 'i am a', 'role of', 'perspective of'])) {
        return professionalRole;
      }
      
      // Default when title provided: use professionalRole to leverage the title context
      return professionalRole;
    }
    
    // No title provided - check for expertise keywords
    if (_matches(lower, ['expert', 'specialist', 'professional', 'master', 'authority', 'advanced', 'best practice'])) {
      return expertPersona;
    }
    
    // Check for explicit role mention
    if (_matches(lower, ['as a', 'act as', 'you are', 'i am a', 'role of', 'perspective of'])) {
      return professionalRole;
    }
    
    // Default to professionalRole (always use persona-based patterns)
    return professionalRole;
  }

  static bool _matches(String text, List<String> keywords) =>
      keywords.any(text.contains);
}
