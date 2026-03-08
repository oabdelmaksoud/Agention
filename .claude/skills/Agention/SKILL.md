# Agention Development Patterns

> Auto-generated skill from repository analysis

## Overview

Agention is a Python-based agent orchestration platform that focuses on skill integration, quality enforcement, and upstream repository synchronization. The codebase emphasizes modular skill architecture with standardized SKILL.md files, bridge integrations for external repositories, and comprehensive quality gates. The project maintains strong operational policies for delegation and subagent management while providing automated workflows for rebranding, documentation, and upstream synchronization.

## Coding Conventions

### File Naming
- Use camelCase for file naming: `skillManager.py`, `bridgeRouter.js`
- Skills directories follow kebab-case: `skills/ecc-web-scraper/`
- Configuration files use SCREAMING_SNAKE_CASE: `SKILL_QUALITY_CONTRACT.md`

### Import Style
```python
# Mixed import patterns - both relative and absolute
from .skillManager import SkillManager
from agention.core import AgentRouter
import upstream_sync.handlers as handlers
```

### Export Style
```python
# Mixed export patterns
__all__ = ['SkillManager', 'BridgeRouter']

# Direct exports in __init__.py
from .main import *
```

### Testing
- Test files follow pattern: `*.test.js`
- Framework: Currently unknown/mixed

## Workflows

### Rebranding Workflow
**Trigger:** When rebranding the entire project with new name and identity
**Command:** `/rebrand`

1. Update README.md with new project name, description, and branding elements
2. Replace logo assets in `assets/logo.svg` and related image files
3. Refresh all documentation files with new terminology and references
4. Modify configuration scripts in `scripts/` directory to reflect new naming
5. Update upstream sync references in `upstream-sync/work/**/*.md` files

```bash
# Example rebranding script structure
#!/bin/bash
OLD_NAME="OldProject"
NEW_NAME="Agention"

find . -name "*.md" -exec sed -i "s/$OLD_NAME/$NEW_NAME/g" {} \;
cp assets/new-logo.svg assets/logo.svg
```

### Bridge Skill Integration
**Trigger:** When integrating a new external skill repository as bridge skills
**Command:** `/integrate-upstream`

1. Create mapping matrix document: `REPOSITORY_NAME_MAPPING_MATRIX.md`
2. Generate bridge skills with standardized `SKILL.md` files in `skills/ecc-**/`
3. Add upstream path references: `skills/ecc-**/references/upstream-path.txt`
4. Create integration plan: `REPOSITORY_NAME_INTEGRATION_PLAN.md`
5. Update inventory: `upstream-import/**/INVENTORY.json` and notices

```markdown
# Example SKILL.md structure for bridge skills
# Bridge Skill: External Repository Integration

## Upstream Reference
Path: `/path/to/upstream/repo`
Sync: `automated`

## Integration Mapping
- External function `doWork()` → Internal skill `executeTask()`
- External config `settings.json` → Internal config `skill-config.yaml`
```

### Quality Gate Workflow
**Trigger:** When enforcing quality standards across all skills
**Command:** `/quality-gate`

1. Create or update `SKILL_QUALITY_CONTRACT.md` with validation rules
2. Run skill validation scripts: `scripts/validate-skills.sh`
3. Generate quality pass report: `SKILL_QUALITY_PASS_REPORT.md`
4. Update validation workflows: `.github/workflows/validate.yml`
5. Create bridge routing regression tests: `BRIDGE_ROUTING_REGRESSION.md`

```bash
# Example validation script
#!/bin/bash
echo "Running skill quality checks..."
for skill in skills/*/; do
  if [[ -f "$skill/SKILL.md" ]]; then
    echo "✓ $skill has SKILL.md"
  else
    echo "✗ $skill missing SKILL.md"
  fi
done
```

### Documentation Enhancement
**Trigger:** When significantly improving project documentation and positioning
**Command:** `/docs-refresh`

1. Rebuild README.md structure with clear sections and navigation
2. Add feature matrices, compatibility tables, and call-to-action sections
3. Update installation guides: `INSTALL.md`
4. Enhance compatibility documentation: `COMPATIBILITY.md`
5. Add acknowledgements and contributor sections

### Policy Enforcement Workflow
**Trigger:** When creating or updating operational governance policies
**Command:** `/policy-update`

1. Create or update `OPERATIONAL_ENFORCEMENT.md` with governance rules
2. Define delegation rules in `SUBAGENT_POLICY.md`
3. Establish operational enforcement procedures
4. Update README.md with policy references and compliance information

```markdown
# Example policy structure
## Delegation Rules
- Subagents must inherit parent agent permissions
- All delegated tasks require audit trail
- Maximum delegation depth: 3 levels
```

### Upstream Sync Automation
**Trigger:** When establishing automated sync with external repositories
**Command:** `/setup-sync`

1. Create GitHub workflow: `.github/workflows/upstream-sync.yml`
2. Configure upstream sources: `UPSTREAM_SOURCES.json`
3. Add synchronization scripts: `scripts/sync-upstream.sh`
4. Create changelog tracking: `SYNC_CHANGELOG.md`
5. Set up source pinning: `upstream/SOURCE_PIN.txt`

```yaml
# Example sync workflow
name: Upstream Sync
on:
  schedule:
    - cron: '0 0 * * 1'  # Weekly on Monday
jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: ./scripts/sync-upstream.sh
```

## Testing Patterns

Testing appears to use mixed frameworks with `*.test.js` pattern files. Current testing approach includes:

- Bridge routing regression tests for skill integration validation
- Quality gate validation scripts for skill compliance
- Upstream sync verification for repository synchronization

## Commands

| Command | Purpose |
|---------|---------|
| `/rebrand` | Complete project rebranding including assets and documentation |
| `/integrate-upstream` | Create bridge skills from external repositories |
| `/quality-gate` | Run comprehensive quality validation across all skills |
| `/docs-refresh` | Major documentation and README enhancement |
| `/policy-update` | Update operational governance and delegation policies |
| `/setup-sync` | Configure automated upstream repository synchronization |