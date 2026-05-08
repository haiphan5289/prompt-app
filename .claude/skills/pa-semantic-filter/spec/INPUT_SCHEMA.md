# Input Schema — pa-semantic-filter

## Parameters

| Param | Type | Required | Description |
|---|---|---|---|
| Raw text | string | yes | The full feature request, PRD, or ticket body to be filtered |

The input is free-form text. No structured key-value pairs are required — paste the raw document directly.

## What to Remove

| Category | Examples |
|---|---|
| Revenue / monetization targets | "We expect 20% conversion lift", "target $50K MRR" |
| Competitive intelligence | "better than ChatGPT", "to compete with Jasper" |
| Internal metrics / OKRs | "DAU target: 10K", "retention goal: 40%" |
| User research raw data | Interview quotes, survey results with PII |
| Roadmap / release dates | "Launch Q3", "ship before [competitor]" |
| Legal / compliance notes | "per legal review on 2024-01-15" |
| Personnel info | "approved by [name]", "owned by [team]" |

## What to Preserve

| Category | Keep because |
|---|---|
| User stories | Defines what to build |
| Functional requirements | Defines how it should work |
| UI/UX specifications | Defines how it should look |
| Acceptance criteria | Defines when it's done |
| API contracts / data models | Defines technical interface |
| Error handling rules | Defines failure behavior |
| Performance constraints | Defines non-functional requirements |
| Prompt pattern requirements | Core domain of this app |
