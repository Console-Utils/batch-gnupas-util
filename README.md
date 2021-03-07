# Description

Simplifies access to GNU Pascal compiler.

# Syntax
```bat
compiler [options] pathToFile [pathToOutFile]
```

# Options
- `-h`|`--help`|`/h`|`/help` - writes help and exits
- `-v`|`--version`|`/v`|`/version` - writes version and exits
- `-p`|`--path`|`/p`|`/path` - specifies path to GNU Pascal compiler
- `!` - suppress prompts to change PATH variable

# Examples
```bat
compiler --version
```

```bat
compiler test.pas target_directory\
```
