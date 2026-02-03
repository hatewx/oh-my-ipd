#!/bin/bash

# Verification script for oh-my-ipd OpenCode installation

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Oh My IPD - OpenCode Installation Verification           ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

OPENCODE_DIR="$HOME/.config/opencode"

# Check agents
echo "📦 Checking Agents..."
agents=(developer lpdt pdu pqa se tmm)
for agent in "${agents[@]}"; do
    if [ -f "$OPENCODE_DIR/agents/$agent.md" ]; then
        echo "  ✅ $agent.md"
    else
        echo "  ❌ $agent.md (MISSING)"
    fi
done
echo ""

# Check commands
echo "💻 Checking Commands..."
commands=(ipd-start ipd-status ipd-tr ipd-charter)
for cmd in "${commands[@]}"; do
    if [ -f "$OPENCODE_DIR/commands/$cmd.md" ]; then
        echo "  ✅ $cmd.md"
    else
        echo "  ❌ $cmd.md (MISSING)"
    fi
done
echo ""

# Check skills
echo "📚 Checking Skills..."
skills=(ipd-workflow pdt-collaboration)
for skill in "${skills[@]}"; do
    if [ -f "$OPENCODE_DIR/skills/$skill/SKILL.md" ]; then
        echo "  ✅ $skill/SKILL.md"
    else
        echo "  ❌ $skill/SKILL.md (MISSING)"
    fi
done
echo ""

# Check plugin
echo "🔌 Checking Plugin..."
if [ -f "$OPENCODE_DIR/plugins/oh-my-ipd-hooks.js" ]; then
    echo "  ✅ oh-my-ipd-hooks.js"
else
    echo "  ❌ oh-my-ipd-hooks.js (MISSING)"
fi
echo ""

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Installation Status Summary                               ║"
echo "╠════════════════════════════════════════════════════════════╣"

# Count files
total=0
found=0

for agent in "${agents[@]}"; do
    total=$((total + 1))
    [ -f "$OPENCODE_DIR/agents/$agent.md" ] && found=$((found + 1))
done

for cmd in "${commands[@]}"; do
    total=$((total + 1))
    [ -f "$OPENCODE_DIR/commands/$cmd.md" ] && found=$((found + 1))
done

for skill in "${skills[@]}"; do
    total=$((total + 1))
    [ -f "$OPENCODE_DIR/skills/$skill/SKILL.md" ] && found=$((found + 1))
done

total=$((total + 1))
[ -f "$OPENCODE_DIR/plugins/oh-my-ipd-hooks.js" ] && found=$((found + 1))

echo "║  Components: $found/$total installed"

if [ $found -eq $total ]; then
    echo "║  Status: ✅ COMPLETE"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🎉 All components successfully installed!"
    echo ""
    echo "Next steps:"
    echo "1. Start OpenCode: opencode"
    echo "2. Try: /ipd-start my-project \"Test project\""
    echo "3. Or: @developer (press Tab to cycle through agents)"
else
    echo "║  Status: ⚠️  INCOMPLETE"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "⚠️  Some components are missing!"
    echo "Run: ./setup-opencode.sh to reinstall"
fi
