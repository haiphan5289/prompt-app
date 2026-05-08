# Examples — Prompt Pattern Design

## Core Pattern Library (v1)

The following 7 patterns form the initial library shipped with Prompt App.

---

### PATTERN: `role_expert`

```
NAME: Expert Role
CATEGORY: Role-Based
DESCRIPTION: Assign the AI a domain expert role matching the topic of the user's prompt.
TEMPLATE:
  You are an expert in {{detectedDomain}}.
  {{userInput}}
  Provide a thorough, accurate answer based on best practices.
EXAMPLES:
  1. Input:  "how to fix a memory leak in flutter"
     Output: "You are an expert Flutter engineer. How to fix a memory leak in Flutter?
              Provide a thorough, accurate answer based on best practices."

  2. Input:  "best way to write a resignation letter"
     Output: "You are an expert career coach and professional writer.
              What is the best way to write a resignation letter?
              Provide a thorough, accurate answer based on best practices."

  3. Input:  "explain blockchain"
     Output: "You are an expert in distributed systems and blockchain technology.
              Explain blockchain. Provide a thorough, accurate answer based on best practices."
```

---

### PATTERN: `chain_of_thought`

```
NAME: Step-by-Step Reasoning
CATEGORY: Chain-of-Thought
DESCRIPTION: Force the AI to reason through the problem step by step before giving the final answer.
TEMPLATE:
  {{userInput}}

  Think through this step by step:
  1. First, identify the key components of the problem.
  2. Analyze each component.
  3. Consider potential solutions or answers.
  4. Provide your final, reasoned conclusion.
EXAMPLES:
  1. Input:  "should i use sql or nosql for my app"
     Output: "Should I use SQL or NoSQL for my app? Think through this step by step:
              1. First, identify the key components of the problem.
              2. Analyze each component. ..."

  2. Input:  "debug why my api returns 403"
     Output: "Debug why my API returns 403. Think through this step by step: ..."

  3. Input:  "is it better to learn python or javascript first"
     Output: "Is it better to learn Python or JavaScript first? Think through this step by step: ..."
```

---

### PATTERN: `structured_output`

```
NAME: Structured Output
CATEGORY: Output-Format
DESCRIPTION: Ask the AI to return its answer in a specific, structured format with labeled sections.
TEMPLATE:
  {{userInput}}

  Return your answer in the following structured format:
  **Summary:** (1-2 sentences)
  **Key Points:** (3-5 bullet points)
  **Recommendation:** (1 clear action or conclusion)
  **Caveats:** (any important limitations or exceptions)
EXAMPLES:
  1. Input:  "pros and cons of remote work"
     Output: "Pros and cons of remote work. Return your answer in the following structured format:
              Summary: ... Key Points: ..."

  2. Input:  "compare react vs vue"
     Output: Structured comparison with Summary / Key Points / Recommendation / Caveats sections.

  3. Input:  "should i use tabs or spaces"
     Output: Structured answer with a clear Recommendation section.
```

---

### PATTERN: `risen`

```
NAME: RISEN Framework
CATEGORY: RISEN
DESCRIPTION: Apply the full RISEN framework — Role, Instructions, Steps, End-goal, Narrowing.
TEMPLATE:
  Role: You are a {{role}} with deep expertise in this domain.
  Instructions: {{userInput}}
  Steps: Break your response into clear, logical steps.
  End-goal: The final deliverable should be practical and immediately actionable.
  Narrowing: Focus only on what is directly relevant. Avoid tangents.
EXAMPLES:
  1. Input:  "write a product requirements document"
     Output: "Role: You are a senior product manager...
              Instructions: Write a PRD...
              Steps: Break into clear steps...
              End-goal: Practical and actionable...
              Narrowing: Focus on what's directly relevant."

  2. Input:  "create a study plan for learning machine learning"
     Output: "Role: You are an ML educator..."

  3. Input:  "review this business proposal"
     Output: "Role: You are an experienced business consultant..."
```

---

### PATTERN: `cato`

```
NAME: CATO Framework
CATEGORY: CATO
DESCRIPTION: Apply CATO — Context, Action, Tone, Output. Ideal for content and communication tasks.
TEMPLATE:
  Context: {{inferredContext}}
  Action: {{userInput}}
  Tone: Professional yet approachable. Clear and direct.
  Output: Provide a complete, ready-to-use response. No meta-commentary.
EXAMPLES:
  1. Input:  "write a cold email to a potential client"
     Output: "Context: Business development outreach.
              Action: Write a cold email...
              Tone: Professional...
              Output: Ready-to-use email."

  2. Input:  "write a linkedin post about my promotion"
     Output: "Context: Professional social media announcement..."

  3. Input:  "draft an apology email to a customer"
     Output: "Context: Customer service communication..."
```

---

### PATTERN: `few_shot`

```
NAME: Few-Shot Examples
CATEGORY: Few-Shot
DESCRIPTION: Provide the AI with 2 worked examples in the same format as the user's task, then ask it to do the real one.
TEMPLATE:
  Here are two examples of the task:

  Example 1:
  Input: [example input 1]
  Output: [example output 1]

  Example 2:
  Input: [example input 2]
  Output: [example output 2]

  Now do the same for:
  Input: {{userInput}}
  Output:
EXAMPLES:
  1. Input:  "convert this sentence to past tense: She runs every morning"
     Output: "Example 1: Input: 'He walks to school.' Output: 'He walked to school.'
              Example 2: ...
              Now do the same for: 'She runs every morning.'"

  2. Input:  "summarize this paragraph in one sentence"
     Output: Two example summaries, then the real paragraph.

  3. Input:  "extract the action items from this meeting transcript"
     Output: Two example extractions, then the real transcript.
```

---

### PATTERN: `constrained_expert`

```
NAME: Constrained Expert
CATEGORY: Constraint-Based
DESCRIPTION: Assign an expert role AND add tight constraints on length, audience, and format.
TEMPLATE:
  You are an expert in {{detectedDomain}}.

  Task: {{userInput}}

  Constraints:
  - Answer for a {{audience}} audience (assume {{knowledgeLevel}} knowledge)
  - Maximum length: {{maxLength}}
  - No jargon unless defined
  - Be direct — start with the answer, then explain
EXAMPLES:
  1. Input:  "explain how https works"
     Output: "You are an expert in web security and networking.
              Task: Explain how HTTPS works.
              Constraints: Answer for a general audience (assume beginner knowledge).
              Maximum length: 200 words. No jargon unless defined. Be direct."

  2. Input:  "what is recursion"
     Output: "...for a programming student audience (intermediate knowledge)..."

  3. Input:  "how does compound interest work"
     Output: "...for a personal finance audience (no financial background)..."
```
