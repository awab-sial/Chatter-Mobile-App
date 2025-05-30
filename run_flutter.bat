@echo off
set JAVA_HOME=C:\Users\dell\Downloads\OpenJDK17U-jdk_ppc64_aix_hotspot_17.0.15_6\jdk-17.0.15+6
set PATH=%JAVA_HOME%\bin;%PATH%

echo Java home is set to %JAVA_HOME%
java -version

flutter clean
flutter pub get
flutter run

pause
