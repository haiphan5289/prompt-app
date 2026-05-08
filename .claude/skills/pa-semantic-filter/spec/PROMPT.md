# Prompt — pa-semantic-filter

Step-by-step execution workflow for semantic filtering.

## Step 1: Identify Sensitive Content

Read the entire input document. For each sentence or bullet point, classify it as either:
- **KEEP** — it contains technical requirements (user stories, functional requirements, UI/UX specs, acceptance criteria, API contracts, error handling, performance constraints, prompt pattern requirements)
- **STRIP** — it contains sensitive business data (see INPUT_SCHEMA.md "What to Remove" table)

When a paragraph mixes both, extract and keep the technical portions and strip the sensitive portions.

## Step 2: Reconstruct as Filtered Spec

Reassemble the kept content into the structured output format (see OUTPUT_SCHEMA.md). Do not paraphrase or alter the technical requirements — preserve the original wording.

## Step 3: Write the "Removed" summary

At the bottom of the output, add a brief one-line note listing the categories that were stripped (e.g., "revenue targets, release dates, competitive references"). Do not quote or reproduce any of the stripped content.

## Step 4: Add "Safe to pass to" line

State which downstream skills this filtered spec can be safely passed to:
```
Safe to pass to: pa-feature-pipeline, pa-ai-document, pa-chain-of-thought
```
