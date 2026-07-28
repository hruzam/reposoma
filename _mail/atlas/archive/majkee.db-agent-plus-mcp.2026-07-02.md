# DB-delta

## task process
Project here: `/home/hruzam/www/imago_cz/fantasyobchod/.claude/agents/delta-sql.md` containing local MCP server connection.
Important wiring is here also: `/home/hruzam/.config/zsh/config.zsh` FOCUS on office php switch.
Password are here because this db is local not production, everything si allowed now, in case we need close for private processes -> specific protected database.

```php
// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'majkee');
define('DB_PASSWORD', 'password1');
define('DB_DATABASE', '<ad-hoc>');
define('DB_PREFIX', '');
```

Can we have one project agent f.e. here in reposoma which is using db MCP, I think yes, local project agent has indepedndent setting and servers, other agents I incarnating from global folder so MCP would available for db expert.  



