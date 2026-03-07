[cm-html]: https://www.w3.org/TR/2011/WD-html5-20110525/content-models.html

### HTML

###### Last changes: 07 March 2026

#### Compatibility with XML

* Use XML header.
* Close tags correctly.
* Close *void tags* with `/>`.
* Nest tags correctly.
* Quote values of attributes with double-quotes.
* Use external CSS file if it contains `<`, `&`, `>`, or `]]>`.
* Use external JS file if it contains `<`, `&`, `>`, `]]>`, or `--`.
* Always assign the attribute name to boolean attributes (like `readonly="readonly"`).

* Use the *entities* below instead of their respective characters:

| *Entity* | Char.| Name         |
| :--      | :-:  | :--          |
| `&amp;`  | `&`  | ampersand    |
| `&apos;` | `'`  | apostrophe   |
| `&gt;`   | `>`  | greater-than |
| `&lt;`   | `<`  | less-than    |
| `&quot;` | `"`  | quotation    |

#### Structure

* Use XHTML *doc*ument *type*.
* `<html>`, `<head>`, `<title>`, and `<body>` are mandatory.
* `<html>` must always include the attributes `lang` and `dir`.
* Do not use deprecated tags and attributes.
* Follow [content models][cm-html] of each HTML tag.
* Do not use literal characters outside of Extended-ASCII, use their respective *entities*.
* Do not accumulate multiple tags on the same line.
* Align horizontally both tags of an empty *block tag*.
* Add one level of indentation inside non-empty *block tags*.
* Do not create/use custom tags.
* Do not use `-` inside comments.

``` html
<!-- use this -->
<a role="button" href="...">
	...
</a>

<!-- instead of -->
<a href="...">
	<button>
		...
	</button>
</a>
```

#### Nomenclature

* Use `lowercase` for tags and attributes.
* `id` must always be unique.
* `id` must always be a valid JS variable name.
* Prefix custom attributes with `data-`.
* Use semantic tags, instead of just `<div>` and `<span>`.

| Groups | Case Styles | Example |
| :-- | :-- | :-- |
| Classes       | `kebab-case`           | `foo-bar`    |
| CSS Constants | `--` + `COBOL-CASE`    | `--foo-bar`  |
| Custom Attr.  | `data-` + `kebab-case` |`data-foo-bar`|
| CSS Variable  | `--` + `kebab-case`    | `--FOO-BAR`  |
| `id`          | `id_` + `camelCase`    | `id_fooBar`  |

* Notes:
  * `camelCase`, `kebab-case`, and `COBOL-CASE` can be abbreviated; in this case, they must
    always follow, respectively, `lowercase`, `lowercase`, and `UPPERCASE`.

#### Accessibility

* All `<img>` tags must always include the `alt` attribute.
* Include `aria-label` attribute when necessary.
* Hide, with `aria-hidden="true"`, only-visual content (like icons).
* Mix color and visual elements to improve accessibility for people with colorblindness

