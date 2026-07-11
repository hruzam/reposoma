# self improovement

Microsoft made ChatGPT's accuracy jump from 41% to 80% without touching a single parameter.

The system is SkillOpt.

Most people think AI agents improve by writing better prompts or fine-tuning the model itself. But fine-tuning is rigid, slow, and expensive. And prompt engineering is just guessing.

Microsoft’s approach treats the AI’s skill set, the actual text document that tells it how to solve a problem, as a living, breathing model that learns from its own failures.

Here is how it works:

1. Rollouts: The agent attempts tasks. It captures its own successes and failures.
2. Optimizer Model: A separate, small model analyzes those results and makes atomic edits to the skill document (Add, Delete, or Replace).
3. Validation Gate: The new skill is only accepted if it strictly improves performance on a held-out set of tasks.

It is essentially Gradient Descent for natural language.

And the results are staggering:

Across six major benchmarks, SkillOpt outperformed every human-written skill and every one-shot LLM approach.

On some tasks, accuracy skyrocketed. 
On the ALFWorld benchmark, one model jumped from 70% to 85% accuracy. In direct chat scenarios, it boosted accuracy by over 23 points.

The best part?
There is zero inference-time overhead.

You spend the compute optimizing the skill once. Then, the agent runs with that hyper-optimized playbook forever.

The playbook effectively trains itself through feedback. If you want an agent that actually gets better at its job every single day, without you having to touch a single line of code, this is how it’s done.

-/arxiv. org/pdf/2605.23904