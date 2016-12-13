## Carthage Cache
Alternate solution for carthage cashing.

#### Installation
##### Homebrew Option
`brew tap soheilbm/formulae`
`brew install carthage-cache`

##### Git Clone Option
`git clone git@github.com:soheilbm/carthage-cache.git`
`cd carthage-cache`
`chmod +x carthage-cache/main.swift`
`./carthage-cache/main.swift`

- - -

#### Commands
``` bash
./carthage-cache help
```

- **help**     *Display general build commands and options*
- **build**    *Copy framework from cache or build a new one if doesn't exist*
- **version**  *Display current version*


#### Options:
-   **-r**    *Path to directory where Cartfile.resolved exists (by default uses current directory).*
-   **-x**    *XCode version (by default uses `llvm-gcc -v`). e.g 8.0.0*
-   **-l**    *Swift version (by default uses `xcrun swift -version`). e.g 3.0*
-   **-s**    *Shell environment (by default will use /usr/bin/env)*
-   **-f**    *Force to rebuild and copy to caching directory*
-   **-v**    *Verbose mode*


### Todo
- [ ] Adding test cases
- [ ] Submitting to homebrew formula