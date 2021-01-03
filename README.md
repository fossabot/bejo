<img src="https://github.com/bejo-lang/assets/blob/main/logo.png?raw=true" width="150"/>

A modern programming language from the future, just for fun.

Bejo is a new programming language, currently under active development.
It's a modern, statically-typed functional and runs on the BEAM (Erlang VM), but focusing in building and maintaining scalable web apps without compromising on programmer ergonomics.

Project status: Actively developed. Not ready for production use or HackerNews.

### Syntax

Here's a quick walkthrough of Bejo's syntax.

#### Functions

A function in Bejo looks like this:

```elixir
# example.bejo
fn sum(a: Int, b: Int) : Int do
  a + b
end
```

This is a function named `sum` which takes two integers and returns another integer.
Identifiers in Bejo are written in snake_case (similar to Ruby, Elixir or Python).
Types are written in CamelCase.

Bejo has a type checker which makes sure your functions actually return what
they say they do. For example, the type checker will report an error for
the following code:

```elixir
fn sum(a: Int, b: Int) : Float do
  a + b
end

# Error: "Expected type: Float, got: Int"
```

All functions in Bejo are nested inside modules.
Module names in Bejo are inferred from their file paths, so a Bejo file named
`example.bejo` will become a module named `example`. All functions inside this
file will belong to this module.

The `sum` function can be called like so:

```elixir
# Calling locally within the module
sum(40, 2)

# Calling remotely outside the module
example.sum(40, 2)
```

#### If-Else expressions
An if-else expression in Bejo looks like this:
```
if true do
  a = "we have if-else now!"
  200
else
  404
end
```

#### Basic types and operators

Bejo is currently a proof of concept so its data types and operators are quite
limited.

Data types - atoms, integers, strings, booleans, lists and records.
Operators - assignment and arithmetic.

```elixir
# This is a comment

# Type: Int
a = 40
b = 2
c = a + b

# Type: String
str = "Hello world"

# Type: Bool
x = true

# Type: List(Int)
list_of_ints = [1, 2, 3]

# Type: {String,Bool}
tuple = {"tuple", true}

# Type: {foo: Int}
record = {foo: 123}
```

### Running Bejo programs

Bejo is written in Elixir, so make sure you have that installed.
Follow [these instructions](https://elixir-lang.org/install.html) to install
Elixir. Next, clone this repo, cd into the directory and then follow the below instructions.

#### Using Elixir shell

```
# Install dependencies and run the Elixir shell
mix deps.get
iex -S mix

# In the Elixir shell, compile and load a Bejo file using the following:
> Bejo.Code.load_file("example.bejo")

# Now you can run functions from the module like this:
> :example.sum(40, 2)
> 42
```

#### Using `bejo` executable

```
# Create the executable
mix escript.build

# Call the function example.sum(1, 2) from the file example.bejo
./bejo exec --function="sum(1, 2)" example.bejo
```

### Your first HTTP server

Bejo comes with a webserver which allows you to quickly create HTTP request
handlers. By default, Bejo looks for routes in a function called
`router.routes()`, so you need to define that first:

Note: This webserver is a prototype for now and only responds with strings and
a 200 status code.

```elixir
# Inside router.bejo
fn routes : List({method: String, path: String, handler: Fn(->String)}) do
  [
    {method: "GET", path: "/", handler: &greet}
  ]
end

fn greet : String do
  "Hello world"
end
```

Now start the webserver in one of two ways:

#### Using Elixir shell

```
# router.bejo is in the `examples` folder
> Bejo.start("examples")

# Reload routes after changing routes.bejo
> Bejo.RouteStore.reload_routes()
```

#### Using `bejo` executable

```
# Create the executable
mix escript.build

# router.bejo is in the `examples` folder
./bejo start examples

# Re-run the command after making changes to routes.bejo
```

Now open `http://localhost:6060` in the browser to see "Hello world" served
by Bejo.
