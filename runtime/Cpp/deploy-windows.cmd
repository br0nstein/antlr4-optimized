@echo off

rem Clean left overs from previous builds if there are any
if exist bin rmdir /S /Q runtime\bin
if exist obj rmdir /S /Q runtime\obj
if exist lib rmdir /S /Q lib
if exist antlr4-runtime rmdir /S /Q antlr4-runtime
if exist antlr4-cpp-runtime-vs2017.zip erase antlr4-cpp-runtime-vs2017.zip
if exist antlr4-cpp-runtime-vs2019.zip erase antlr4-cpp-runtime-vs2019.zip

rem Headers
xcopy runtime\src\*.h antlr4-runtime\ /s

rem Binaries
if exist "C:\Program Files (x86)\Microsoft Visual Studio 15.0\Common7\Tools\VsDevCmd.bat" (
  call "C:\Program Files (x86)\Microsoft Visual Studio 15.0\Common7\Tools\VsDevCmd.bat"

  pushd runtime
  msbuild antlr4cpp-vs2017.vcxproj /p:configuration="Release DLL" /p:platform=Win32
  msbuild antlr4cpp-vs2017.vcxproj /p:configuration="Release DLL" /p:platform=x64
  popd
  
  7z a antlr4-cpp-runtime-vs2017.zip antlr4-runtime
  xcopy runtime\bin\*.dll lib\ /s
  xcopy runtime\bin\*.lib lib\ /s
  7z a antlr4-cpp-runtime-vs2017.zip lib
  
  rmdir /S /Q lib
  rmdir /S /Q runtime\bin
  rmdir /S /Q runtime\obj
  
  rem if exist antlr4-cpp-runtime-vs2017.zip copy antlr4-cpp-runtime-vs2017.zip ~/antlr/sites/website-antlr4/download
)

if exist "C:\Program Files (x86)\Microsoft Visual Studio 16.0\Common7\Tools\VsDevCmd.bat" (
  call "C:\Program Files (x86)\Microsoft Visual Studio 16.0\Common7\Tools\VsDevCmd.bat"

  pushd runtime
  msbuild antlr4cpp-vs2019.vcxproj /p:configuration="Release DLL" /p:platform=Win32
  msbuild antlr4cpp-vs2019.vcxproj /p:configuration="Release DLL" /p:platform=x64
  popd
  
  7z a antlr4-cpp-runtime-vs2019.zip antlr4-runtime
  xcopy runtime\bin\*.dll lib\ /s
  xcopy runtime\bin\*.lib lib\ /s
  7z a antlr4-cpp-runtime-vs2019.zip lib
  
  rmdir /S /Q lib
  rmdir /S /Q runtime\bin
  rmdir /S /Q runtime\obj
  
  rem if exist antlr4-cpp-runtime-vs2019.zip copy antlr4-cpp-runtime-vs2019.zip ~/antlr/sites/website-antlr4/download
)

rmdir /S /Q antlr4-runtime

:end
