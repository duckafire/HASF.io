# HASF.io documentation

This directory contains all HASF.io documentation, divided into two sections:

*	[User documentation][user doc]: destined to people that wants to use HASF.io tools; it
	explains who to use them and how their algorithms logic works, in addition to explain other
	of their functionalities and features.

*	[Developer documentation][dev doc]: destined to people that wants understand who HASF.io
	works *behind the scenes*, how its architecture was planned and executed, what technologies
	were used into it, what [*conventions*][] were applied on it, and other technical information.
	
	> It is RECOMMENDED to all people that wants to help HASF.io development (with ideas, fixes, and
	> similar), wants to learn more about software, and/or wants to creates their own [fork][].



## Index

*	[Recommended pages](#recommended-pages)
*	[Documentation conventions](#documentation-conventions)
*	[Principles and philosophies](#principles-and-philosophies)



## Recommended pages

*	[User documentations][user doc]:
	*	[Getting started][]

*	[Developer documentation][dev doc]:
	*	[Principles and philosophies](#principles-and-philosophies)
	*	[Markdown writing conventions][]



## Documentation conventions

*	*Original documentation* (base to translations) MUST be written in English-US.

*	Files naming:

	*	`README.md`: contains a overview of the content present in the directory where it is.

	*	`THIRD_PARTY_LICENSES`: contains a copy of licenses of each dependence of the project.

*	Key words "MUST", "MUST NOT", "SHALL", "SHALL NOT", "REQUIRED", "NOT REQUIRED", "SHOULD", "NOT
	SHOULD", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" present in documentation files
	must to be interpreted as described in [RFC 2119][].



## Principles and philosophies

>	These principles and philosophies do not have to be applied only into source code, but in all
>	project files; they are stating base of thinking of it.

*	[YAGNI][] (*You Aren't Gonna Need It.*):
	at this context, it refers to unused features; if something is not required **now**, it MUST NOT
	be developed, maintained, or continued. Features MUST be concrete solutions to concrete
	problems; they MUST NOT resolve inexistent problems or that still do not exist.

*	[KISS][] (*Keep It Simple, Stupid!*):
	at this context, it refers to unnecessary complexities of the code. In mostly times, it does not
	required of tens of abstract layers, advanced design patterns, or other things that make code
	hard to read and understand; it just need to work well and be easy to maintain.

*	[Murphy's law][] (*Anything that can go wrong will go wrong.*):
	at this context, it refers to the treatment of possible events that can cause big problems;
	like an exception that can be thrown if `stdout` is corrupted, an unexpected behavior that
	will occur a thread is stopped before to end its task, and similarities. If anything that
	can go wrong, the application MUST be prepared.



[user doc]: ./user/README.md
	"User documentation overview"

[dev doc]:  ./dev/README.md
	"Developer documentation overview"
	
[getting started]: .
	"TODO"

[markdown writing conventions]: ./dev/writing-rules/lang/code/markdown.md
	"Writing rules to Markdown files"



[convetions]: https://en.wikipedia.org/wiki/Coding_conventions
	"Wikipedia: coding conventions"

[fork]: https://en.wikipedia.org/wiki/Fork_(software_development)
	"Wikipedia: fork (software development)"

[rfc 2119]: https://tools.ietf.org/html/rfc2119
	"IETF: RFC 2119"

[yagni]: https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it
	"Wikipedia: you aren't gonna need it"
	
[kiss]: https://en.wikipedia.org/wiki/KISS_principle
	"Wikipedia: KISS principle"
	
[murphy's law]: https://en.wikipedia.org/wiki/Murphy's_law
	"Wikipedia: Murphy's law"
