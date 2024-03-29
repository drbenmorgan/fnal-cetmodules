########################################################################
#
# install_gdml()
#   Install gdml scripts in a top level gdml subdirectory ${gdml_dir}.
#
#   Default extensions:
#     .gdml
#
# The SUBDIRS option allows you to search subdirectories (e.g. a detail subdirectory)
#
# The EXTRAS option is intended to allow you to pick up extra files not otherwise found.
# They should be specified by relative path (eg f1, subdir1/f2, etc.).
#
# The EXCLUDES option will exclude the specified files from the installation list.
#
# The LIST option allows you to install from a list. When LIST is used,
# we do not search for other files to install. Note that the LIST and
# SUBDIRS options are mutually exclusive.
#
####################################
# Recommended use:
#
# install_gdml( [SUBDIRS subdirectory_list]
#                [EXTRAS extra_files]
#                [EXCLUDES exclusions] )
# install_gdml( LIST file_list )
#
# N.B. gdml_dir must be set prior to calling install_gdml(), otherwise
# install_gdml() will generate a FATAL_ERROR.
########################################################################
include (CetCopy)
include (CetExclude)
include (CetProjectVars)

function(install_gdml)
  cet_project_var(gdml_dir MISSING_OK
    DOCSTRING "Directory below prefix to install GDML files")
  cmake_parse_arguments( IGDML "" "" "SUBDIRS;LIST;EXTRAS;EXCLUDES" ${ARGN})
  if (NOT ${CMAKE_PROJECT_NAME}_gdml_dir)
    message(FATAL_ERROR "ERROR: install_gdml() called without ${CMAKE_PROJECT_NAME}_gdml_dir being configured")
  endif()
  set(gdml_install_dir ${${CMAKE_PROJECT_NAME}_gdml_dir})
  if (IGDML_LIST)
    if (IGDML_SUBDIRS)
      message(FATAL_ERROR "ERROR: LIST and SUBDIRS are mutually exclusive in install_gdml()")
    endif()
    cet_copy(${IGDML_LIST} DESTINATION  ${CMAKE_BINARY_DIR}/${${CMAKE_PROJECT_NAME}_gdml_dir})
    install(FILES ${IGDML_LIST} DESTINATION ${gdml_install_dir})
  else()
    if (IGDML_EXTRAS)
      cet_copy(${IGDML_EXTRAS} DESTINATION  ${CMAKE_BINARY_DIR}/${${CMAKE_PROJECT_NAME}_gdml_dir})
      install(FILES ${IGDML_EXTRAS} DESTINATION ${gdml_install_dir})
    endif()
    file(GLOB gdml [^.]*.gdml)
    if (gdml)
      cet_copy(${gdml} DESTINATION  ${CMAKE_BINARY_DIR}/${${CMAKE_PROJECT_NAME}_gdml_dir})
      install(FILES ${gdml} DESTINATION ${gdml_install_dir})
      if (IGDML_SUBDIRS)
        foreach(sub ${IGDML_SUBDIRS})
	        file(GLOB subdir_gdml ${sub}/[^.]*.gdml)
          if (IGDML_EXCLUDES)
            _cet_exlude_from_list(subdir_gdml EXCLUDES ${IGDML_EXCLUDES} LIST ${subdir_gdml})
          endif()
          if (subdir_gdml)
            cet_copy(${subdir_gdml} DESTINATION  ${CMAKE_BINARY_DIR}/${${CMAKE_PROJECT_NAME}_gdml_dir})
            install(FILES ${subdir_gdml} DESTINATION ${gdml_install_dir})
          endif()
        endforeach()
      endif()
    endif()
  endif()
endfunction()
