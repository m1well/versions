#!/bin/bash
###
#title                  :versions.sh
#description            :This script provides your tool versions.
#author                 :Michael Wellner (@m1well) twitter.m1well.de
#date of creation       :20171130
#date of last change    :20180307
#version                :1.0.0
#usage                  :versions.sh
#notes                  :it would be most suitable to create an alias
###
### colors and linebreak ###
BR="\n"
FONT_CYAN="\033[0;96m"
FONT_NONE="\033[0m"
### output ###
line="#######################################################"
header="############## versions (alphabetically) ##############"
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
  printf "${line}${BR}"
  printf "${header}${BR}"
  printf "${line}${BR}"
  printf "${FONT_NONE}"
}
printEndLines() {
  printf "${FONT_CYAN}"
  printf "${line}${BR}"
  printf "${FONT_NONE}"
}
getOsVersion() {
  local os=""
  # check if windows
  os="$(echo $(systeminfo 2>&1 | grep -i 'Betriebssystemname' | tr -s " " | sed 's/Betriebssystemname: //g'))"
  if [ "${os}" != "" ] ; then
    echo "${os}"
  else
    # check if macos
    os="$(echo $(system_profiler SPSoftwareDataType 2>&1 | grep -i 'System Version:' | tr -s " " | sed 's/System Version: //g' | cut -d " " -f 2,3))"
    if [ "${os}" != "" ] ; then
      echo "${os}"
    else
      # check if linux
      os="$(echo $(uname -a 2>&1 | grep -i 'Linux' | cut -d " " -f 1,3))"
      if [ "${os}" != "" ] ; then
        echo "${os}"
      else
        echo "-"
      fi
    fi
  fi
}
printOsVersion() {
  local os=$(getOsVersion)
  if [ "${os}" != "-" ] ; then
    printf "os:                   "
    printf "${os}"
    printf "${BR}"
    printf "# --------------------------------------------------"
    printf "${BR}"
  fi
}
printAngularCliVersion() {
  local version=""
  if isCommandAvailable "ng" ; then
    version="$(echo $(ng -v | grep -i 'Angular' | cut -d " " -f 3))"
    if isThisStringVersionNumber "${version}" ; then
      printf "angular cli:          "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printAtomVersion() {
  local version=""
  if isCommandAvailable "atom" ; then
    version="$(echo $(atom -v | grep -i 'Atom   ' | tr -s " " | cut -d ":" -f 2))"
    if isThisStringVersionNumber "${version}" ; then
      printf "atom:                 "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printBashVersion() {
  local version=""
  if isCommandAvailable "bash" ; then
    version="$(echo $(bash --version | grep -i 'bash' | cut -d " " -f 4))"
    if isThisStringVersionNumber "${version}" ; then
      printf "bash:                 "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printCloudFoundryCliVersion() {
  local version=""
  if isCommandAvailable "cf" ; then
    version="$(echo $(cf -v | grep -i 'cf version' | cut -d " " -f 3))"
    if isThisStringVersionNumber "${version}" ; then
      printf "cloundfoundry cli:    "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printDockerVersion() {
  local version=""
  if isCommandAvailable "docker" ; then
    version="$(echo $(docker -v | grep -i 'Docker version' | cut -d " " -f 3 | sed 's/\,/ /g'))"
    if isThisStringVersionNumber "${version}" ; then
      printf "docker:               "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printGitVersion() {
  local version=""
  if isCommandAvailable "git" ; then
    version="$(echo $(git --version | cut -d " " -f 3))"
    if isThisStringVersionNumber "${version}" ; then
      printf "git:                  "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printGradleVersion() {
  local version=""
  if isCommandAvailable "gradle" ; then
    version="$(echo $(gradle -v | grep -i 'Gradle' | cut -d " " -f 2))"
    if isThisStringVersionNumber "${version}" ; then
      printf "gradle:               "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printGulpVersion() {
  local version=""
  if isCommandAvailable "gulp" ; then
    version="$(echo $(gulp -v | grep -i 'CLI version' | cut -d " " -f 4))"
    if isThisStringVersionNumber "${version}" ; then
      printf "gulp:                 "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printHomebrewVersion() {
  local version=""
  if isCommandAvailable "brew" ; then
    version="$(echo $(brew -v | grep -i 'Homebrew ' | cut -d " " -f 2))"
    if isThisStringVersionNumber "${version}" ; then
      printf "Homebrew:             "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printJavaVersion() {
  local version=""
  if isCommandAvailable "java" ; then
    version="$(echo $(java -version 2>&1 | grep -i 'version' | cut -d " " -f 3 | sed 's/\"/ /g'))"
    if isThisStringVersionNumber "${version}" ; then
      printf "java:                 "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printJHipsterVersion() {
  local version=""
  if isCommandAvailable "jhipster" ; then
    version="$(echo $(jhipster --version | cut -d " " -f 6))"
    if isThisStringVersionNumber "${version}" ; then
      printf "jhipster:             "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printMakeVersion() {
  local version=""
  if isCommandAvailable "make" ; then
    version="$(echo $(make -v | grep -i 'Make' | cut -d " " -f 3))"
    if isThisStringVersionNumber "${version}" ; then
      printf "make:                 "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printMavenVersion() {
  local version=""
  if isCommandAvailable "mvn" ; then
    version="$(echo $(mvn -v | grep -i 'Apache Maven' | cut -d " " -f 3))"
    if isThisStringVersionNumber "${version}" ; then
      printf "maven:                "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printNpmVersion() {
  local version=""
  if isCommandAvailable "npm" ; then
    version="$(echo $(echo "npmversion" $(npm -v) | grep -i "npmversion" | cut -d " " -f 2))"
    if isThisStringVersionNumber "${version}" ; then
      printf "npm:                  "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printNodeVersion() {
  local version=""
  if isCommandAvailable "node" ; then
    version="$(echo $(node -v | cut -d "v" -f 2))"
    if isThisStringVersionNumber "${version}" ; then
      printf "node:                 "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printSpringCliVersion() {
  local version=""
  if isCommandAvailable "spring" ; then
    version="$(echo $(spring --version | grep -i 'CLI' | cut -d " " -f 3 | cut -d "v" -f 2))"
    if isThisStringVersionNumber "${version}" ; then
      printf "spring cli:           "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printYarnVersion() {
  local version=""
  if isCommandAvailable "yarn" ; then
    version="$(echo $(yarn -v | cut -d "v" -f 2))"
    if isThisStringVersionNumber "${version}" ; then
      printf "yarn:                 "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printYeomanVersion() {
  local version=""
  if isCommandAvailable "yo" ; then
    version="$(echo $(yo --version))"
    if isThisStringVersionNumber "${version}" ; then
      printf "yeoman:               "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}
printZshVersion() {
  local version=""
  if isCommandAvailable "zsh" ; then
    version="$(echo $(zsh --version | grep -i 'zsh' | cut -d " " -f 2))"
    if isThisStringVersionNumber "${version}" ; then
      printf "zsh:                  "
      printf "${version}"
      printf "${BR}"
    fi
  fi
}

### start of script ###
printStartLines
printOsVersion
printAngularCliVersion
printAtomVersion
printBashVersion
printCloudFoundryCliVersion
printDockerVersion
printGitVersion
printGradleVersion
printGulpVersion
printHomebrewVersion
printJavaVersion
printJHipsterVersion
printMakeVersion
printMavenVersion
printNpmVersion
printNodeVersion
printSpringCliVersion
printYarnVersion
printYeomanVersion
printZshVersion
printEndLines

### end of script ###
#####################
