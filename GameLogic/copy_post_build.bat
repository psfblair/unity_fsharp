#!/bin/sh

REM Set REMOTE_PLUGINS_DIR in copy_post_build_config.bat if you have a second directory
REM to which you want to copy the dlls (besides the Assets/Plugins directory).
IF EXIST copy_post_build_config.bat CALL copy_post_build_config.bat

SET TARGET_DIR="%~f1"
SET TARGET_FILE="%2"

SET MY_DIR=%~dp0
SET LOCAL_PLUGINS_DIR="$MY_DIR\..\Assets\Plugins"

COPY /Y /B "%TARGET_FILE%" "%LOCAL_PLUGINS_DIR%"
COPY /Y /B "%TARGET_DIR%\FSharp.Core.dll" "%LOCAL_PLUGINS_DIR%"

IF EXIST "%REMOTE_PLUGINS_DIR%" (
    COPY /Y /B "%TARGET_FILE%" "%REMOTE_PLUGINS_DIR%"
    COPY /Y /B "%TARGET_DIR%\FSharp.Core.dll" "%REMOTE_PLUGINS_DIR%"
)
ELSE echo "Remote plugin directory not mounted."

