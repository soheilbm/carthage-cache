# Carthage Cache 
Alternate solution for Carthage Caching. Carthage-cache needs ***Cartfile.resolve*** in order to work. Carthage cache doesnt update your library. It only build and cache the version that exist in your cartfile.resolve file. 

![screenshot](https://raw.githubusercontent.com/soheilbm/carthage-cache/master/Assets/Sample.gif)


### Installation

#### Git Clone Option
```bash
git clone git@github.com:soheilbm/carthage-cache.git
cd carthage-cache
chmod +x carthage-cache/main.swift
make install copy clean
```

#### Brew Option
This option requires to use the latest version of XCode.

```bash
brew tap soheilbm/formulae
brew install soheilbm/formulae/carthage-cache
```

- - -

### Commands
```bash
carthage-cache build -v
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
