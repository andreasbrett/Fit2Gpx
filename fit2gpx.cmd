@echo off

REM iterate over passed arguments
for %%x in (%*) do (

	if exist %%x\ (
		call:processFolder %%x
	) else if exist %%x (
		call:processFile %%x
	)

)

goto:eof







::--------------------------------------------------------
::-- Function section starts below here
::--------------------------------------------------------

:processFolder
pushd %~1
for /f "tokens=* delims=/" %%f in ('dir *.fit /b 2^> nul') do (
	"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -t -i garmin_fit -f "%%f" -o gpx,suppresswhite=0,logpoint=0,humminbirdextensions=0,garminextensions=1 -F "%%~nf.gpx"
)
popd
goto:eof


:processFile
"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -t -i garmin_fit -f "%~1" -o gpx,suppresswhite=0,logpoint=0,humminbirdextensions=0,garminextensions=1 -F "%~n1.gpx"
goto:eof
