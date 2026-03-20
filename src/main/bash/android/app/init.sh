#!/usr/local/bin/bash

VERSION_KOTLIN='2.2.21'
VERSION_AGP='8.13.2'
VERSION_COMPILE_SDK='36'
VERSION_MIN_SDK='28'

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
!gradle.properties
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
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath(\"com.android.tools.build:gradle:${VERSION_AGP}\")
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

ISSUER='gradle.properties'

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
android.useAndroidX=true
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
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

repositories {
    google()
    mavenCentral()
}

plugins {
    id(\"com.android.application\")
    id(\"kotlin-android\")
}

android {
    namespace = \"${PROJECT_NAMESPACE}\"
    compileSdk = ${VERSION_COMPILE_SDK}

    defaultConfig {
        applicationId = namespace
        minSdk = ${VERSION_MIN_SDK}
        targetSdk = compileSdk
        versionCode = 1
        versionName = \"0.0.1\"
    }

    buildTypes {
        getByName(\"debug\") {
            applicationIdSuffix = \".\$name\"
            versionNameSuffix = \"-\$name\"
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    buildFeatures.buildConfig = true

    compileOptions {
        targetCompatibility = JavaVersion.VERSION_17
        sourceCompatibility = JavaVersion.VERSION_17
    }
}

androidComponents.onVariants { variant ->
    val output = variant.outputs.single()
    check(output is com.android.build.api.variant.impl.VariantOutputImpl)
    output.outputFileName = \"\${rootProject.name}-\${output.versionName.get()}-\${output.versionCode.get()}.apk\"
    afterEvaluate {
        tasks.getByName<KotlinCompile>(\"compile\${variant.name.replaceFirstChar(Character::toUpperCase)}Kotlin\") {
            compilerOptions.jvmTarget = JvmTarget.fromTarget(\"17\")
        }
    }
}

dependencies {
    implementation(\"androidx.activity:activity:1.12.4\")
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

ISSUER='app/src/main/AndroidManifest.xml'

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
<manifest xmlns:android=\"http://schemas.android.com/apk/res/android\">
    <application
        android:label=\"${PROJECT_NAME}\"
        android:name=\".App\">
        <activity android:name=\".MainActivity\"
            android:screenOrientation=\"portrait\"
            android:exported=\"true\">
            <intent-filter>
                <action android:name=\"android.intent.action.MAIN\"/>
                <category android:name=\"android.intent.category.LAUNCHER\"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

ISSUER="app/src/main/kotlin/${PROJECT_NAMESPACE//.///}/App.kt"

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
package ${PROJECT_NAMESPACE}

import android.app.Application

internal class App : Application() {
    override fun onCreate() {
        // todo
    }
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

ISSUER="app/src/main/kotlin/${PROJECT_NAMESPACE//.///}/MainActivity.kt"

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
package ${PROJECT_NAMESPACE}

import android.os.Bundle
import androidx.activity.ComponentActivity

internal class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // todo
    }
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

echo 'Not implemented!'; exit 1 # todo
