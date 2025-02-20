set WORKSPACE=..
set LUBAN_TOOL=%WORKSPACE%\addons\luban_godot\LubanTool
set LUBAN_DLL=%WORKSPACE%\addons\luban_godot\LubanTool\Luban\Luban.dll
set CONF_ROOT=%WORKSPACE%\_excel
set POSTPROCESS=%WORKSPACE%\addons\luban_godot\LubanTool\post_process.py
set GEN_DIR=%WORKSPACE%\data
set SRC=%WORKSPACE%


dotnet %LUBAN_DLL% ^
    -t all ^
    -c gdscript-json ^
    -d json  ^
    --conf %CONF_ROOT%\luban.conf ^
    -x outputCodeDir=%GEN_DIR%\_raw_gen ^
    -x outputDataDir=%GEN_DIR%\json ^
    -x tableImporter.name=default ^
    -x pathValidator.rootDir=%SRC%


pause
