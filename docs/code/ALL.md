[m-law]: https://en.wikipedia.org/wiki/Murphy%27s_law
[kiss]:  https://en.wikipedia.org/wiki/KISS_principle
[yagni]: https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it

# Generic Programming Conventions

###### Last changes: 07 March 2026

### Concepts

* [Murphy's Law: *"Anything that can go wrong will go wrong."*][m-law]
* [KISS: Keep It Simple, Stupid.][kiss]
* [YAGNI: You Aren't Gonna Need It.][yagni]

### Language

* Use English for everything (content meant for the end-user is an exception): mainly because
  most popular programming languages use it (in keywords; standard functions; ...); which
  improves the *fluidity* of the "language".

### Tabulation

* *Tabs* must always be used to indentation (one to each level): it allows to change, visually, the
  *real size* of indentation, based on the developer preferences. If *tab* is not allow - by the
  language - use two spaces.

* Add an indentation level always after that a new *block* is opened: in other words, add it whenever
  a *multi-line code delimiter* is used to contain a snippet of code (like `<div></div>`, from HTML,
  or `{}`, from C).

* *Tabs* must not be used to align code (use spaces to do this): these character is reserved to
  indentation, if it is not reserved by the language; furthermore it can cause problems with strict
  *linters*.

* Do not apply indentation in *empty lines*: it can increase the file size, and is ignored by
  Git; there is no reason to do this.

### Comments

* Only create *explanatory comments* to explain implicit things: this makes the code cleaner,
  avoids *synchronization problems* (code is updated, but comment is not), and avoids redundancy.
  Explanation related with these things can present in documentation too.

* Use `TODO` to highlight comments with *to do orders*: because it is a common convention; it is
  recognized by a lot of Code Editors/IDEs.

* Use `FIXME` to highlight comments with orders to fix bugs, errors, and similary: it looks like
  `TODO`, but it is a little less broad.

* Use `NOTE` to highlight notes related with logical decision: it looks like `TODO`, but it is
  a **small** convention.

* Use only `lowercase` in *fast comments* (no-mandatory-punctuations): these are comments used,
  e.g., to explain the meaning of abbreviations, *to name* a snippet of code, or similar.

* Apply English Grammar rules in *explanatory comments*: it improves the readability of the given
  instructions.

### Directory structure

* Files/modules:
  * If it declares **only one** *class-like* (class; interface; enumerator; ...), it must
    always assign the name of the declared *class-like*.
  * Else if its name have to be a valid variable name (`[a-zA-Z_][a-zA-Z_0-9]*`), it must always
    be written in `snake_case`.
  * Else is must always be written in `kebab-case`.

* Directories/folders:
  * If its name have to be a valid variable name (`[a-zA-Z_][a-zA-Z_0-9]*`), it must always
    be written in `snake_case`.
  * Else is must always be written in `kebab-case`.

### To programming languages

#### Nomenclature

| Groups | Case Styles | Example |
| :-- | :-- | :-- |
| Classes     | `PascalCase`                                | `FooBar` |
| Constants   | `SCREAMING_SNAKE_CASE` or (abb) `UPPERCASE` | `FOO_BAR`|
| Enumerators | `PascalCase`                                | `FooBar` |
| Functions   | `snake_case` or (abb) `lowercase`           | `foo_bar`|
| Interfaces  | `I` + `PascalCase`                          | `FooBar` |
| Macros      | `SCREAMING_SNAKE_CASE` or (abb) `UPPERCASE` | `FOO_BAR`|
| Methods     | `camelCase` or (abb) `lowercase`            | `fooBar` |
| Parameters  | `camelCase` or (abb) `lowercase`            | `fooBar` |
| Properties  | `camelCase` or (abb) `lowercase`            | `fooBar` |
| Types       | `lowercase` + `_t`                          |`foobar_t`|
| Variables   | `camelCase` or (abb) `lowercase`            | `fooBar` |

* Notes:
  * `camelCase` and `SCREAMING_SNAKE_CASE` can be abbreviated; in this case, they must always
    follow, respectively, `lowercase` and `UPPERCASE`.

  * Classes represents all derivated from them, like records from Java, constructor functions from
    JavaScript, structures from C, and other ones.

#### Semantic

* Boolean variables, or function that return boolean values (except when this return is used to inform
  the status of the operation, between success, or failure) must always be prefixed with `is`, `has`, or
  `can`.

* Boolean variables, or function that return boolean values must not be *negative* (like `isNotFound`).

* If possible, `false`, `true`, and `null` must always be `lowercase`.

* Enumerators names must always describe its *family* (constants group).

* Enumerators names must always be singular.

* Identifiers must always be describable.

* If the language does not support encapsulation of properties, and methods their names must always
  follow the synopsis below:
  * If it is public:    `[name]`
  * If it is protected: `__[name]`
  * If it is private:   `__[name]__`

* If constants are not supported, variables have to be used like constants; they, obviously, must
  not be changed, and must always receive their value during their declaration.

* *List-like/collections* must always be written in plural.

* Time/date must always follow the *UTC Standard* in *BackEnd*; when at client-side it can converted to
  other format.

* Generic *getters*, and *setters* must be avoided (give semantic to their names; just use public
  properties).

* *Getters-like* must not change the object state.

* *Setters-like* must not return *complex data*.

#### Structure

* *Block opener* (like `{`, from C, and `then` from Lua) must always go on the next line after their *owner*.

* *Block closer* (like `}`, from C, and `end` from Lua) must always go on the next line after the *block body*.

* If ternary operations are supported, they must be used only to attribute, or return a value.

* If ternary operations are supported, they must not be nested in other ternaries.

* Use *guard condition* to avoid nested conditions in functions, methods, and similar.

* If possible, *if-condition*, loops, and other types of *blocks* which content of formed by **one** *snippet*
  of code must not have *block delimiters* (but their content must always be indented).

* *Things* must not be declared in loops, except *for-loop* variables.

* Always avoid global *things*.

* If semicolon is supported, and optional it must always be used.

* If supported, always put a comma after the last item of an array, object, or similar.

* If single-quotes works like double-quotes, single-quotes must never be used.

* Add space after commas.

* Put attribute, math, and boolean operators between spaces.

#### Behavior

* Function that can fail must always be monitored, either with a *if-condition*, either with a *try-catch*.

* Optional parameters, from function, must always be a default value different from *undefined* value (like
  `None` from Python; `nil` from Lua; ...); `null` is valid to this.

* Variables, parameters, functions return, and similar must always be typed; if typing is not supported
  these *things* do not have to be dynamic, and they have to be validated, when strictly necessary, at
  runtime.

