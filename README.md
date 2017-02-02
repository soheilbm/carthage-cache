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


### Requirement
Carthage cache needs **`Cartfile.resolve`** in order to work. Carthage-Cache looks at the branch or tag version from resolve file and cache them. If you do not have the `.resolve` file make sure you run the `carthage update` first then run **`carthage-cache build`**.

- - -
### Commands
For verbose mode you can use `-v`

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

#### Debugging:
The cache files are store in `/Users/USERNAME/Library/Caches/carthage-cache/`
Cache files will store in folder based on xcode version and swift version. For instance, if you are using xcode 8 with swift 3, your folder will be like `X8.0.0_S3.0`.

### Todo
- [ ] Adding test cases
- [ ] Submitting to homebrew formula
- [ ] Make the caching return 1 in bach if it failed to build a library
