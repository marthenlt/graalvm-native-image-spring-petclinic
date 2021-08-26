#!/usr/bin/env bash

ARTIFACT=petclinic-jpa
MAINCLASS=org.springframework.samples.petclinic.PetClinicApplication
VERSION=0.0.1-SNAPSHOT

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

rm -rf target
mkdir -p target/native-image

echo "Packaging $ARTIFACT with Maven"
./mvnw -ntp package -DskipTests > target/native-image/output.txt

JAR="$ARTIFACT-$VERSION.jar"
rm -f $ARTIFACT
echo "Unpacking $JAR"
cd target/native-image
jar -xvf ../$JAR >/dev/null 2>&1
cp -R META-INF BOOT-INF/classes

LIBPATH=`find BOOT-INF/lib | tr '\n' ':'`
CP=BOOT-INF/classes:$LIBPATH

GRAALVM_VERSION=`native-image --version`
echo "Compiling $ARTIFACT with $GRAALVM_VERSION"
{ time native-image \
<<<<<<< HEAD
=======
  -H:+StaticExecutableWithDynamicLibC \
>>>>>>> 0e81fc875d7bc63c8e28034973f56a4742359dfa
  -H:+ReportExceptionStackTraces \
  --enable-all-security-services \
  -H:IncludeResourceBundles=oracle.net.jdbc.nl.mesg.NLSR,oracle.net.mesg.Message \
  --allow-incomplete-classpath \
	--initialize-at-build-time=oracle.net.jdbc.nl.mesg.NLSR_en \
	--initialize-at-build-time=oracle.jdbc.driver.DynamicByteArray,oracle.sql.ConverterArchive,oracle.sql.converter.CharacterConverterJDBC,oracle.sql.converter.CharacterConverter1Byte \
	--initialize-at-run-time=java.sql.DriverManager \
  --initialize-at-build-time=java.awt.Toolkit \
  --initialize-at-build-time=sun.awt.AWTAccessor \
  --no-fallback \
  --report-unsupported-elements-at-runtime \
  --install-exit-handlers \
  --no-server \
  --verbose \
  -H:Name=$ARTIFACT \
  -Dspring.native.remove-yaml-support=true \
  --enable-all-security-services \
  -cp $CP $MAINCLASS >> output.txt ; } 2>> output.txt

if [[ -f $ARTIFACT ]]
then
  printf "${GREEN}SUCCESS${NC}\n"
  mv ./$ARTIFACT ..
  exit 0
else
  cat output.txt
  printf "${RED}FAILURE${NC}: an error occurred when compiling the native-image.\n"
  exit 1
fi

