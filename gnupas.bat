@echo off
setlocal

call :init

set /a "i=0"
:copy_options
    echo %~1| findstr /r "^-- ^- ^/" 2> nul > nul
    if %errorlevel% neq 0 (
        set "option=%~f1"
    ) else (
        set "option=%~1"
    )
    if defined option (
        if not "%option%" == "--" (
            set "args[%i%]=%option%"
            shift
            set /a "i+=1"
            goto copy_options
        ) else (
            shift
            set /a "i+=1"
        )
    )

set compiler_options=-O3 --pointer-arithmetic --gnu-pascal
:copy_compiler_options
    set "option=%~1"
    if defined option (
        set compiler_options=%compiler_options% %option%
        shift
        goto copy_compiler_options
    )

set /a "i=0"
:main_loop
    set /a "j=i + 1"
    call set "option=%%args[%i%]%%"
    call set "value=%%args[%j%]%%"

    set /a "is_help=FALSE"
    if "%option%" == "-h" set /a "is_help=TRUE"
    if "%option%" == "--help" set /a "is_help=TRUE"
    if "%option%" == "/h" set /a "is_help=TRUE"
    if "%option%" == "/help" set /a "is_help=TRUE"

    if %is_help% equ %TRUE% (
        call :help
        exit /b %ec_success%
    )

    set /a "is_version=FALSE"
    if "%option%" == "-v" set /a "is_version=TRUE"
    if "%option%" == "--version" set /a "is_version=TRUE"
    if "%option%" == "/v" set /a "is_version=TRUE"
    if "%option%" == "/version" set /a "is_version=TRUE"

    if %is_version% equ %TRUE% (
        call :version
        exit /b %ec_success%
    )

    set /a "is_path=FALSE"
    if "%option%" == "-p" set /a "is_path=TRUE"
    if "%option%" == "--path" set /a "is_path=TRUE"
    if "%option%" == "/p" set /a "is_path=TRUE"
    if "%option%" == "/path" set /a "is_path=TRUE"

    if %is_path% equ %TRUE% (
        set "path_to_compiler=%value%"
        set /a "use_path=FALSE"
        set /a "i+=2"
        goto main_loop
    )

    set /a "is_suppress=FALSE"
    if "%option%" == "!" set /a "is_suppress=TRUE"

    if %is_suppress% equ %TRUE% (
        set /a "use_suppress=TRUE"
        set /a "i+=1"
        goto main_loop
    )

set "path_to_file=%option%"
set "path_to_out_file=%value%"

if not exist "%path_to_file%" (
    echo %WRONG_FILE_PASSED_MSG%
    exit /b %WRONG_FILE_PASSED_EC%
)

if %use_path% equ %TRUE% (
    gpc --version 2> nul > nul || (
        if %use_suppress% equ %FALSE% (
            setlocal enabledelayedexpansion
            choice /m "Do you want to automatically add GNU pascal compiler to PATH"
            set /a "key=!errorlevel!"
            if !key! equ 1 (
                setx PATH "%default_path_to_compiler%;%PATH%" 2> nul > nul
                echo %SHELL_RESTART_REQUIRED_MSG%
                exit /b %SHELL_RESTART_REQUIRED_EC%
            )
            endlocal
        )
        echo %COMPILER_NOT_FOUND_MSG%
        exit /b %COMPILER_NOT_FOUND_EC%
    )
    gpc "%path_to_file%" -o "%path_to_out_file%" %compiler_options%
) else (
    if not exist "%path_to_compiler%" (
        echo %COMPILER_NOT_FOUND_MSG%
        exit /b %COMPILER_NOT_FOUND_EC%
    )
    cd "%path_to_compiler%"
    gpc "%path_to_file%" -o "%path_to_out_file%" %compiler_options%
)

exit /b %SUCCESS_EC%

:init
    set /a "SUCCESS_EC=0"
    set /a "WRONG_FILE_PASSED_EC=1"
    set /a "COMPILER_NOT_FOUND_EC=2"
    set /a "SHELL_RESTART_REQUIRED_EC=3"

    set "WRONG_FILE_PASSED_MSG=None file passed or it is not found."
    set "COMPILER_NOT_FOUND_MSG=GNU Pascal compiler is not found."
    set "SHELL_RESTART_REQUIRED_MSG=You have to restart your shell to apply changes to PATH."

    set /a "TRUE=0"
    set /a "FALSE=1"

    set /a "use_path=TRUE"
    set /a "use_suppress=FALSE"
    set "default_path_to_compiler=C:\dev_gpc\bin\"
exit /b %SUCCESS_EC%

:help
    echo Simplifies access to GNU Pascal compiler.
    echo.
    echo Syntax:
    echo    compiler [options] pathToFile [pathToOutFile] [-- [compilerOptions]]
    echo.
    echo Options:
    echo    -h^|--help^|/h^|/help - writes help and exits
    echo    -v^|--version^|/v^|/version - writes version and exits
    echo    -p^|--path^|/p^|/path - specifies path to GNU Pascal compiler
    echo    ! - suppress prompts to change PATH variable
    echo.
    echo Examples:
    echo    compiler --version
    echo    compiler test.pas test.exe
    echo    compiler --path path-to-compiler test.pas test.exe
    echo.
    echo Notes:
    echo    Optimization, pointer arithmetic and GNU Pascal extensions are enabled by default.
    echo    It means that -O3, --pointer-arithmetic, --gnu-pascal compiler options are passed by default.
    echo.
    echo Author:
    echo    Alvin Seville ^<AlvinSeville7cf@gmail.com^>
exit /b %SUCCESS_EC%

:version
    echo 1.0 ^(c^) 2021 year
exit /b %SUCCESS_EC%
