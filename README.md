# Elixir Secure Coding Training (ESCT)

### Quick Installation

> Prerequisite: have Docker CLI installed

1. Download / fork this repo
2. Open a terminal and cd into the repo folder
3. run the following command `sudo docker run -p 8080:8080 -p 8081:8081 --pull always -v $(pwd):/data -e envar_secret="c0ngr@ts" livebook/livebook`
4. Copy and paste into your browser the URL that is outputted from step 3
5. From within Livebook in your browser, located `1-introduction.livemd` in the `/data` folder and open it
6. Have fun! 

### Project Todos:
- Lean harder into Elixir-isms for examples / prescriptiveness
- Add more sources to text
  - Superscript sources / citations
  - Potentially add historical examples of compromises deriving from different exploiot types
- Customize text more (it's rather copy-pasty right now)
- Iterate on / create new examples

### README Todos:
- Secure Elixir Logo
- Screenshots
- Badging (Livebook, License, etc.)
- Quick links at the top linking to sections within the README (Website | Usage | etc.)
- Decouple info from 1-introduction.livemd that's better suited here (acknowledgements, what this is, future modules, etc.)
- How to "install" for Learners
- How to "install" for Educators
- Contributing section / link to CONTRIBUTING.md
