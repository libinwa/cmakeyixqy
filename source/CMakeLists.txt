
# 
# Configuration for all sub-projects
# 

# Generate version-header
set(version_file "${CMAKE_CURRENT_SOURCE_DIR}/version.h.in")
if(EXISTS "${version_file}")
    set(version_header_file "${CMAKE_CURRENT_BINARY_DIR}/include/${META_PROJECT_NAME}/${META_PROJECT_NAME}-version.h")
    configure_file(version.h.in version_header_file @ONLY)
    message(STATUS "Generate ${META_PROJECT_NAME} version-header: ${version_header_file}")
else()
    message(WARNING "Generate ${META_PROJECT_NAME} version-header: ignored, missing ${version_file}")
endif()

# 
# Sub-projects
# 

# Libraries
set(IDE_FOLDER "")
add_subdirectory(baselib)
add_subdirectory(fiblib)

# Executable
set(IDE_FOLDER "Examples")
add_subdirectory(examples)

# Tests
if(OPTION_BUILD_TESTS AND NOT MINGW)
    set(IDE_FOLDER "Tests")
    add_subdirectory(tests)
endif()


# 
# Deployment
# 

# Deploy generated headers
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/${META_PROJECT_NAME} DESTINATION include COMPONENT dev)
