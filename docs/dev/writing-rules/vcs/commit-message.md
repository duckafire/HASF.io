# Commit message

This document defines the pattern that MUST be used to write description of changes patch, also
known as commit, of the chosen [VCS (Version Control System)][vcs] to manage project versions; as
way to improve and facilitate its readability and understanding.

>	The term commit was popularized by [Git][] and its community; before its development, other
>	terms was used to refer to patches of changes.

Content of this document is **inspired** mainly into [Angular's conventions recommends to commits][]
and [Linux Kernel's submitting patches rules][linux commit conventions].



## Index

*	[Structure](#structure)
	*	[Type](#type)
		*	[build](#build)
		*	[ci](#ci)
		*	[cd](#cd)
		*	[conf](#conf)
		*	[doc](#doc)
		*	[feat](#feat)
		*	[fix](#fix)
		*	[perf](#perf)
		*	[refactor](#refactor)
		*	[revert](#revert)
		*	[style](#style)
		*	[test](#test)
		*	[vendor](#vendor)
	* [Subject and body](#subject-and-body)
	* [Subject](#subject)
	* [Body](#body)
	* [Footer](#footer)
* [Examples](#examples)



## Structure

	<type>: <subject>

	<body>

>	Unlike other types, [revert](#revert) has its own structure:
>
>		revert: <reverted-commit-sha1-id>
>
>		From-commit:
>		  <reverted-commit-hash>
>		  ("<reverted-commit-subject>")
>
>		<body>
>
>	It is necessary to maintain an easy way to find and access the commit that was reverted.



### Type

It declares which type of changes were done in a commit. This is important to classify commits and
facilitating the reversion of its changes in future (whether necessary); in addition to making
changes intensions clean. Each commit can have **only** one type.

>	Commits with many or wrong types will be rejected.



#### build

*	Creation, brute division, or exclusion of scripts (Shell, Makefile, ...) used as auxiliary,
	source of instructions, manifest, or similar element to compile or *transpile* source files of
	the application or of dependencies required to build application, directly or indirectly.



#### ci

*	Creation or exclusion of files destined to contain the planning of future updates of the
	application (features, fixes, and similarities).

*	Addition, updating, or exclusion of excerpts in files that stores the planning of future updates
	of the application.

	>	Provided that the changes do not fix markup or grammatical of written; in addition to not
	>	change style of fonts, typeface, alignment, indentation, and similarities.

*	Creation, brute division, or exclusion of scripts (Shell, Makefile, ...) used as auxiliary,
	source of instructions, manifest, or similar element to execute build or test process.



#### cd

*	Creation or exclusion of files destined to contain the release notes of application versions.

*	Addition, updating, or exclusion of excerpts in files files that stores release notes of
	application versions.

	>	Provided that the changes do not fix markup or grammatical of written; in addition to not
	>	change style of fonts, typeface, alignment, indentation, and similarities.

*	Creation, brute division, or exclusion of scripts (Shell, Makefile, ...) used as auxiliary,
	source of instructions, manifest, or similar element to execute deploy process.



#### conf

*	Creation or exclusion of files destined to contain the configuration definitions to a software
	application, framework, library, or other third-party resource that has as goal to help
	project development.

	>	It includes: `.gitattributes`, `.dockerignore`, `Makefile`, ...

*	Addition of new configuration options (fields); with or without a value.

*	Updating of configuration options (fields) values.

	>	Provided that the changes do not fix value(s) type, format, or formation.



#### doc

*	Creation, brute division, or exclusion of files reserved to store project documentation (as
	pure text, markup text, image, or similar).

	>	What does not include planning to future application versions or release notes.

*	Creation, brute division, or exclusion of documentation comments (inside scripts).

	>	Documentation comment is a special [comment][] written to be read and used by
	>	[Documentation Generator][] (like [LuaDoc][]) to generated a documentation about
	>	some parts of the application source code.

*	Addition, updating, modification, or remotion of information from documentation content.

	>	Provided that the changes do not fix markup or grammatical of written; in addition to not
	>	change style of fonts, typeface, alignment, indentation, and similarities.



#### feat

*	Addition of any type of feature to the application, build, tests, or deploy process, to a
	script, or to any other type of resource than can receive a feature.

	>	Resource MUST be new, like installation of a third-party resource (like a plugin, library,
	>	...), creation of a new functionality to the IU, or development of a filter to ignore
	>	specific files names (as string) in a specific context; so the declaration of, i.e., new
	>	functions, as result of the division of a big function, does not fit here.



#### fix

*	Any changes that have as fix something and are not related with text/code style/formation, like:

	*	bugs;
	*	failures;
	*	undefined behaviors;
	*	undesired behaviors;
	*	grammatical errors; and
	*	other similar things.



#### perf

*	Changes that have as goal to improve the performance, optimization, and/or efficiency of some
	process at execution level; directly or indirectly related with consume of hardware resources.



#### refactor

*	Changes that have as goal to improve the readability and/or understanding of some excerpt of:

	*	text:

		*	technical paraphrasing;
		*	polishing of written;
		*	changes at characters typeface;
		*	changes at font of text; and
		*	similarities.

	*	code:

		*	[division of responsibility][s-of-solid];
		*	renaming of identifiers (with more meaningful names);
		*	remotion of unused excerpts;
		*	deleting of redundant, non-updated, and irrelevant comments; and
		*	similarities.



#### repo

*	Movement/appointment of files/directories.

*	Reordering of files/directories after to create/delete directories.

*	Changes at files/directories permissions.

*	Changes at files/directories ownership.

*	Updating of paths used to refer files/directories (during import, linking, ...).

	>	Provided that this updated is not a fix of a wrong name and is required because of the
	>	changes of the current commit.
	>
	>	Any other type of file content modification is not allowed to this type.



#### revert

*	It only MUST be used when the current commit reverts a previous commit; automatically through of
	[VCS][vcs] options.



#### style

*	Modification that have as goal to improve the formation, indentation, alignment, and other
	similarities of the source code of any script destined to processing, compiling, or
	*transpiling*; in other words, changes that only affect the source code organization.

	>	Some languages (like Python, Yaml, and Makefile) treat some of the cited items as semantic
	>	structures; if it is the case, this type MUST NOT be used.

*	Changes into comments that are not documentation comments.



#### test

*	Creation, brute division, or exclusion of files reserved to store tests for the application
	code and features.

	>	At this content, tests are files executed before to deploy to application, to check for
	>	problems.

*	Addition, brute division, or exclusion of tests, from files reserved to them.



#### vendor

*	Modification in manifest files (generated manually or automatically by the tool) utilized by
	software used to manage application dependencies; done manually or automatically by the tool.

	>	It includes: `docker-composer.yaml`, `bun.lock`, `tsconfig.json`, ...



### Subject and body

>	Both rules bellow are applied to `<subject>` and `<body>`.

*	It MUST written using English-[US][] as language.

	>	Its grammatical rules MUST be followed; but periods and full stops MUST not be used, because
	>	it must be a simple phrase (like any other title).

*	Only [ASCII][] characters (10, 32-126) MUST be used.

*	Only [plain text][] MUST be used.

*	It is NOT RECOMMENDED to include URLs into messages; mainly big URLs.

*	It MUST use a directly, simple, clean, readable, and easy to understand discourse.



### Subject

*	Lines MUST be at maximum **50** characters; except lines that contain big URLs. This limit
	excludes line break characters.

*	It MUST declare commit subject; like a title.

*	It MUST answer the question: "**what** was it done?"

*	[Imperative mood][] MUST be used to structure it.

	>	Because this mood is, commonly, more directly and shorter all other ones. Think you are
	>	giving an "order" to the [code base][].

*	It is NOT RECOMMENDED contain excerpts of code (like identifiers and keywords); from any
	language.

*	It MUST NOT contain URLs.



### Body

*	Lines MUST be at maximum **75** characters; except lines that contain big URLs. This limit
	excludes line break characters.

*	It MUST contain all relevant information about changes, with important details; like a
	description.

*	It MUST answer the question: "**why** was it done?".

*	Inline excepts of code (like identifiers and keywords) MUST be between single graves (`foo`);
	while block excepts of code MUST be between triple graves, that MUST be placed immediately
	before the first line of the code and immediately after the last line of code, and at start
	of both lines, like:

		```
		foo
		```

*	It MUST NOT contain excerpts of code (like identifiers and keywords); from any language.

*	It MUST be strict impersonal.

*	It MUST NOT contain redundant information.

*	First line of each paragraph MUST be indented with two spaces.

*	It can contains lists:

	*	Ordered lists:

		*	first line of all their items MUST start with `n.` (where `n` is the item index)
			immediately followed by a space and for its content; and

		*	indexes of sub-list items MUST be prefixed by the indexes of the item that contains
			them.

			>	I.e.:
			>
			>		4. foo.
			>		  4.1. bar.
			>		  4.2. stuff.
			>		    4.3.1 other foo.

	*	Unordered lists:

		*	each line MUST start with a `*` immediately followed with a space character and for
			its content;

	*	Both lists:

		*	multi-line content, from a same item, MUST be aligned, with spaces, to start exactly
			in the same line column of the item's first line of text;

		*	items MUST NOT contain multiple paragraphs;

		*	sub-lists MUST be indented with two spaces; before it starts; and

		*	it is NOT RECOMMENDED with many of three of depth.



## Examples

	feat: declare class to validate values typing

	PHP's typing does not guarantee safe at all contexts, so it is essential
	to have an easy and simple way to validate typing in there "remote"
	scenarios; mainly to check content from user input.

---

	fix: remove optional operator (?) from parameter

	First parameter of protected setter `updateHour` supports nullable values,
	unlike private property `hour` (from `Watch`); it can generate a type error
	and crash application (in addition to other bad effects).

---

	repo: separate CI and CD scripts

	Separating related files into different directories allows to improve
	the semantic weight of their paths, making import, linking, and refering
	to them more cleaner; working as a built-in documentation.

---

	perf: replace String with StringBuild

	Concatenating multiple strings based in class `String`, many times, is low
	and expensive, unlike to do it with `StringBuilder` it is fastest and
	cheapest; because of it, at some contexts, `StringBuilder` is the best
	choice.

---

	revert: 2c26b46

	From-commit:
	  2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae
	  ("vendor: remove unused dependence and client code")

	It can be used as a fallback resource when the main resource failure. It
	is hard to occur, but it can occur; therefore the application need to be
	preparated.

---

	style: align content of a list item

	Misalignment injures written rules of Markdown.



[vcs]: https://en.wikipedia.org/wiki/Version_control
	"Wikipedia: version control"

[git]: https://git-scm.com/
	"Git WEB home page"

[linux commit conventions]: https://www.kernel.org/doc/html/v4.14/process/submitting-patches.html
	"Kernel (organization): Submitting patches process"

[angular's conventions recommends to commits]: https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines
	"Angular documentation: Commit message guidelines"

[typeface families]: https://en.wikipedia.org/wiki/Typeface
	"Wikipedia: typeface"

[comment]: https://en.wikipedia.org/wiki/Comment_(computer_programming)
	"Wikipedia: comment (computer programming)"

[documentation generator]: https://en.wikipedia.org/wiki/Documentation_generator
	"Wikipedia: documentation generator"

[luadoc]: https://keplerproject.github.io/luadoc/
	"LuaDoc documentation"

[s-of-solid]: https://simple.wikipedia.org/wiki/SOLID_(object-oriented_design)#Single_responsibility_principle_(SRP)
	"Wikipedia: SOLID (object-oriented design)"

[us]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#US
	"Wikipedia: ISO 3166-1 alpha-2"

[imperative mood]: https://en.wikipedia.org/wiki/Imperative_mood
	"Wikipedia: imperative mood"

[code base]: https://en.wikipedia.org/wiki/Codebase
	"Wikipedia: codebase"

[ascii]: https://en.wikipedia.org/wiki/ASCII
	"Wikipedia: ASCII"

[plain text]: https://en.wikipedia.org/wiki/Plain_text
	"Wikipedia: plain text"
