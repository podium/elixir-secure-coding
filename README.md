<div align="center">

<a href="https://github.com/podium/elixir-secure-coding/archive/master.zip"><img src="./assets/images/secure_elixir_gold.png" alt="Elixir Secure Coding Training" width="25%"></a>

# Elixir Secure Coding Training (ESCT)

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fpodium%2Felixir-secure-coding%2Fmodules%2F1-introduction.livemd)
<br />

![GitHub contributors](https://img.shields.io/github/contributors-anon/podium/elixir-secure-coding)
![GitHub last commit](https://img.shields.io/github/last-commit/podium/elixir-secure-coding)
![GitHub issues by-label](https://img.shields.io/github/issues-raw/podium/elixir-secure-coding/topic-addition)
![GitHub closed pull requests by-label](https://img.shields.io/github/issues-pr-closed-raw/podium/elixir-secure-coding/topic-addition)
<br />

![GitHub forks](https://img.shields.io/github/forks/podium/elixir-secure-coding?style=social)
![Twitter URL](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2Fintent%2Ftweet%3Furl%3Dhttps%253A%252F%252Fgithub.com%252Fpodium%252Felixir-secure-coding%26text%3DCheck%2520out%2520Elixir%2520Secure%2520Coding%2520Training%2520-%2520originally%2520authored%2520by%2520%40HoldenOullette%2520for%2520%40PodiumHQ%253A)
<br />

### An all-encompassing, opinionated cybersecurity curriculum designed for enterprise use at software companies using the [Elixir](https://elixir-lang.org/) programming language. 

[About](#about) |
[Curriculum](#curriculum) |
[Usage](#usage) |
[Contributing](#contributing) |
[License](#license)

<hr />
</div>

## About
Originally developed for [Podium](https://www.podium.com)'s Elixir engineers by its Product Security team, the ESCT was designed to be integrated into developer onboarding processes - teaching developers about Application Security using context that applies to them. 

The content originally focused exclusively on what Podium uses, but quickly grew to encapsulate more areas of Application Security. The material itself is composed of views from the Product Security team at Podium as well as information sourced from reputable public information - attribution has been given wherever possible.

Today individuals or companies wishing to try out the ESCT can and are encouraged to fork a copy of their own - please follow the relevant instructions below depending on your use case.

If you find an issue, wish to suggest an idea, or start a discussion; please see our [CONTRIBUTING Guide](./CONTRIBUTING.md)!

## Curriculum
Currently the curriculum is broken into the follow 8 primary topics, each containing multiple lessons:
1. **OWASP**
    - OWASP Top 10
2. **Secure SDLC**
    - No Secrets In Code
    - Making Secret Rotation Easy
    - Rate Limiting
    - Principle of Least Privilege
3. **GraphQL Security**
    - Disabling Introspection
    - Error Disclosure
    - Resource Exhaustion
      - Cost Theory
4. **Elixir Security**
    - Atom Exhaustion
    - Protecting Sensitive Data
    - Untrusted Code
    - Timing Attacks
    - Boolean Coercion
5. **Cookie Security**
    - Ingredients of a Cookie
    - The Perfect Cookie
    - Elixir Phoenix Cookies
6. **Security Anti-Patterns**
    - Security Through Obscurity
    - Frontend Authorization Checks
7. **CI/CD Tooling**
    - Sobelow
      - Salus
    - Semgrep
8. **The Secure Road**
    - Service to Service Authentication
    - User Authorization

*If you do not see a topic or lesson you would like covered, please review our [open issues](https://github.com/podium/elixir-secure-coding/labels/new%20content) and our [CONTRIBUTING Guide](./CONTRIBUTING.md) before opening a new issue - but we encourage requests!*

## Usage
### For "Learners"
Using the ESCT as a consumer of the content is easy by just following these simple steps:
1. Fork this repo into a space you control
    - Important to note: if you were instructed to use this course by your company, double check with the folks who are running things for your company to ensure they don't have a customized version of the training materials
2. Clone your forked repo
3. Load the Live Markdown files in an instance of Livebook
    - For further instructions on getting Livebook setup locally, please refer to [their documentation](https://livebook.dev/#install).
4. Complete the training as instructed and save your progress along the way!
5. When you think you're finished, create a PR to ***your own fork*** of the training repo
    - You will receive feedback as to whether you completed it or not in the CI stage of your version control system<sup>*</sup>

*<sup>\*</sup>Feedback functionality only works in GitLab right now, GitHub support is [in the works](#)*

### For "Educators"
TODO

## Contributing
Please refer to our [CONTRIBUTING Guide](./CONTRIBUTING.md) for more details on how to add to this project!

## License
![GitHub](https://img.shields.io/github/license/podium/elixir-secure-coding)
