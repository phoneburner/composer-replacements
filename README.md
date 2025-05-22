# PhoneBurner Composer Replacements

A 'no-op' Composer package used to cleanly replace other dependencies and unneeded polyfills.

### Why replace safe polyfill packages like `symfony/polyfill-php84`?

1. A root project that depends on this library is guaranteed to be on PHP 8.4 or later, due to this library's version
   constraints. If some other dependency of the root project requires the `symfony/polyfill-php84` package, that package
   is completely unnecessary and adds overhead to every request. That overhead is very slight, especially when opcache
   is enabled, but it exists nevertheless. Polyfills usually have some kind of "bootstrap.php" file configured to always
   load and execute when Composer initializes autoloading. Ideally, polyfill libraries minimize their performance impact
   with some kind of early return conditional that checks for the PHP version or existence of a particular extension.
2. Because they _could_ define methods in the global namespace, even though the definition code would never execute at
   runtime, unneeded polyfills can complicate static analysis and IDE tooling. Beyond simple "multiple definitions
   exist"
   warnings, nothing enforces a polyfill method to have the same signature as method it covers.
3. Unneeded packages are unnecessary downloads when building production images and have dependency
   constraints that Composer has to manage. These are additional potential points of failure.

### Why require this package instead of defining replacements in the root?

1. Repeatability across multiple projects.
2. Requiring this library as a dev dependency does not other affect packages that require it. This is most useful for
   frameworks and framework-like packages where the library has complex behavior and testing.
3. The output of Composer commands that produce tree output is *significantly* cleaner, especially if also run
   recursively.

###

```shell
 docker run --rm -it -v $PWD:/app -u $(id -u):$(id -g) composer/composer install --ignore-platform-reqs
```
