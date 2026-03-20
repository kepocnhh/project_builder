#!/usr/local/bin/bash

VERSION_KOTLIN='1.9.25'

#

echo 'Enter project name:'
read -r PROJECT_NAME

#

mkdir '.excluded'
mkdir '.excluded/json'
mkdir '.excluded/md'
mkdir '.excluded/sh'
mkdir '.excluded/txt'

#

ISSUER='.gitignore'

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
/*
!/lib
!.gitignore
!build.gradle.kts
!settings.gradle.kts
!README.md
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

ISSUER='settings.gradle.kts'

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
rootProject.name = \"$PROJECT_NAME\"

include(\"lib\")
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

ISSUER='build.gradle.kts'

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
buildscript {
    repositories.mavenCentral()

    dependencies {
        classpath(\"org.jetbrains.kotlin:kotlin-gradle-plugin:${VERSION_KOTLIN}\")
    }
}

tasks.register<Delete>(\"clean\") {
    delete = setOf(\"build\")
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

echo 'Not implemented!'; exit 1 # todo
