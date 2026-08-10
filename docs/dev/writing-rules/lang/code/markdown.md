 # Markdown

*	Language:
	*	Version: 1.0.1.
	*	Flavor: [Gruber's Flavor][].
	*	Paradigm: none.
	*	Browsers [Baseline][]: none.
*	File:
	*	New line character: LF (from Unix Standard).
	*	Files encoding: ASCII (9, 10, and 32-126).
* Other ones:
	*	Doc. generator: none.

## Index

*	[General](#general)
*	[Extended Markdown](#extended-markdown)
	*	[Heading ID](#heading-id)
*	[HTML](#html)
*	[Heading](#heading)
*	[Paragraphs](#paragraphs)
*	[Block quotes](#block-quotes)
*	[Lists](#lists)
	*	[Ordered lists](#ordered-lists)
	*	[Unordered lists](#unordered-lists)
	*	[Both lists types](#both-lists-of-types)
*	[Horizontal lines](#horizontal-lines)
*	[Code blocks](#code)
*	[Links](#links)
	*	[Inline links](#inline-links)
	*	[Reference links](#reference-links)
	*	[Links labels](#links-labels)
	*	[Image links](#image-links)
	*	[Automatic links](#automatic-links)
	*	[Both links types](#both-links-types)
*	[Emphasis](#emphasis)



## General

*	Lines MUST be at maximum 100 characters; except lines that contain big URLs. This limit
	excludes line break characters.

*	Length of tabulation character is equal to one (it is important because the line's characters
	limit). It MUST NOT be used to created texts grotesquely misaligned.

*	Multiple spaces MUST NOT be used to break lines.

*	File MUST end with an empty line.

*	All files MUST contain an [*index*][book index] that MUST be the first heading level 2 after
	the heading level 1; named as **Index**.

*	Files names MUST be equal to the content of its heading level 1, converted to `kebab-case` with
	`.md` as its file extension.



## Extended Markdown

>	If a Markdown extension feature is not into this list, it is not allow here.

### Heading ID

*	It is RECOMMENDED to use them only in [*indexes*][book index].

*	They MUST be directly used; no link label.



## HTML

*	HTML/XML tags MUST NOT be used; because they can make markup code (without processing) hard to
	read.

*	[HTML (or XML) entities][html entities] MUST NOT be used (because they can make markup code
	hard to read); except `&amp;` (to `&`) and `&lt;` (to `<`) that always MUST be used to avoid
	conflicts with Markdown syntax.



## Headings

*	This syntax (written with [Perl RegExp][]) MUST be used to mark them:
	`^#{1,6} [a-zA-Z\-_' ]+$`

*	They MUST be separated with empty lines when and with:

	*	Heading level is 1:
		one only immediately after it.

	*	Heading level is not 1 and last element is other heading:
		one immediately before it and one immediately after it.

	*	Heading level is not 1 and last element is not other heading:
		three immediately before and after it.

*	About heading level 1:

	*	It MUST be the first element of the file.

	*	It MUST be placed at file's first line.

	*	It MUST be single in each file.

	*	Its content MUST be equal to file name, but less [style-cases][] and grammatically
		correctly.

*	They sequence (1-5) MUST be regarded.
*	Heading hierarchy MUST be followed and regarded.

	>	Heading level 1 MUST contain only headings level 2;
	>	headings level 2 MUST contain only headings level 3;
	>	and so on.

*	They MUST NOT contain extra emphasis (bold, italic, italic bold, and/or code); only
	*default*.

*	Their content MUST NOT have more than one line.



## Paragraphs

*	They MUST be separated with two empty lines, one immediately before its start line and one
	immediately after its end line.

*	Line start of paragraphs MUST NOT be indented.



## Block quotes

*	Empty lines MUST be formed only with a `>`.

*	Non-empty lines MUST be formed with a `>` immediately followed by one tabulation and for its
	content.

*	They MUST be separated with two empty lines, one immediately before its start line and one
	immediately after its end line.



## Lists

### Ordered lists

*	These lists MUST start with number one.

*	First line of all their items MUST start with `n.` (where `n` is the item index) immediately
	followed by a tabulation and for its content.

*	All their items MUST be correctly manually ordered, from lower to greater.

*	They only MUST be used when items order is relevant.



### Unordered lists

*	First line of all their items MUST start with a `*` immediately followed by one tabulation and
	for its content.

*	They only MUST be used when items order is irrelevant.



### Both types of lists

*	They MUST be separated with two empty lines, one immediately before its first item and one
	immediately after its last item.

*	List items MUST be separated, of other list items, with empty lines when and with:

	*	It contains mostly paragraphs (texts with multiple lines) and it is the first list item:
		one only immediately after it.

	*	It contains mostly paragraphs and it is the last list item:
		one only immediately before it.

	*	It contains mostly paragraphs and it is not the first or last list item:
		one immediately before and after it.

	*	It contains only short phrases (single line texts):
		none.

		>	Position is irrelevant here.

*	It is NOT RECOMMENDED to create nested lists with many of three of depth.

*	Paragraphs content lines, from a same item, MUST be aligned, with tabulation, to start exactly
	in the same line column of the item's first line of text.

	>	Some code editors do not support "flexible tabulations"; like
		[Zettlr (v4.7.0)][zettlr@7.4.0].



## Horizontal lines

*	This syntax (written with [Perl RegExp][]) MUST be used to mark them: `^---$`.

*	They MUST be separated with two empty lines, one immediately before it and one immediately after
	it.



## Code blocks

*	They MUST be separated with two empty lines, one immediately before it and one immediately after
	it.

*	One tabulation MUST be used to start a code block line; instead of four spaces.



## Links

### Inline links

*	Reference links MUST be used instead of inline links.



### Reference links

*	This syntax (written with [Perl RegExp][]) MUST be used to mark them:
	`\[.+\]\[::label::+\]` (`[text][label]`).

	>	At this context, `::label::` is a *pseudo-label* to the labels naming recommendations.



### Links labels

*	This syntax (written with [Perl RegExp][]) MUST be used to mark them:
	
		^[::label::]: .+$
		^	"([^"]|\\")+"$

	>	At this context, `::label::` is a *pseudo-label* to the labels naming recommendations below:
	>
	>	*	It is RECOMMENDED to use only lowercase characters, digits, and space characters to
	>		name link labels.

*	They MUST be separated with:

	*	immediately before it:

		*	three empty lines, if it is the first link label declaration of the file that points to
			a [relative path][relative paths],
	
		*	three empty lines, if it is the first link label declaration of the file that points
			to an URL, or
	
		*	none;

	* immediately after it:

		*	one empty line immediately after it.

*	They MUST be declared at file bottom.

*	It is RECOMMENDED that titles follow this syntax structure: `<site-name>: <page-title>`.

*	Those destined to image links MUST point only to local files, from project repository (through
	of [relative paths][]).

*	All paths MUST be relative to the current Markdown file and MUST start with `./`.

*	All those that point to [relative paths][] MUST be placed before all those that point to URLs.


### Image links

*	It is NOT RECOMMENDED to use image elements, because Markdown cannot resize them.

*	They MUST use link labels, instead of hard links or hard relative/absolute paths.

*	They MUST have an [alternative text][].



### Automatic links

*	They MUST NOT be used, because they do not support titles.



### Both links types

>	Except link labels.

*	They MUST NOT contain line breaks; move them the next line instead.

	>	If they are bigger than maximum lines length, try to reduce length of link text or link
	>	label; it is NOT RECOMMENDED to exceed lines length limit.

*	Emphasis markup to link text MUST be inside of square brackets.



## Emphasis

> To *italic*, **bold**, and ***italic bold***; `code1`, and `` code2 `` (different syntax).

*	Only `*` MUST be used to apply *italic*, **bold**, and ***italic bold*** font formats.

*	Two spaces, one immediately at start and one immediately at end, MUST be used in alternative
	syntax of `code1` (`` code2 ``).

*	They always MUST be correctly manually closed.

*	Nesting is NOT RECOMMENDED; separate them instead.

	>	`code1` and `` code2 `` do not support nesting.

*	Closing order of nested elements MUST regard the opening order.

*	They MUST NOT contain line breaks; separate them instead.

*	All chunks of code (variables names, keywords, primitive values, ...) included into
	phrases MUST be markup as `code1` or `` code2 ``.



[style-cases]: ../../../style-cases.md
	"List of used style-cases"



[gruber's flavor]: https://daringfireball.net/projects/markdown/syntax
	"Daring Fireball: (Gruber's) Markdown"

[baseline]: https://developer.mozilla.org/en-us/docs/Glossary/Baseline/Compatibility
	"Mozilla Dev. Doc.: Baseline (compatibility)"

[html entities]: https://en.wikipedia.org/wiki/list_of_XML_and_HTML_character_entity_references
	"Wikipedia: list of XML and HTML character entity references"

[perl regexp]: https://perldoc.perl.org/perlre
	"Perl Doc.: Regular Expressions"

[book index]: https://en.wikipedia.org/wiki/Index_(publishing)
	"Wikipedia: index (publishing)"

[relative paths]: https://en.wikipedia.org/wiki/Path_(computing)#relative
	"Wikipedia: path (computing)"

[alternative text]: https://www.w3schools.com/TAGS/att_img_alt.asp
	"w3 Schools: alt attribute of <img>"

[zettlr@7.4.0]: https://github.com/Zettlr/Zettlr/releases/tag/v4.7.0
	"Zettlr (repository from GitHub): release of v7.4.0"
