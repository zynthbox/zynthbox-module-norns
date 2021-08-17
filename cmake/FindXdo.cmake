# - Try to find LibXdo
# Once done this will define
#  LIBXDO_FOUND - System has LibXdo
#  LIBXDO_INCLUDE_DIRS - The LibXdo include directories
#  LIBXDO_LIBRARIES - The libraries needed to use LibXdo

find_path(LIBXDO_INCLUDE_DIR xdo.h)

find_library(LIBXDO_LIBRARY NAMES xdo libxdo)

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBXDO_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Xdo  DEFAULT_MSG
                                  LIBXDO_LIBRARY LIBXDO_INCLUDE_DIR)

mark_as_advanced(LIBXDO_INCLUDE_DIR LIBXDO_LIBRARY )

set(LIBXDO_LIBRARIES ${LIBXDO_LIBRARY} )
set(LIBXDO_INCLUDE_DIRS ${LIBXDO_INCLUDE_DIR} )

message("-- Found Xdo: ${LIBXDO_LIBRARIES} ${LIBXDO_INCLUDE_DIRS}")
