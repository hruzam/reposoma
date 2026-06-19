---
raw: antigravitry headless regime
---

To run the Google Antigravity CLI (agy) in a headless (non-interactive) mode for a fast smoke test response, you use the -p (one-shot prompt) option.
The standard terminal command is:

agy -p "Your smoke test instruction here"

## 🛠️ Recommended Parameters for Automated Testing
For CI/CD pipelines or automated environments, combine the prompt option with flags that suppress interactive prompts and handle format parsing:

* --yes: Automatically accepts all actions and skips confirmation prompts.
* --output-format json: Outputs raw text or structured data instead of rendering the TUI (Terminal User Interface).
* timeout wrapping: Prevents the pipeline from hanging if the CLI waits for an unexpected input.

Example of a robust smoke test command:

timeout 30s agy -p "Check code for basic syntax errors" --yes --output-format json < /dev/null

## ⚠️ Important Note for Non-TTY (Headless) Environments
When agy detects it is running without an interactive terminal (non-TTY), it might suppress certain outputs or fail to initialize correctly. Redirecting standard input using < /dev/null or using a pseudo-terminal wrapper (like script or a python bridge) ensures the CLI executes and returns the fast response to your log files immediately.
------------------------------
To help configure this for your workflow, please let me know:

* Which CI/CD platform are you using (e.g., GitHub Actions, GitLab CI)?
* Do you need to parse the JSON output for specific success/failure keys in your script?


