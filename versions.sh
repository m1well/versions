#!/bin/bash                                                                                                                                                                                                       
###                                                                                                                                                                                                               
#title                  :versions.sh                                                                                                                                                                              
#description            :This script provides your tool versions.                                                                                                                                                 
#author                 :Michael Wellner (@m1well) twitter.m1well.de                                                                                                                                              
#date of creation       :20171130                                                                                                                                                                                 
#date of last change    :20171130                                                                                                                                                                                 
#version                :1.0.0                                                                                                                                                                                    
#usage                  :versions.sh                                                                                                                                                                              
#notes                  :it would be most suitable to create an alias                                                                                                                                             
###                                                                                                                                                                                                               

### colors and linebreak ###
BR="\n"                     
FONT_CYAN="\033[0;96m"      
FONT_NONE="\033[0m"         

### output ###
line="###############################################"
header="########## versions (alphabetically) ##########"

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
    printf "os:            "                                                                                                                         
    printf "${os}"                                                                                                                                   
    printf "${BR}"                                                                                                                                   
    printf "# -----------------------------------"                                                                                                   
    printf "${BR}"                                                                                                                                   
  fi                                                                                                                                                 
}                                                                                                                                                    

printAngularCliVersion() {
  local version=""        
  version="$(echo $(ng -v 2>&1 | grep -i 'Angular' | cut -d " " -f 3))"
  if isThisStringVersionNumber "${version}" ; then                     
    printf "angular cli:   "                                           
    printf "${version}"                                                
    printf "${BR}"                                                     
  fi                                                                   
}                                                                      
printBashVersion() {                                                   
  local version=""                                                     
  version="$(echo $(bash --version 2>&1 | grep -i 'bash' | cut -d " " -f 4))"
  if isThisStringVersionNumber "${version}" ; then                           
    printf "bash:          "                                                 
    printf "${version}"                                                      
    printf "${BR}"                                                           
  fi                                                                         
}                                                                            
printDockerVersion() {                                                       
  local version=""                                                           
  version="$(echo $(docker -v 2>&1 | grep -i 'Docker version' | cut -d " " -f 3 | sed 's/\,/ /g'))"
  if isThisStringVersionNumber "${version}" ; then                                                 
    printf "docker:        "                                                                       
    printf "${version}"                                                                            
    printf "${BR}"                                                                                 
  fi                                                                                               
}                                                                                                  
printGitVersion() {                                                                                
  local version=""                                                                                 
  version="$(echo $(git --version 2>&1 | cut -d " " -f 3))"                                        
  if isThisStringVersionNumber "${version}" ; then                                                 
    printf "git:           "                                                                       
    printf "${version}"                                                                            
    printf "${BR}"                                                                                 
  fi                                                                                               
}                                                                                                  
printGradleVersion() {                                                                             
  local version=""                                                                                 
  version="$(echo $(gradle -v 2>&1 | grep -i 'Gradle' | cut -d " " -f 2))"                         
  if isThisStringVersionNumber "${version}" ; then                                                 
    printf "gradle:        "                                                                       
    printf "${version}"                                                                            
    printf "${BR}"                                                                                 
  fi                                                                                               
}                                                                                                  
printGulpVersion() {                                                                               
  local version=""                                                                                 
  version="$(echo $(gulp -v 2>&1 | grep -i 'CLI version' | cut -d " " -f 4))"                      
  if isThisStringVersionNumber "${version}" ; then                                                 
    printf "gulp:          "                                                                       
    printf "${version}"                                                                            
    printf "${BR}"                                                                                 
  fi                                                                                               
}                                                                                                  
printJavaVersion() {                                                                               
  local version=""                                                                                 
  version="$(echo $(java -version 2>&1 | grep -i 'version' | cut -d " " -f 3 | sed 's/\"/ /g'))"   
  if isThisStringVersionNumber "${version}" ; then                                                 
    printf "java:          "                                                                       
    printf "${version}"                                                                            
    printf "${BR}"                                                                                 
  fi                                                                                               
}                                                                                                  
printMakeVersion() {                                                                               
  local version=""                                                                                 
  version="$(echo $(make -v 2>&1 | grep -i 'Make' | cut -d " " -f 3))"                             
  if isThisStringVersionNumber "${version}" ; then                                                 
    printf "make:          "                                                                       
    printf "${version}"                                                                            
    printf "${BR}"                                                                                 
  fi                                                                                               
}                                                                                                  
printMavenVersion() {                                                                              
  local version=""                                                                                 
  version="$(echo $(mvn -v 2>&1 | grep -i 'Apache Maven' | cut -d " " -f 3))"                      
  if isThisStringVersionNumber "${version}" ; then                                                 
    printf "maven:         "                                                                       
    printf "${version}"                                                                            
    printf "${BR}"                                                                                 
  fi                                                                                               
}                                                                                                  
printNpmVersion() {
  local version=""
  version="$(echo $(npm -v 2>&1))"
  if isThisStringVersionNumber "${version}" ; then
    printf "npm:           "
    printf "${version}"
    printf "${BR}"
  fi
}
printNodeVersion() {
  local version=""
  version="$(echo $(node -v 2>&1 | cut -d "v" -f 2))"
  if isThisStringVersionNumber "${version}" ; then
    printf "node:          "
    printf "${version}"
    printf "${BR}"
  fi
}
printSpringCliVersion() {
  local version=""
  version="$(echo $(spring --version 2>&1 | grep -i 'CLI' | cut -d " " -f 3 | cut -d "v" -f 2))"
  if isThisStringVersionNumber "${version}" ; then
    printf "spring cli:    "
    printf "${version}"
    printf "${BR}"
  fi
}
printZshVersion() {
  local version=""
  version="$(echo $(zsh --version 2>&1 | grep -i 'zsh' | cut -d " " -f 2))"
  if isThisStringVersionNumber "${version}" ; then
    printf "zsh:           "
    printf "${version}"
    printf "${BR}"
  fi
}


### start of script ###
printStartLines
printOsVersion
printAngularCliVersion
printBashVersion
printDockerVersion
printGitVersion
printGradleVersion
printGulpVersion
printJavaVersion
printMakeVersion
printMavenVersion
printNpmVersion
printNodeVersion
printSpringCliVersion
printZshVersion
printEndLines

### end of script ###
#####################
