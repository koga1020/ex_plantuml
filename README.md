# ExPlantuml

encoding library for plantuml text.

## Installation

```elixir
def deps do
  [
    {:ex_plantuml, git: "https://github.com/koga1020/ex_plantuml.git"}
  ]
end
```

## Usage

```elixir
iex> ExPlantuml.encode("Bob->Alice : hello")
"~1UDfpoa_IjNFCoKnELR1Io4ZDoSa703O41Ui0"
```

## Reference

- [PlantUML Text Encoding](https://plantuml.com/en/text-encoding)
