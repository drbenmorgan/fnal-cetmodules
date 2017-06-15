
# define the environment for cpack
#
set( CPACK_PACKAGE_VERSION ${PROJECT_VERSION} )
message(STATUS "UseCPackNoarch: CPACK_PACKAGE_VERSION is ${CPACK_PACKAGE_VERSION}" )
set( CPACK_INCLUDE_TOPLEVEL_DIRECTORY 0 )
set( CPACK_GENERATOR TBZ2 )
set( CPACK_PACKAGE_NAME ${PROJECT_NAME} )
set( CPACK_SYSTEM_NAME noarch )
message(STATUS "UseCPackNoarch: CPACK_PACKAGE_NAME and CPACK_SYSTEM_NAME are ${CPACK_PACKAGE_NAME} ${CPACK_SYSTEM_NAME}" )
include(CPack)
