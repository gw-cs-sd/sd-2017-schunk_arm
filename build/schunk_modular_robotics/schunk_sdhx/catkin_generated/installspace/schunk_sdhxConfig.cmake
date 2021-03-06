# generated from catkin/cmake/template/pkgConfig.cmake.in

# append elements to a list and remove existing duplicates from the list
# copied from catkin/cmake/list_append_deduplicate.cmake to keep pkgConfig
# self contained
macro(_list_append_deduplicate listname)
  if(NOT "${ARGN}" STREQUAL "")
    if(${listname})
      list(REMOVE_ITEM ${listname} ${ARGN})
    endif()
    list(APPEND ${listname} ${ARGN})
  endif()
endmacro()

# append elements to a list if they are not already in the list
# copied from catkin/cmake/list_append_unique.cmake to keep pkgConfig
# self contained
macro(_list_append_unique listname)
  foreach(_item ${ARGN})
    list(FIND ${listname} ${_item} _index)
    if(_index EQUAL -1)
      list(APPEND ${listname} ${_item})
    endif()
  endforeach()
endmacro()

# pack a list of libraries with optional build configuration keywords
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_pack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  set(_argn ${ARGN})
  list(LENGTH _argn _count)
  set(_index 0)
  while(${_index} LESS ${_count})
    list(GET _argn ${_index} lib)
    if("${lib}" MATCHES "^(debug|optimized|general)$")
      math(EXPR _index "${_index} + 1")
      if(${_index} EQUAL ${_count})
        message(FATAL_ERROR "_pack_libraries_with_build_configuration() the list of libraries '${ARGN}' ends with '${lib}' which is a build configuration keyword and must be followed by a library")
      endif()
      list(GET _argn ${_index} library)
      list(APPEND ${VAR} "${lib}${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}${library}")
    else()
      list(APPEND ${VAR} "${lib}")
    endif()
    math(EXPR _index "${_index} + 1")
  endwhile()
endmacro()

# unpack a list of libraries with optional build configuration keyword prefixes
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_unpack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  foreach(lib ${ARGN})
    string(REGEX REPLACE "^(debug|optimized|general)${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}(.+)$" "\\1;\\2" lib "${lib}")
    list(APPEND ${VAR} "${lib}")
  endforeach()
endmacro()


if(schunk_sdhx_CONFIG_INCLUDED)
  return()
endif()
set(schunk_sdhx_CONFIG_INCLUDED TRUE)

# set variables for source/devel/install prefixes
if("FALSE" STREQUAL "TRUE")
  set(schunk_sdhx_SOURCE_PREFIX /home/workstation3/catkin_ws/src/schunk_modular_robotics/schunk_sdhx)
  set(schunk_sdhx_DEVEL_PREFIX /home/workstation3/catkin_ws/devel)
  set(schunk_sdhx_INSTALL_PREFIX "")
  set(schunk_sdhx_PREFIX ${schunk_sdhx_DEVEL_PREFIX})
else()
  set(schunk_sdhx_SOURCE_PREFIX "")
  set(schunk_sdhx_DEVEL_PREFIX "")
  set(schunk_sdhx_INSTALL_PREFIX /home/workstation3/catkin_ws/install)
  set(schunk_sdhx_PREFIX ${schunk_sdhx_INSTALL_PREFIX})
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "WARNING: package 'schunk_sdhx' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  message("${_msg}")
endif()

# flag project as catkin-based to distinguish if a find_package()-ed project is a catkin project
set(schunk_sdhx_FOUND_CATKIN_PROJECT TRUE)

if(NOT " " STREQUAL " ")
  set(schunk_sdhx_INCLUDE_DIRS "")
  set(_include_dirs "")
  foreach(idir ${_include_dirs})
    if(IS_ABSOLUTE ${idir} AND IS_DIRECTORY ${idir})
      set(include ${idir})
    elseif("${idir} " STREQUAL "include ")
      get_filename_component(include "${schunk_sdhx_DIR}/../../../include" ABSOLUTE)
      if(NOT IS_DIRECTORY ${include})
        message(FATAL_ERROR "Project 'schunk_sdhx' specifies '${idir}' as an include dir, which is not found.  It does not exist in '${include}'.  Ask the maintainer 'Thiago de Freitas <tdf@ipa.fhg.de>' to fix it.")
      endif()
    else()
      message(FATAL_ERROR "Project 'schunk_sdhx' specifies '${idir}' as an include dir, which is not found.  It does neither exist as an absolute directory nor in '/home/workstation3/catkin_ws/install/${idir}'.  Ask the maintainer 'Thiago de Freitas <tdf@ipa.fhg.de>' to fix it.")
    endif()
    _list_append_unique(schunk_sdhx_INCLUDE_DIRS ${include})
  endforeach()
endif()

set(libraries "")
foreach(library ${libraries})
  # keep build configuration keywords, target names and absolute libraries as-is
  if("${library}" MATCHES "^(debug|optimized|general)$")
    list(APPEND schunk_sdhx_LIBRARIES ${library})
  elseif(TARGET ${library})
    list(APPEND schunk_sdhx_LIBRARIES ${library})
  elseif(IS_ABSOLUTE ${library})
    list(APPEND schunk_sdhx_LIBRARIES ${library})
  else()
    set(lib_path "")
    set(lib "${library}-NOTFOUND")
    # since the path where the library is found is returned we have to iterate over the paths manually
    foreach(path /home/workstation3/catkin_ws/install/lib;/opt/ros/indigo/lib)
      find_library(lib ${library}
        PATHS ${path}
        NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
      if(lib)
        set(lib_path ${path})
        break()
      endif()
    endforeach()
    if(lib)
      _list_append_unique(schunk_sdhx_LIBRARY_DIRS ${lib_path})
      list(APPEND schunk_sdhx_LIBRARIES ${lib})
    else()
      # as a fall back for non-catkin libraries try to search globally
      find_library(lib ${library})
      if(NOT lib)
        message(FATAL_ERROR "Project '${PROJECT_NAME}' tried to find library '${library}'.  The library is neither a target nor built/installed properly.  Did you compile project 'schunk_sdhx'?  Did you find_package() it before the subdirectory containing its code is included?")
      endif()
      list(APPEND schunk_sdhx_LIBRARIES ${lib})
    endif()
  endif()
endforeach()

set(schunk_sdhx_EXPORTED_TARGETS "")
# create dummy targets for exported code generation targets to make life of users easier
foreach(t ${schunk_sdhx_EXPORTED_TARGETS})
  if(NOT TARGET ${t})
    add_custom_target(${t})
  endif()
endforeach()

set(depends "")
foreach(depend ${depends})
  string(REPLACE " " ";" depend_list ${depend})
  # the package name of the dependency must be kept in a unique variable so that it is not overwritten in recursive calls
  list(GET depend_list 0 schunk_sdhx_dep)
  list(LENGTH depend_list count)
  if(${count} EQUAL 1)
    # simple dependencies must only be find_package()-ed once
    if(NOT ${schunk_sdhx_dep}_FOUND)
      find_package(${schunk_sdhx_dep} REQUIRED)
    endif()
  else()
    # dependencies with components must be find_package()-ed again
    list(REMOVE_AT depend_list 0)
    find_package(${schunk_sdhx_dep} REQUIRED ${depend_list})
  endif()
  _list_append_unique(schunk_sdhx_INCLUDE_DIRS ${${schunk_sdhx_dep}_INCLUDE_DIRS})

  # merge build configuration keywords with library names to correctly deduplicate
  _pack_libraries_with_build_configuration(schunk_sdhx_LIBRARIES ${schunk_sdhx_LIBRARIES})
  _pack_libraries_with_build_configuration(_libraries ${${schunk_sdhx_dep}_LIBRARIES})
  _list_append_deduplicate(schunk_sdhx_LIBRARIES ${_libraries})
  # undo build configuration keyword merging after deduplication
  _unpack_libraries_with_build_configuration(schunk_sdhx_LIBRARIES ${schunk_sdhx_LIBRARIES})

  _list_append_unique(schunk_sdhx_LIBRARY_DIRS ${${schunk_sdhx_dep}_LIBRARY_DIRS})
  list(APPEND schunk_sdhx_EXPORTED_TARGETS ${${schunk_sdhx_dep}_EXPORTED_TARGETS})
endforeach()

set(pkg_cfg_extras "")
foreach(extra ${pkg_cfg_extras})
  if(NOT IS_ABSOLUTE ${extra})
    set(extra ${schunk_sdhx_DIR}/${extra})
  endif()
  include(${extra})
endforeach()
