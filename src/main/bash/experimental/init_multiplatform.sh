#!/usr/local/bin/bash

VERSION_KOTLIN='2.2.21'
VERSION_AGP='8.13.2'
VERSION_COMPILE_SDK='36'
VERSION_MIN_SDK='28'
VERSION_JVM_TARGET='17'
VERSION_COMPOSE='1.9.3'
VERSION_GRADLEX='0.1.0'

#

echo 'Enter project name:'
read -r PROJECT_NAME

echo 'Enter project namespace:'
read -r PROJECT_NAMESPACE

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
!/android
!/buildSrc
!/desktop
!/shared
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

include(\"android\", \"desktop\")
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

mkdir -p 'buildSrc/src/main/kotlin'

#

ISSUER='buildSrc/.gitignore'

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

ISSUER="buildSrc/build.gradle.kts"

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
repositories.mavenCentral()

plugins {
    \`kotlin-dsl\`
}

dependencies {
    implementation(\"com.github.kepocnhh:Gradlex:${VERSION_GRADLEX}\")
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

ISSUER="buildSrc/src/main/kotlin/Version.kt"

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
object Version {
    const val compose = \"${VERSION_COMPOSE}\"
    const val jvmTarget = \"${VERSION_JVM_TARGET}\"
    const val kotlin = \"${VERSION_KOTLIN}\"

    object Android {
        const val compileSdk = ${VERSION_COMPILE_SDK}
        const val minSdk = ${VERSION_MIN_SDK}
        const val targetSdk = compileSdk
    }
}
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
import sp.kx.gradlex.buildDir
import sp.kx.gradlex.buildSrc

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
    delete = setOf(buildDir(), buildSrc.buildDir())
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

mkdir -p 'desktop'

#

ISSUER='desktop/.gitignore'

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

ISSUER='desktop/gradle.properties'

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
buildType=debug
specifics=real
platform=macos
arch=arm64
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

ISSUER="desktop/build.gradle.kts"

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
import org.jetbrains.compose.desktop.application.dsl.TargetFormat
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

repositories {
    google()
    mavenCentral()
}

plugins {
    id(\"org.jetbrains.kotlin.jvm\")
    id(\"org.jetbrains.compose\") version Version.compose
    id(\"org.jetbrains.kotlin.plugin.compose\") version Version.kotlin
}

val buildType by properties
val specifics by properties
val platform by properties
val arch by properties

sourceSets {
    getByName(\"main\") {
        kotlin.srcDirs(\"../shared/src/\$name/kotlin\")
        setOf(buildType, specifics).forEach { name ->
            kotlin.srcDirs(\"src/\$name/kotlin\")
            kotlin.srcDirs(\"../shared/src/\$name/kotlin\")
        }
    }
}

tasks.getByName<JavaCompile>(\"compileJava\") {
    targetCompatibility = Version.jvmTarget
}

tasks.getByName<KotlinCompile>(\"compileKotlin\") {
    compilerOptions.jvmTarget = JvmTarget.fromTarget(Version.jvmTarget)
}

compose.desktop {
    application {
        mainClass = \"${PROJECT_NAMESPACE}.AppKt\"
    }
}

dependencies {
    when (val entry = Pair(platform, arch)) {
        \"macos\" to \"arm64\" -> {
            implementation(compose.desktop.macos_arm64)
        }
        else -> {
            val (platform, arch) = entry
            error(\"Platform \\\"\$platform(\$arch)\\\" is not supported!\")
        }
    }
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

mkdir -p "desktop/src/main/kotlin/${PROJECT_NAMESPACE//.///}"

#

ISSUER="desktop/src/main/kotlin/${PROJECT_NAMESPACE//.///}/App.kt"

if test -f "${ISSUER}"; then
 echo "File \"${ISSUER}\" exists!"; exit 1; fi

echo -n "\
package ${PROJECT_NAMESPACE}

import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application

internal object App {
    init {
        // todo
    }
}

fun main() {
    application {
        Window(onCloseRequest = ::exitApplication, title = \"${PROJECT_NAME}\") {
            // todo
        }
    }
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

mkdir -p 'android'

#

ISSUER='android/.gitignore'

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

ISSUER='android/build.gradle.kts'

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
    id(\"org.jetbrains.compose\") version Version.compose
    id(\"org.jetbrains.kotlin.plugin.compose\") version Version.kotlin
}

android {
    namespace = \"${PROJECT_NAMESPACE}\"
    compileSdk = Version.Android.compileSdk

    defaultConfig {
        applicationId = namespace
        minSdk = Version.Android.minSdk
        targetSdk = Version.Android.targetSdk
        versionCode = 1
        versionName = \"0.0.1\"
    }

    buildTypes {
        getByName(\"debug\") {
            sourceSets.getByName(name) {
                kotlin.srcDirs(\"../shared/src/\$name/kotlin\")
            }
            applicationIdSuffix = \".\$name\"
            versionNameSuffix = \"-\$name\"
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    sourceSets.getByName(\"main\") {
        kotlin.srcDirs(\"../shared/src/\$name/kotlin\")
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
            compilerOptions.jvmTarget = JvmTarget.fromTarget(Version.jvmTarget)
        }
    }
}

dependencies {
    implementation(compose.foundation)
    implementation(\"androidx.activity:activity-compose:1.12.4\")
}
" > "${ISSUER}"

if [[ ! -f "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!"; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!"; exit 1
fi

#

echo 'Not implemented!'; exit 1 # todo
