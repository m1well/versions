#!/bin/bash
###
#title                  :versions.sh
#description            :This script provides your tool versions.
#author                 :Michael Wellner (@m1well) twitter.m1well.de
#date of creation       :20171130
#date of last change    :20201224
#version                :2.5.0
#usage                  :versions.sh
#notes                  :it would be most suitable to create an alias
###

set -eu

### constants ###
BR="\n"
FONT_CYAN="\033[0;96m"
FONT_NONE="\033[0m"
TAB=22
LINE="#############################################################"
HEADER="################# versions (alphabetically) #################"

### helper ###
isCommandAvailable () {
  if [[ -x "$(command -v ${1})" ]] ; then return 0 ; fi
  return 1
}
isThisStringVersionNumber() {
   if [[ "${1}" =~ [0-9]+\.[0-9]+\.* ]] ; then
     return 0
   elif [[ "${1}" =~ [0-9] ]] ; then
     return 0
   fi
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
    printf " - ${1} <"
    spaces=$((${TAB}-${#1}-1))
    for (( c=1; c<=${spaces}; c++ )); do
      printf "-"
    done
    printf "> ${2} -"
    printf "${BR}"
    printf " -----------------------------------------------------------"
    printf "${BR}"
  fi
}
printToolVersion() {
  if isThisStringVersionNumber "${2}" ; then
    printf " - ${1} <"
    spaces=$((${TAB}-${#1}-1))
    for (( c=1; c<=${spaces}; c++ )); do
      printf "-"
    done
    printf "> ${2} -"
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
  if isCommandAvailable "ng" ; then
    printToolVersion "${1}" "$(echo $(ng --version 2>&1 | grep -i 'Angular CLI' | cut -d " " -f 3))"
  fi
}
getApacheBenchVersion() {
  if isCommandAvailable "ab" ; then
    printToolVersion "${1}" "$(echo $(ab -V 2>&1 | grep ApacheBench | cut -d " " -f 5))"
  fi
}
getAtomVersion() {
  if isCommandAvailable "atom" ; then
    printToolVersion "${1}" "$(echo $(atom -v 2>&1 | grep -i 'Atom   ' | tr -s " " | cut -d ":" -f 2))"
  fi
}
getAwsCliVersion() {
  if isCommandAvailable "aws" ; then
    printToolVersion "${1}" "$(echo $(aws --version 2>&1 | cut -d " " -f 1 | cut -d "/" -f 2))"
  fi
}
getBashVersion() {
  if isCommandAvailable "bash" ; then
    printToolVersion "${1}" "$(echo $(bash --version 2>&1 | grep -i 'bash' | cut -d " " -f 4))"
  fi
}
getCertbotVersion() {
  if isCommandAvailable "certbot" ; then
    printToolVersion "${1}" "$(echo $(certbot --version 2>&1 | cut -d " " -f 2))"
  fi
}
getCloudFoundryCliVersion() {
  if isCommandAvailable "cf" ; then
    printToolVersion "${1}" "$(echo $(cf -v 2>&1 | grep -i 'cf version' | cut -d " " -f 3))"
  fi
}
getCurlVersion() {
  if isCommandAvailable "curl" ; then
    printToolVersion "${1}" "$(echo $(curl -V 2>&1 | grep -i 'curl ' | cut -d " " -f 2))"
  fi
}
getDenoVersion() {
  if isCommandAvailable "deno" ; then
    printToolVersion "${1}" "$(echo $(deno --version 2>&1 | grep -i 'deno'  | cut -d " " -f 2))"
  fi
}
getDockerVersion() {
  if isCommandAvailable "docker" ; then
    printToolVersion "${1}" "$(echo $(docker -v 2>&1 | grep -i 'Docker version' | cut -d " " -f 3 | sed 's/\,/ /g'))"
  fi
}
getDockerComposeVersion() {
  if isCommandAvailable "docker-compose" ; then
    printToolVersion "${1}" "$(echo $(docker-compose --version | cut -d " " -f 3 | cut -d "," -f 1))"
  fi
}
getForkVersion() {
  if isCommandAvailable "fork" ; then
    printToolVersion "${1}" "$(echo $(fork --version 2>&1))"
  fi
}
getGitVersion() {
  if isCommandAvailable "git" ; then
    printToolVersion "${1}" "$(echo $(git --version 2>&1 | cut -d " " -f 3))"
  fi
}
getGoogleCloudSdkVersion() {
  if isCommandAvailable "gcloud" ; then
    printToolVersion "${1}" "$(echo $(gcloud version 2>&1 | grep -i 'Google Cloud SDK' | cut -d " " -f 4))"
  fi
}
getGradleVersion() {
  if isCommandAvailable "gradle" ; then
    printToolVersion "${1}" "$(echo $(gradle -v 2>&1 | grep -i 'Gradle' | cut -d " " -f 2))"
  fi
}
getGroovyVersion() {
  if isCommandAvailable "groovy" ; then
    printToolVersion "${1}" "$(echo $(groovy -v 2>&1 | cut -d " " -f 3))"
  fi
}
getGulpVersion() {
  if isCommandAvailable "gulp" ; then
    printToolVersion "${1}" "$(echo $(gulp -v 2>&1 | grep -i 'CLI version' | cut -d " " -f 4))"
  fi
}
getHerokuVersion() {
  if isCommandAvailable "heroku" ; then
    printToolVersion "${1}" "$(echo $(heroku -v 2>&1 | cut -d "/" -f 2 | cut -d " " -f 1))"
  fi
}
getHomebrewVersion() {
  if isCommandAvailable "brew" ; then
    printToolVersion "${1}" "$(echo $(brew -v 2>&1 | grep -i 'Homebrew ' | cut -d " " -f 2))"
  fi
}
getJavaVersion() {
  if isCommandAvailable "java" ; then
    printToolVersion "${1}" "$(echo $(java -version 2>&1 | grep -i 'version' | cut -d " " -f 3 | sed 's/\"/ /g'))"
  fi
}
getJHipsterVersion() {
  if isCommandAvailable "jhipster" ; then
    printToolVersion "${1}" "$(echo $(jhipster --version 2>&1 | cut -d " " -f 6))"
  fi
}
getJqVersion() {
  if isCommandAvailable "jq" ; then
    printToolVersion "${1}" "$(echo $(jq --version 2>&1 | cut -d "-" -f 2))"
  fi
}
getKubectlClientVersion() {
  if isCommandAvailable "kubectl" ; then
    printToolVersion "${1}" "$(echo $(kubectl version --client 2>&1 | cut -d ":" -f 5 | cut -d "," -f 1 | sed 's/\"//g' | cut -d "v" -f 2))"
  fi
}
getLogrotateVersion() {
  if isCommandAvailable "logrotate" ; then
    printToolVersion "${1}" "$(echo "$(logrotate --version 2>&1)" | cut -d " " -f 2)"
  fi
}
getMakeVersion() {
  if isCommandAvailable "make" ; then
    printToolVersion "${1}" "$(echo $(make -v 2>&1 | grep -i 'Make' | cut -d " " -f 3))"
  fi
}
getMavenVersion() {
  if isCommandAvailable "mvn" ; then
    printToolVersion "${1}" "$(echo $(mvn -v 2>&1 | grep -i 'Apache Maven' | cut -d " " -f 3))"
  fi
}
getMinikubeVersion() {
  if isCommandAvailable "minikube" ; then
    printToolVersion "${1}" "$(echo $(minikube version 2>&1 | cut -d " " -f 3 | cut -d "v" -f 2))"
  fi
}
getMongoDbVersion() {
  if isCommandAvailable "mongo" ; then
    printToolVersion "${1}" "$(echo $(mongo -version 2>&1 | grep -i "MongoDB" | cut -d " " -f 4 | cut -d "v" -f 2))"
  fi
}
getNativeScriptVersion() {
  if isCommandAvailable "tns" ; then
    printToolVersion "${1}" "$(echo $(tns --version 2>&1))"
  fi
}
getNestJsVersion() {
  if isCommandAvailable "nest" ; then
    printToolVersion "${1}" "$(echo $(nest -v 2>&1))"
  fi
}
getNewmanVersion() {
  if isCommandAvailable "newman" ; then
    printToolVersion "${1}" "$(echo $(newman --version 2>&1))"
  fi
}
getNginxVersion() {
  if isCommandAvailable "nginx" ; then
    printToolVersion "${1}" "$(echo "$(nginx -v 2>&1)" | cut -d "/" -f 2)"
  fi
}
getNodeVersion() {
  if isCommandAvailable "node" ; then
    printToolVersion "${1}" "$(echo $(node -v 2>&1 | cut -d "v" -f 2))"
  fi
}
getNpmVersion() {
  if isCommandAvailable "npm" ; then
    printToolVersion "${1}" "$(echo $(npm -v 2>&1))"
  fi
}
getPostgreSQLVersion() {
  if isCommandAvailable "psql" ; then
    printToolVersion "${1}" "$(psql --version 2>&1 | cut -d " " -f 3)"
  fi
}
getPythonVersion() {
  if isCommandAvailable "python" ; then
    printToolVersion "${1}" "$(echo "$(python -V 2>&1)" | cut -d " " -f 2)"
  fi
}
getPython3Version() {
  if isCommandAvailable "python3" ; then
    printToolVersion "${1}" "$(echo "$(python3 -V 2>&1)" | cut -d " " -f 2)"
  fi
}
getRubyVersion() {
  if isCommandAvailable "ruby" ; then
    printToolVersion "${1}" "$(echo $(ruby -v 2>&1 | cut -d " " -f 2))"
  fi
}
getSpringBootCliVersion() {
  if isCommandAvailable "spring" ; then
    printToolVersion "${1}" "$(echo $(spring --version 2>&1 | grep -i 'CLI' | cut -d " " -f 3 | cut -d "v" -f 2))"
  fi
}
getTerraformVersion() {
  if isCommandAvailable "terraform" ; then
    printToolVersion "${1}" "$(echo $(terraform version 2>&1 | cut -d " " -f 3 | cut -d "v" -f 2))"
  fi
}
getTypescriptVersion() {
  if isCommandAvailable "tsc" ; then
    printToolVersion "${1}" "$(echo $(tsc -v 2>&1 | cut -d " " -f 2))"
  fi
}
getVimVersion() {
  if isCommandAvailable "vim" ; then
    printToolVersion "${1}" "$(echo $(vim --version 2>&1 | grep -i 'Vi IMproved' | cut -d " " -f 5))"
  fi
}
getVueVersion() {
  if isCommandAvailable "npm" ; then
    printToolVersion "${1}" "$(echo $(npm list vue 2>&1 | grep -i 'vue@' | cut -d "@" -f 2))"
  fi
}
getVueCliVersion() {
  if isCommandAvailable "vue" ; then
    printToolVersion "${1}" "$(echo $(vue --version 2>&1 | cut -d " " -f 2))"
  fi
}
getYarnVersion() {
  if isCommandAvailable "yarn" ; then
    printToolVersion "${1}" "$(echo $(yarn -v 2>&1 | cut -d "v" -f 2))"
  fi
}
getYeomanVersion() {
  if isCommandAvailable "yo" ; then
    printToolVersion "${1}" "$(echo $(yo --version 2>&1))"
  fi
}
getZshVersion() {
  if isCommandAvailable "zsh" ; then
    printToolVersion "${1}" "$(echo $(zsh --version 2>&1 | grep -i 'zsh' | cut -d " " -f 2))"
  fi
}

### start of script ###
printStartLines
getOsVersion
getAngularCliVersion "angular cli"
getApacheBenchVersion "apache bench"
getAtomVersion "atom"
getAwsCliVersion "aws cli"
getBashVersion "bash"
getCertbotVersion "certbot"
getCloudFoundryCliVersion "cloudfoundry cli"
getCurlVersion "curl"
getDenoVersion "deno"
getDockerVersion "docker"
getDockerComposeVersion "docker-compose"
getForkVersion "fork"
getGitVersion "git"
getGoogleCloudSdkVersion "google cloud sdk"
getGradleVersion "gradle"
getGroovyVersion "groovy"
getGulpVersion "gulp"
getHerokuVersion "heroku"
getHomebrewVersion "homebrew"
getJavaVersion "java"
getJHipsterVersion "jhipster"
getJqVersion "jq"
getKubectlClientVersion "kubectl client"
getLogrotateVersion "logrotate"
getMakeVersion "make"
getMavenVersion "maven"
getMinikubeVersion "minikube"
getMongoDbVersion "mongodb"
getNativeScriptVersion "nativescript"
getNestJsVersion "nestjs"
getNewmanVersion "newman"
getNginxVersion "nginx"
getNodeVersion "node"
getNpmVersion "npm"
getPostgreSQLVersion "postgresql"
getPythonVersion "python"
getPython3Version "python3"
getRubyVersion "ruby"
getSpringBootCliVersion "springboot cli"
getTerraformVersion "terraform"
getTypescriptVersion "typescript"
getVimVersion "vim"
getVueVersion "vuejs"
getVueCliVersion "vue cli"
getYarnVersion "yarn"
getYeomanVersion "yeoman"
getZshVersion "zsh"
printEndLines

### end of script ###

#####################
