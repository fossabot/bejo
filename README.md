<img src="https://github.com/bejo-lang/assets/blob/master/logo.png?raw=true" width="150"/>

Bejo is a new programming language, currently under active development. It's a modern, statically-typed functional and runs on the BEAM (Erlang VM), but focusing in building and maintaining scalable web apps without compromising on programmer ergonomics.

### Syntax

Here's a quick walkthrough of Bejo's syntax.

#### Functions

A function in Bejo looks like this:

```elixir
fn sum(a: Int, b: Int) : Int do
  a + b
end
```

This is a function named `sum` which takes two integers and returns another integer.
Identifiers in Bejo are written in snake_case (similar to Ruby, Elixir or Python).
Types are written in CamelCase.