#!/usr/local/bin/bash

VERSION_KOTLIN='2.2.21'

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
!/app
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

include(\"app\")
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

#

mkdir app

#

ISSUER='app/.gitignore'

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
/*
!/src
!.gitignore
!build.gradle.kts
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

echo 'Enter project namespace:'
read -r PROJECT_NAMESPACE

#

ISSUER='app/build.gradle.kts'

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
repositories.mavenCentral()

plugins {
    kotlin(\"jvm\")
}

tasks.register<JavaExec>(\"run\") {
    classpath = sourceSets[\"main\"].runtimeClasspath
    mainClass = \"${PROJECT_NAMESPACE}.AppKt\"
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

mkdir -p "app/src/main/kotlin/${PROJECT_NAMESPACE//.///}"

#

ISSUER="app/src/main/kotlin/${PROJECT_NAMESPACE//.///}/App.kt"

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
package ${PROJECT_NAMESPACE}

fun main() {
    println(\"Hello ${PROJECT_NAME}!\")
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi
