#!/bin/bash

# IPD-OMO Setup Script for OpenCode
# This script copies your plugin to OpenCode while keeping the original for Claude Code

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
OPENCODE_CONFIG_DIR="$HOME/.config/opencode"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  IPD-OMO to OpenCode Setup                                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Step 1: Create OpenCode config directories
echo -e "${GREEN}[1/5]${NC} Creating OpenCode config directories..."
mkdir -p "$OPENCODE_CONFIG_DIR/agents"
mkdir -p "$OPENCODE_CONFIG_DIR/commands"
mkdir -p "$OPENCODE_CONFIG_DIR/skills"
mkdir -p "$OPENCODE_CONFIG_DIR/plugins"

# Step 2: Copy agents
echo -e "${GREEN}[2/5]${NC} Copying agents..."
for agent in "$SOURCE_DIR/agents"/*.md; do
    if [ -f "$agent" ]; then
        basename=$(basename "$agent")
        cp "$agent" "$OPENCODE_CONFIG_DIR/agents/$basename"
        echo "  ✓ Copied $(basename "$agent")"
    fi
done

# Step 3: Copy commands
echo -e "${GREEN}[3/5]${NC} Copying commands..."
for cmd in "$SOURCE_DIR/commands"/*.md; do
    if [ -f "$cmd" ]; then
        basename=$(basename "$cmd")
        cp "$cmd" "$OPENCODE_CONFIG_DIR/commands/$basename"
        echo "  ✓ Copied $(basename "$cmd")"
    fi
done

# Step 4: Convert and copy skills (rename to SKILL.md format)
echo -e "${GREEN}[4/5]${NC} Converting and copying skills..."
for skill in "$SOURCE_DIR/skills"/*.md; do
    if [ -f "$skill" ]; then
        skillname=$(basename "$skill" .md)
        mkdir -p "$OPENCODE_CONFIG_DIR/skills/$skillname"
        cp "$skill" "$OPENCODE_CONFIG_DIR/skills/$skillname/SKILL.md"
        echo "  ✓ Converted $skillname to SKILL.md format"
    fi
done

# Step 5: Create minimal hooks plugin
echo -e "${GREEN}[5/5]${NC} Creating hooks plugin..."
cat > "$OPENCODE_CONFIG_DIR/plugins/oh-my-ipd-hooks.js" << 'EOF'
/**
 * IPD-OMO Hooks Plugin for OpenCode
 * Provides pre/post tool-use hooks for IPD workflow management
 */

export const OhMyIpdHooks = async ({ project, client, $, directory, worktree }) => {
  const fs = await import('fs')
  const path = await import('path')
  
  // Helper to read project state
  const readProjectState = async () => {
    const statePath = path.join(directory, '.claude', 'project-state.md')
    try {
      if (fs.existsSync(statePath)) {
        return fs.readFileSync(statePath, 'utf-8')
      }
    } catch (err) {
      // Project state doesn't exist yet
    }
    return null
  }

  // Helper to extract current phase from state
  const getCurrentPhase = (stateContent) => {
    if (!stateContent) return null
    const phaseMatch = stateContent.match(/当前阶段:\s*(\w+)/)
    return phaseMatch ? phaseMatch[1] : null
  }

  return {
    // Pre-tool-use hook: IPD flow validation
    "tool.execute.before": async (input, output) => {
      const state = await readProjectState()
      const currentPhase = getCurrentPhase(state)
      
      // Check if we're in IPD mode
      if (!state || !currentPhase) {
        return // Not in IPD mode, skip validation
      }

      // Validate tool use based on current phase
      if (currentPhase === 'Charter' || currentPhase === 'LLD') {
        if (input.tool === 'write' || input.tool === 'edit') {
          await client.app.log({
            service: 'oh-my-ipd',
            level: 'warn',
            message: `[IPD-OMO] 当前处于 ${currentPhase} 阶段，不建议直接修改代码`,
            extra: { phase: currentPhase, tool: input.tool }
          })
        }
      }

      if (currentPhase === 'TR') {
        if (input.tool === 'write' || input.tool === 'edit') {
          await client.app.log({
            service: 'oh-my-ipd',
            level: 'warn',
            message: '[IPD-OMO] 当前处于 TR 评审阶段，代码修改需要通过 Developer',
            extra: { phase: currentPhase, tool: input.tool }
          })
        }
      }
    },

    // Post-tool-use hook: Update project state
    "tool.execute.after": async (input, output) => {
      const state = await readProjectState()
      const currentPhase = getCurrentPhase(state)
      
      if (!state || !currentPhase) {
        return // Not in IPD mode, skip logging
      }

      // Log tool usage for IPD tracking
      await client.app.log({
        service: 'oh-my-ipd',
        level: 'info',
        message: `[IPD-OMO] Tool executed in ${currentPhase} phase`,
        extra: { 
          phase: currentPhase, 
          tool: input.tool,
          timestamp: new Date().toISOString()
        }
      })

      // Auto-trigger next steps based on tool execution
      // (This can be expanded based on your workflow needs)
    }
  }
}
EOF

echo "  ✓ Created oh-my-ipd-hooks.js"

echo ""
echo -e "${GREEN}✓ Setup complete!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Restart OpenCode (if running)"
echo "2. In any project, you can now use:"
echo "   - Commands: /ipd-start, /ipd-status, /ipd-tr, /ipd-charter"
echo "   - Agents: @developer, @pdu, @se, @pqa, @tmm, @lpdt (via Tab key)"
echo "   - Skills: Available to all agents automatically"
echo ""
echo -e "${YELLOW}Note:${NC} Your original plugin at:"
echo "  $SOURCE_DIR"
echo "is unchanged and can still be used with Claude Code."
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Happy coding with IPD-OMO! 🚀                             ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
