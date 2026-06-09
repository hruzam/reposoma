Můžete si postavit vlastního AI agenta přímo v Laravelu pomocí oficiálního [Laravel AI SDK](https://laravel.com/ai), který byl představen jako nativní součást frameworku. Odpadá tak nutnost používat Python nebo externí knihovny typu LangChain. [1, 2, 3] 
Níže naleznete rychlý návod, jak vytvořit a spustit vlastního specializovaného agenta. [4, 5] 
## 1. Instalace a konfigurace
Nejprve do projektu nainstalujte balíček AI SDK pomocí Composeru: [5] 

composer require laravel/ai

Následně publikujte konfigurační soubory a spusťte migrace pro správu historie konverzací: [6, 7] 

php artisan ai:install

(V konfiguračním souboru config/ai.php si nastavíte API klíče pro poskytovatele jako OpenAI, Anthropic nebo Ollama). [8, 9, 10] 
## 2. Vygenerování vlastního agenta
Pro vytvoření dedikované třídy agenta použijte vestavěný příkaz Artisanu: [6, 11] 

php artisan make:agent BookFinderAgent

Tento příkaz vytvoří novou třídu v adresáři app/Agents/BookFinderAgent.php. [11] 
## 3. Definice chování agenta
Uvnitř nově vytvořené třídy můžete určit systémové instrukce (prompty), model, teplotu nebo schopnost pamatovat si historii. [6, 8, 12] 

namespace App\Agents;

use Laravel\AI\Agent;
use Laravel\AI\Traits\RemembersConversations;

class BookFinderAgent extends Agent
{
    // Automaticky ukládá a načítá historii z DB
    use RemembersConversations; 

    protected string $model = 'gpt-4o';
    protected float $temperature = 0.7;

    /**
     * Základní instrukce, kterými se agent řídí.
     */
    public function instructions(): string
    {
        return 'Jsi zkušený knihovník. Pomáháš uživatelům najít knihy na základě jejich nálady.';
    }
}

## 4. Volání agenta v aplikaci
Jakmile máte agenta definovaného, můžete ho snadno zavolat z kontroleru, Livewire komponenty nebo routy: [2, 9] 

use App\Agents\BookFinderAgent;

// První zpráva odstartuje konverzaci
$response = BookFinderAgent::make()->prompt('Hledám nějaké napínavé sci-fi na víkend.');

echo $response->text;

// Pro pokračování v existující konverzaci stačí předat ID konverzace
$conversationId = $response->conversationId;
$nextResponse = BookFinderAgent::make()
    ->continue($conversationId)
    ->prompt('A má to méně než 300 stránek?');

## Pokročilé funkce SDK

* Připojení nástrojů (Tools): Agentovi můžete předat PHP třídy jako nástroje, díky kterým si sám dokáže vytáhnout data z vaší databáze nebo volat externí API. [1, 11, 13, 14] 
* Asynchronní fronty (Queueing): Dlouhotrvající úkoly agenta nemusí blokovat HTTP požadavek. Můžete ho poslat do standardní Laravel fronty pomocí metody ->queue($message). [8] 
* Streamování: Odpovědi lze uživateli vypisovat v reálném čase (token po tokenu) pomocí metody ->stream(). [2, 8] 

Pokud chcete vidět praktické ukázky komplexnějších architektur (např. řetězení agentů), prostudujte si oficiální průvodce pro [Multi-Agent Workflows](https://laravel.com/blog/building-multi-agent-workflows-with-the-laravel-ai-sdk) na blogu Laravelu. [5, 14] 
Chcete, abychom pro vašeho agenta navrhli konkrétní nástroj (Tool), například pro prohledávání databáze produktů, nebo potřebujete pomoci s nastavením streamování odpovědí do frontendu? [8] 

[1] [https://laravel.com](https://laravel.com/ai)
[2] [https://laravel-news.com](https://laravel-news.com/ship-ai-with-laravel-building-your-first-agent-with-laravel-13s-ai-sdk)
[3] [https://laravel.com](https://laravel.com/blog/laravel-ai-integration-build-a-document-search-agent)
[4] [https://laravel.com](https://laravel.com/docs/13.x/installation)
[5] [https://laravel.com](https://laravel.com/blog/building-multi-agent-workflows-with-the-laravel-ai-sdk)
[6] [https://www.youtube.com](https://www.youtube.com/watch?v=l-UQI-Wy10o)
[7] [https://laravel.com](https://laravel.com/blog/introducing-the-laravel-ai-sdk)
[8] [https://laravel.com](https://laravel.com/blog/building-ai-agents-with-laravel-no-python-required)
[9] [https://medium.com](https://medium.com/@revaz.gh/how-to-create-ai-agent-locally-using-laravel-and-ollama-4c6c48eb2648)
[10] [https://dev.to](https://dev.to/inspector/create-and-monitor-ai-agents-in-php-2mhb)
[11] [https://www.youtube.com](https://www.youtube.com/watch?v=vlaFf-Ng-EQ&t=1870)
[12] [https://medium.com](https://medium.com/towardsdev/laravel-ai-agent-development-made-easy-ac7ddd17a7d0)
[13] [https://laravel.com](https://laravel.com/blog/laravel-ai-sdk-building-production-safe-database-tools-for-agents)
[14] [https://laravel.com](https://laravel.com/docs/13.x/ai-sdk)
