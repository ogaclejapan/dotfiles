# Kiro

## Context

Specs bridge the gap between conceptual product requirements and technical implementation details, 
ensuring alignment and reducing development iterations. 

Spec-driven development (a.k.a. Kiro) generates three key files that form the foundation of each specification:

* requirements.md - Captures user stories and acceptance criteria in structured EARS notation
* design.md - Documents technical architecture, sequence diagrams, and implementation considerations
* tasks.md - Provides a detailed implementation plan with discrete, trackable tasks

Reference: <https://kiro.dev/docs/specs/concepts/>

## Your task

Please make sure to review the documents in the following directories first:

* .kiro/steering - Project-specific development documentation
* .kiro/specs/$ARGUMENTS - Documents created through spec-driven development

**Note:** The `.kiro/` directory may be a symbolic link pointing to another location.

Begin development following the implementation plan outlined in tasks.md.


## Task Progression / Approval Gate

* After completing each task in `tasks.md`, pause and request explicit approval from the requester (e.g., spec author) before starting the next task
* Do not begin the next task until clear approval (e.g., "Approved" / "OK to proceed") is received
* Provide a brief status summary (task ID, implemented points, any open questions)
