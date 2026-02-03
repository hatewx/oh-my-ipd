# IPD-OMO for OpenCode

This is a simple adapter that makes your IPD-OMO plugin work with OpenCode, while keeping the original plugin intact for Claude Code.

## Quick Start

Run the setup script:

```bash
./setup-opencode.sh
```

That's it! The script will:
1. Copy your agents to `~/.config/opencode/agents/`
2. Copy your commands to `~/.config/opencode/commands/`
3. Convert your skills to `~/.config/opencode/skills/*/SKILL.md` format
4. Create a minimal hooks plugin at `~/.config/opencode/plugins/oh-my-ipd-hooks.js`

## What Gets Installed

### Agents (via Tab key)
- `developer` - Developer agent for code implementation
- `pdu` - Product Development Unit for requirements
- `se` - System Engineer for architecture
- `pqa` - Product Quality Assurance
- `tmm` - Technical Manager
- `lpdt` - Lead Product Development Team

### Commands (via `/` prefix)
- `/ipd-start` - Start IPD-OMO workflow
- `/ipd-status` - Check project status
- `/ipd-tr` - Technical Review operations
- `/ipd-charter` - Charter management

### Skills (auto-loaded)
- `ipd-workflow` - IPD workflow procedures
- `pdt-collaboration` - PDT collaboration patterns

### Hooks
- Pre-tool-use: Validates operations against IPD phases
- Post-tool-use: Updates project state and triggers workflows

## Differences from oh-my-opencode

**oh-my-opencode approach:**
- ~500+ lines of TypeScript code
- Complex CLI wrapper
- Custom tool implementations
- Full command parser

**This simple approach:**
- ~100 lines total (mostly in hooks plugin)
- Uses OpenCode's native markdown support
- No custom parsers needed
- Direct file copying

## Why This Works

OpenCode **natively supports** markdown-based configuration:
- Agents: Just drop `.md` files in `agents/` folder
- Commands: Just drop `.md` files in `commands/` folder
- Skills: Use `SKILL.md` format in `skills/<name>/` folders
- Hooks: Only need minimal JS for event handling

## Keeping Both Systems

Your original plugin at:
```
/Users/EM/Work/code/magic/modules/llm-cli-plugins/oh-my-ipd/
```

Is **unchanged** and continues to work with Claude Code.

OpenCode reads from:
```
~/.config/opencode/
```

Both can coexist peacefully! 🤝

## Updating the Plugin

If you update your original plugin and want to sync to OpenCode:

```bash
./setup-opencode.sh
```

Just run the setup script again. It will overwrite the OpenCode copies with your latest changes.

## Troubleshooting

**Agents not showing up?**
- Restart OpenCode
- Check that files exist in `~/.config/opencode/agents/`
- Make sure frontmatter has `mode:` field (primary/subagent)

**Commands not working?**
- Check files exist in `~/.config/opencode/commands/`
- Verify frontmatter has `description:` field
- Try `/help` to see if they're registered

**Skills not available?**
- Ensure skills are in `~/.config/opencode/skills/<name>/SKILL.md` format
- Check frontmatter has required `name:` and `description:` fields

## Next Steps

1. Run `./setup-opencode.sh`
2. Start OpenCode: `opencode`
3. Try `/ipd-start` to begin a project
4. Use Tab key to switch between agents
5. Access skills with the `skill` tool

Happy coding! 🚀
