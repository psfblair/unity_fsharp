# Unity F# Infrastructure

These are files intended to be added to a Unity project to assist with
building Unity apps in F#. 

The script `copy_post_build` (and the Windows equivalent) is intended to
be added as an "after build" step to copy the built dll and the FSharp.Core 
dll to the Assets/Plugins directory of the Unity project. The script will
also copy the dlls to another location (if it exists); this is intended
for putting the dlls into a mounted remote directory for building on a
remote server.

The project contains an empty Assets/Plugins directory to indicate that
this directory needs to be created in your project.

There is also a .gitignore included that is useful for Unity F# projects.

## Prerequisites

The `GameLogic` folder is intended to be added at the root of your Unity
project and to hold your F# projects.

The script assumes that it is located in the `GameLogic` directory. The
"after build" step should call

    "${SolutionDir}/copy_post_build" "${TargetDir}" "${TargetFile}"

(The slash may need to be reversed if you're on Windows; if you leave
the Unix `copy_post_build` script in the directory you will also need
to include the `.bat` suffix to avoid a name collision.)

If you want to copy to a second directory besides Assets/Plugins, set
the `REMOTE_PLUGINS_DIR` variable in `copy_post_build_config.sh` or 
`copy_post_build_config.bat`, as is shown in the *.sample files. Note 
that the main script actually calls out to the config script (since the 
main script may be run from an IDE) so you'll need to put 
`copy_post_build_config.sh` or `copy_post_build_config.bat` in the 
same directory with the script.

To build for Unity, as of Unity 5.6 if you want to run in the editor you
still need to target .NET 3.5 in your build settings. In addition, you 
need to reference the F# 2.0 FSharp.Core.dll and the associated mscorlib.dll.
(If you are on mono, these are not installed with recent mono versions; 
however, Unity should have installed a 3.x version where you can find 
and reference these libraries -- the mscorlib is under `/lib/mono/2.0-api/mscorlib.dll`
or in older versions under `/lib/mono/2.0/mscorlib.dll`, and the FSharp.Core.dll 
is under `/lib/mono/2.0/FSharp.Core.dll`.)
