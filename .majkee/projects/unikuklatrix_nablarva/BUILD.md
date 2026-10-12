---
reason: `majkee:` share my animal architecture intents
---

# 1. GLOBAL

## 1.1. scripts

### 1.1.1. loader (?), controller, model, registries

***trivia:*** 

`date`: `2026-10-08`
zsh has loaded all in one touch, some function can 
be generic and need them only on request.
Like in PHP can be
```php
$this->load->model(`same-layer-or-whole-core-bed/layer/script_by_purpose_name`);

/* 
this stores model scritp iteration to varaible 
($result = $this->model_<layer>_<script_by_purpose_name>->function_name({possiblevars}
*/
```

1. so specific work can be handled on request loaded not have to stay in caches
longer than needed.
2. can call functions according `permission policy`
3. 


***questions***

> Q-1. Where comes time to think about it?



1. `tn-threads` displaying as `source` : `vscode`. in 
reality agent run max in tmux pane. Not big bug because main purpose working well.


### 1.1.2. vendor shift updater

**GOAL**: 
``` 
make application settings so dry, that we can ask agent to check actual 
vendor shifts  - maybe as cron session : routine build - to collect data 
and with any implementer spawn --> update app config|settings files.
```

Example unless the claude code where can be used aliases for model like just `opus`, 
codex requires direct model line and generation assignation as `GPT-5.6-Terra` 

***codex reply to matter***
```
fleet registry (your one maintained source)
    └─ render →
       ~/.codex/agents/astrobley.toml
       ~/.codex/agents/houston.toml
       ~/.codex/houston.config.toml
 
  That renderer is your harness/deployment layer, not a Codex feature. Mark outputs generated and validate them with
  codex --strict-config after rendering.
 
  A custom model gateway could provide aliases/routing, but that moves model-routing responsibility outside Codex
  and is heavier than a small local renderer.
```




