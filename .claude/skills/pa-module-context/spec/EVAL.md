# Quality Checklist — pa-module-context

## Accuracy
- [ ] 1. Every file path listed has been verified to exist with `find` or `ls`
- [ ] 2. Every class name listed has been verified with `grep -rn "class <Name>"`
- [ ] 3. Every provider name listed has been verified in `lib/core/di/providers.dart`
- [ ] 4. No invented file paths or class names

## Completeness
- [ ] 5. Requested feature's full folder structure shown (all 3 layers: presentation/domain/data)
- [ ] 6. Key providers table populated with at least the primary Notifier provider
- [ ] 7. Key entities table populated with entity name, location, and key fields
- [ ] 8. Naming convention table included in output

## Task Relevance
- [ ] 9. Task-specific "start by reading" section included when TASK is provided
- [ ] 10. "Start by reading" files are ordered by dependency (most foundational first)
- [ ] 11. Generated names for the TASK follow the naming convention table

## Output Format
- [ ] 12. Folder structure uses tree format (not flat list)
- [ ] 13. Provider table includes Type column (AsyncNotifier / Provider / StateProvider)
- [ ] 14. All file references use full paths from `lib/` root
- [ ] 15. No TODO or placeholder entries in the output
