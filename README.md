# Description

Simplifies access to GNU Pascal compiler.

# Syntax
```bat
gnupas [options] pathToFile pathToOutFile [-- [compilerOptions]]
```

# Options
- `-h`|`--help`|`/h`|`/help` - writes help and exits
- `-v`|`--version`|`/v`|`/version` - writes version and exits
- `-p`|`--path`|`/p`|`/path` - specifies path to GNU Pascal compiler
- `-e`|`--exec`|`/e`|`/exec` - executes compiled program immediately
- `!` - suppress prompts to change PATH variable
    
# Examples
```bat
gnupas --version
```

```bat
gnupas test.pas test.exe
```

```bat
gnupas --path path-to-compiler test.pas test.exe
```
# Error codes
- `0` - Success
- `1` - None file passed or it is not found
- `2` - GNU Pascal compiler is not found
- `3` - You have to restart your shell to apply changes to PATH
    
# Notes
Optimization, pointer arithmetic and GNU Pascal extensions are enabled by default.
It means that -O3, --pointer-arithmetic, --gnu-pascal compiler options are passed by default.

