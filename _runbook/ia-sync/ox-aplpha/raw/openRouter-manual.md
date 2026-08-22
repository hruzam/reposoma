# references

- `https://openrouter.ai/stealth/ox-alpha?view=api#providers`
- `~/reposoma/raw.settings/raw.card.openrouter.md`
- `~.config/zsh/.env/secrets.zsh` - input new key for openrouter

---

# copy of manual


1
Get your API key

Create an API key from your OpenRouter dashboard and set it as an environment variable:
Create API Key

export OPENROUTER_API_KEY=sk-or-v1-...

2
Make your first request

Use stealth/ox-alpha with the OpenRouter API:

OpenRouter supports reasoning-enabled models that can show their step-by-step thinking process. Use the reasoning parameter in your request to enable reasoning, and access the reasoning_details array in the response to see the model's internal reasoning before the final answer. When continuing a conversation, preserve the complete reasoning_details when passing messages back to the model so it can continue reasoning from where it left off. Learn more about reasoning tokens.

In the examples below, the OpenRouter-specific headers are optional. Setting them allows your app to appear on the OpenRouter leaderboards.

import OpenAI from 'openai';

const client = new OpenAI({
  baseURL: 'https://openrouter.ai/api/v1',
  apiKey: '<OPENROUTER_API_KEY>',
});

// First API call with reasoning
const apiResponse = await client.chat.completions.create({
  model: 'stealth/ox-alpha',
  messages: [
    {
      role: 'user' as const,
      content: "How many r's are in the word 'strawberry'?",
    },
  ],
  reasoning: { enabled: true }
});

// Extract the assistant message with reasoning_details
type ORChatMessage = (typeof apiResponse)['choices'][number]['message'] & {
  reasoning_details?: unknown;
};
const response = apiResponse.choices[0].message as ORChatMessage;

// Preserve the assistant message with reasoning_details
const messages = [
  {
    role: 'user' as const,
    content: "How many r's are in the word 'strawberry'?",
  },
  {
    role: 'assistant' as const,
    content: response.content,
    reasoning_details: response.reasoning_details, // Pass back unmodified
  },
  {
    role: 'user' as const,
    content: "Are you sure? Think carefully.",
  },
];

// Second API call - model continues reasoning from where it left off
const response2 = await client.chat.completions.create({
  model: 'stealth/ox-alpha',
  messages, // Includes preserved reasoning_details
});

Using third-party SDKs

For information about using third-party SDKs and frameworks with OpenRouter, please see our frameworks documentation.
3
Enable streaming

Add "stream": true to your request body to receive responses as server-sent events:

curl -N https://openrouter.ai/api/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -d '{
  "model": "stealth/ox-alpha",
  "stream": true,
  "messages": [
    {"role": "user", "content": "Hello"}
  ]
}'

Endpoint

Sends a request for a model response for the given chat conversation. Supports both streaming and non-streaming modes.
POST
https://openrouter.ai/api/v1/chat/completions
Authorization
Bearer $OPENROUTER_API_KEY
Content-Type
application/json
HTTP-Referer
optional — your site URL, for rankings
X-Title
optional — your site name, for rankings
Model
stealth/ox-alpha

Creates a streaming or non-streaming response using the OpenAI Responses API format.
Docs
POST
https://openrouter.ai/api/v1/responses
Authorization
Bearer $OPENROUTER_API_KEY
Content-Type
application/json
HTTP-Referer
optional — your site URL, for rankings
X-Title
optional — your site name, for rankings
Model
stealth/ox-alpha

Creates a message using the Anthropic Messages API format. Supports text, images, PDFs, tools, and extended thinking.
Docs
POST
https://openrouter.ai/api/v1/messages
Authorization
Bearer $OPENROUTER_API_KEY
Content-Type
application/json
HTTP-Referer
optional — your site URL, for rankings
X-Title
optional — your site name, for rankings
Model
stealth/ox-alpha
Parameters
Name	Type	Default	Description
reasoning	map	—	Controls reasoning behavior for models that support thinking tokens, including whether reasoning is enabled, the reasoning effort, maximum reasoning tokens, and whether reasoning is excluded from the response.
max_tokens	integer	—	This sets the upper limit for the number of tokens the model can generate in response.
temperature	float	1	This setting influences the variety in the model's responses.
top_p	float	0.95	This setting limits the model's choices to a percentage of likely tokens: only the top tokens whose probabilities add up to P.
tools	array	—	Tool calling parameter, following OpenAI's tool calling request shape.
tool_choice	string or object	—	Controls which (if any) tool is called by the model.
top_k	integer	0	This limits the model's choice of tokens at each step, making it choose from a smaller set.
response_format	map	—	Forces the model to produce specific output form