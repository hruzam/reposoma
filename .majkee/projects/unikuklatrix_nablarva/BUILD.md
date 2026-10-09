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
