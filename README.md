# GnuPas

## Description

Simplifies access to GNU Pascal compiler.

# Syntax

```bat
gnupas [options] pathToFile pathToOutFile [-- [compilerOptions]]
```

## Options

- `-h`|`--help`|`/h`|`/help` - writes help and exits
- `-v`|`--version`|`/v`|`/version` - writes version and exits
- `-p`|`--path`|`/p`|`/path` - specifies path to GNU Pascal compiler
- `-e`|`--exec`|`/e`|`/exec` - executes compiled program immediately
- `!` - suppress prompts to change PATH variable

# Return codes

- `0` - success
- `1` - none file passed or it is not found
- `2` - GNU Pascal compiler is not found
- `3` - you have to restart your shell to apply changes to PATH

If compilation failed then compiler error status is returned.
If -e|--exec|/e|/exec option passed then program execution error status is returned.

# Notes
Optimization, pointer arithmetic and GNU Pascal extensions are enabled by default.
It means that -O3, --pointer-arithmetic, --gnu-pascal compiler options are passed by default.

## Examples

```bat
gnupas --version
```

```bat
gnupas test.pas test.exe
```

```bat
gnupas --path path-to-compiler test.pas test.exe
```

