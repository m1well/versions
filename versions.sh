#!/bin/bash
###
#title                  :versions.sh
#description            :This script provides your tool versions.
#author                 :Michael Wellner (@m1well) twitter.m1well.de
#date of creation       :20171130
#date of last change    :20180421
#version                :2.0.1
#usage                  :versions.sh
#notes                  :it would be most suitable to create an alias
###

### constants ###
BR="\n"
FONT_CYAN="\033[0;96m"
FONT_NONE="\033[0m"
TAB=24
LINE="#######################################################"
HEADER="############## versions (alphabetically) ##############"

### helper ###
isCommandAvailable () {
  if command -v "$1" >/dev/null; then return 0 ; fi
  return 1
}
isThisStringVersionNumber() {
   if [[ "${1}" =~ [0-9]+\.[0-9]+\.* ]] ; then return 0 ; fi
   return 1
}
printStartLines() {
  printf "${FONT_CYAN}"
  printf "${LINE}${BR}"
  printf "${HEADER}${BR}"
  printf "${LINE}${BR}"
  printf "${FONT_NONE}"
}
printEndLines() {
  printf "${FONT_CYAN}"
  printf "${LINE}${BR}"
  printf "${FONT_NONE}"
}

### print versions ###
printOsVersion() {
  if [ "${1}" != "-" ] ; then
    printf "${1}:"
    spaces=$((${TAB}-${#1}))
    for (( c=1; c<=${spaces}; c++ )); do
      printf " "
    done
    printf "${2}"
    printf "${BR}"
    printf "# -----------------------------------------------------"
    printf "${BR}"
  fi
}
printToolVersion() {
  if isThisStringVersionNumber "${2}" ; then
    printf "${1}:"
    spaces=$((${TAB}-${#1}))
    for (( c=1; c<=${spaces}; c++ )); do
      printf " "
    done
    printf "${2}"
    printf "${BR}"
  fi
}

### get versions ###
getOsVersion() {
  local osversion=""
  # check if windows
  osversion="$(echo $(systeminfo 2>&1 | grep -i 'Betriebssystemname' | tr -s " " | sed 's/Betriebssystemname: //g'))"
  if [ "${osversion}" != "" ] ; then
    printOsVersion "os" "${osversion}"
  else
    # check if macos
    osversion="$(echo $(system_profiler SPSoftwareDataType 2>&1 | grep -i 'System Version:' | tr -s " " | sed 's/System Version: //g' | cut -d " " -f 2,3))"
    if [ "${osversion}" != "" ] ; then
      printOsVersion "os" "${osversion}"
    else
      # check if linux
      osversion="$(echo $(uname -a 2>&1 | grep -i 'Linux' | cut -d " " -f 1,3))"
      if [ "${osversion}" != "" ] ; then
        printOsVersion "os" "${osversion}"
      else
        # do nothing here
        echo "-"
      fi
    fi
  fi
}
getAngularCliVersion() {
  local tool="angular cli"
  if isCommandAvailable "ng" ; then
    version="$(echo $(ng -v | grep -i 'Angular' | cut -d " " -f 3))"
    printToolVersion "${tool}" "${version}"
  fi
}
getAtomVersion() {
  local tool="atom"
  if isCommandAvailable "atom" ; then
    version="$(echo $(atom -v | grep -i 'Atom   ' | tr -s " " | cut -d ":" -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}
getBashVersion() {
  local tool="bash"
  if isCommandAvailable "bash" ; then
    version="$(echo $(bash --version | grep -i 'bash' | cut -d " " -f 4))"
    printToolVersion "${tool}" "${version}"
  fi
}
getCloudFoundryCliVersion() {
  local tool="cloundfoundry cli"
  if isCommandAvailable "cf" ; then
    version="$(echo $(cf -v | grep -i 'cf version' | cut -d " " -f 3))"
    printToolVersion "${tool}" "${version}"
  fi
}
getDockerVersion() {
  local tool="docker"
  if isCommandAvailable "docker" ; then
    version="$(echo $(docker -v | grep -i 'Docker version' | cut -d " " -f 3 | sed 's/\,/ /g'))"
    printToolVersion "${tool}" "${version}"
  fi
}
getGitVersion() {
  local tool="git"
  if isCommandAvailable "git" ; then
    local version="$(echo $(git --version | cut -d " " -f 3))"
    printToolVersion "${tool}" "${version}"
  fi
}
getGoogleCloudSdkVersion() {
  local tool="google cloud sdk"
  if isCommandAvailable "gcloud" ; then
    version="$(echo $(gcloud version | grep -i 'Google Cloud SDK' | cut -d " " -f 4))"
    printToolVersion "${tool}" "${version}"
  fi
}
getGradleVersion() {
  local tool="gradle"
  if isCommandAvailable "gradle" ; then
    version="$(echo $(gradle -v | grep -i 'Gradle' | cut -d " " -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}
getGroovyVersion() {
  local tool="groovy"
  if isCommandAvailable "groovy" ; then
    version="$(echo $(groovy -v | cut -d " " -f 3))"
    printToolVersion "${tool}" "${version}"
  fi
}
getGulpVersion() {
  local tool="gulp"
  if isCommandAvailable "gulp" ; then
    version="$(echo $(gulp -v | grep -i 'CLI version' | cut -d " " -f 4))"
    printToolVersion "${tool}" "${version}"
  fi
}
getHomebrewVersion() {
  local tool="homebrew"
  if isCommandAvailable "brew" ; then
    version="$(echo $(brew -v | grep -i 'Homebrew ' | cut -d " " -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}
getJavaVersion() {
  local tool="java"
  if isCommandAvailable "java" ; then
    version="$(echo $(java -version 2>&1 | grep -i 'version' | cut -d " " -f 3 | sed 's/\"/ /g'))"
    printToolVersion "${tool}" "${version}"
  fi
}
getJHipsterVersion() {
  local tool="jhipster"
  if isCommandAvailable "jhipster" ; then
    version="$(echo $(jhipster --version | cut -d " " -f 6))"
    printToolVersion "${tool}" "${version}"
  fi
}
getMakeVersion() {
  local tool="make"
  if isCommandAvailable "make" ; then
    version="$(echo $(make -v | grep -i 'Make' | cut -d " " -f 3))"
    printToolVersion "${tool}" "${version}"
  fi
}
getMavenVersion() {
  local tool="maven"
  if isCommandAvailable "mvn" ; then
    version="$(echo $(mvn -v | grep -i 'Apache Maven' | cut -d " " -f 3))"
    printToolVersion "${tool}" "${version}"
  fi
}
getNpmVersion() {
  local tool="npm"
  if isCommandAvailable "npm" ; then
    version="$(echo $(echo "npmversion" $(npm -v) | grep -i "npmversion" | cut -d " " -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}
getNodeVersion() {
  local tool="node"
  if isCommandAvailable "node" ; then
    version="$(echo $(node -v | cut -d "v" -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}
getRubyVersion() {
  local tool="ruby"
  if isCommandAvailable "ruby" ; then
    version="$(echo $(ruby -v | cut -d " " -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}
getSpringBootCliVersion() {
  local tool="springboot cli"
  if isCommandAvailable "spring" ; then
    version="$(echo $(spring --version | grep -i 'CLI' | cut -d " " -f 3 | cut -d "v" -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}
getYarnVersion() {
  local tool="yarn"
  if isCommandAvailable "yarn" ; then
    version="$(echo $(yarn -v | cut -d "v" -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}
getYeomanVersion() {
  local tool="yeoman"
  if isCommandAvailable "yo" ; then
    version="$(echo $(yo --version))"
    printToolVersion "${tool}" "${version}"
  fi
}
getZshVersion() {
  local tool="zsh"
  if isCommandAvailable "zsh" ; then
    version="$(echo $(zsh --version | grep -i 'zsh' | cut -d " " -f 2))"
    printToolVersion "${tool}" "${version}"
  fi
}

### start of script ###
printStartLines
getOsVersion
getAngularCliVersion
getAtomVersion
getBashVersion
getCloudFoundryCliVersion
getDockerVersion
getGitVersion
getGoogleCloudSdkVersion
getGradleVersion
getGroovyVersion
getGulpVersion
getHomebrewVersion
getJavaVersion
getJHipsterVersion
getMakeVersion
getMavenVersion
getNpmVersion
getNodeVersion
getSpringBootCliVersion
getRubyVersion
getYarnVersion
getYeomanVersion
getZshVersion
printEndLines

### end of script ###

#####################
