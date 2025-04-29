buildscript {
    repositories {
        google() // 必须包含
        mavenCentral() // 必须包含
        maven { url = uri("https://maven.aliyun.com/repository/public") } // 可选，用于加速
        maven { url = uri("https://maven.aliyun.com/repository/google") } // 可选，用于加速
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.6.0") // 降级到 8.6.0
    }
}

allprojects {
    repositories {
        google() // 必须包含
        mavenCentral() // 必须包含
        maven { url = uri("https://maven.aliyun.com/repository/public") } // 可选
        maven { url = uri("https://maven.aliyun.com/repository/google") } // 可选

    }

}


val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
