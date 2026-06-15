### Docker image build steps

> #### IMPORTANT
> * All files that require a specific directory always must try to create them, with `mkdir -p
<dir...>`, before trying to use them.

0. **Create Apache's User**: create the user\* that will be used to execute the Apache HTTP Server;
   it also will be used by Docker, during image build, to run specific executable scripts.

0. **Download PHP's Core Extensions**: downloads all PHP's Core Extensions\* made available by the
   package repositories of the chosen Linux Distribution; through of its package manager.

0. **Download CodeIgniter**: downloads the project framework (directory structure and dependences)
   using the Composer.

0. **Download NPM packages**: downloads Bun and uses it to download all NPM packages that are
   required to preprocess all the front-end source files.

0. **Download Apache HTTP Server**: downloads the WEB server that will be responsible for serve the
   application pages.

0. **Download useful tools**: downloads useful binaries and executable scripts to run common tasks.

0. **Download templates of configuration files**: downloads template files of the configuration
   files of the project dependences (like PHP's INI files).

0. **Download assets**: downloads icons, images, text fonts, libraries, and other types of assets
   required by the front-end pages; in addition to PHP libraries.

0. **Download deploy packages**: downloads CLIs, made available by the package repositories of the
  chosen Linux Distribution, to process the source code. **This always must be the last step.**

> * Because of security reasons, Apache does not allow the use of the Root User as its
administrator (user responsible for execute its process); unless it was compiled with the flag
`--enable-exception-hook`, which is not a good idea and is a unnecessary work in this context.
>
> * PHP's Core Extensions are like PHP's trivial extensions, but with a differential: they are part
of the PHP's interpreter, but they are optional; in other words, PHP's interpreter can be compiled
less them.

### Source code preprocessing

TODO

