
# 
# External dependencies
# 

# find_package(THIRDPARTY REQUIRED)


# 
# Library name and options
# 

# Target name
set(target baselib)

# Exit here if required dependencies are not met
message(STATUS "Lib ${target}")

# Set API export file and macro
string(MAKE_C_IDENTIFIER ${target} target_id)
string(TOUPPER ${target_id} target_id)
set(export_file          "include/${target}/${target}_export.h")
set(template_export_file "include/${target}/${target}_api.h")
set(export_macro         "${target_id}_API")


# 
# Sources
# 

set(include_path "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(source_path  "${CMAKE_CURRENT_SOURCE_DIR}/src")

set(headers
    ${include_path}/baselib.h
)

set(sources
    ${source_path}/baselib.cpp
)

# Group source files
set(header_group "Header Files (API)")
set(source_group "Source Files")
source_group_by_path(${include_path} "\\\\.h$|\\\\.hpp$" 
    ${header_group} ${headers})
source_group_by_path(${source_path}  "\\\\.cpp$|\\\\.c$|\\\\.h$|\\\\.hpp$" 
    ${source_group} ${sources})


# 
# Create library
# 

# Build library
add_library(${target}
    ${sources}
    ${headers}
)

# Create namespaced alias
add_library(${META_PROJECT_NAME}::${target} ALIAS ${target})

# Export library for downstream projects
export(TARGETS ${target} NAMESPACE ${META_PROJECT_NAME}:: FILE ${PROJECT_BINARY_DIR}/cmake/${target}/${target}-export.cmake)

# Create API export header
generate_export_header(${target}
    EXPORT_FILE_NAME  ${export_file}
    EXPORT_MACRO_NAME ${export_macro}
)

generate_template_export_header(${target}
    ${target_id}
    ${template_export_file}
)


# 
# Project options
# 

set_target_properties(${target}
    PROPERTIES
    ${DEFAULT_PROJECT_OPTIONS}
    FOLDER "${IDE_FOLDER}"
    VERSION ${META_VERSION}
    SOVERSION ${META_VERSION_MAJOR}
)


# 
# Include directories
# 

target_include_directories(${target}
    PRIVATE
    #${PROJECT_SOURCE_DIR}/third-party/rapidjson/include
    #${PROJECT_SOURCE_DIR}/third-party/spdlog/include
    ${PROJECT_BINARY_DIR}/source/include
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_BINARY_DIR}/include

    PUBLIC
    ${DEFAULT_INCLUDE_DIRECTORIES}

    INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
    $<INSTALL_INTERFACE:include>
)


# 
# Libraries
# 

# If the downstream target dependents (specify libraries) cannot be found 
# by find_package()
#
# Method add_libraries() & set_property() can add specify libraries
# manually:
#
# https://cmake.org/cmake/help/latest/guide/importing-exporting/index.html
##
#if("${CMAKE_SYSTEM_NAME}" MATCHES "Windows")
#
#    add_library(boost_filesystem STATIC IMPORTED)
#    set_property(TARGET boost_filesystem PROPERTY 
#        INTERFACE_INCLUDE_DIRECTORIES ${PROJECT_SOURCE_DIR}/third-party/boost_1_72_0/include)
#    set_property(TARGET boost_filesystem PROPERTY 
#        IMPORTED_LOCATION ${PROJECT_SOURCE_DIR}/third-party/boost_1_72_0/lib/x86/windows/release/libboost_filesystem-vc142-mt-x64-1_72.lib)
#    set_property(TARGET boost_filesystem PROPERTY 
#        IMPORTED_LOCATION_DEBUG ${PROJECT_SOURCE_DIR}/third-party/boost_1_72_0/lib/x86/windows/debug/libboost_filesystem-vc142-mt-gd-x64-1_72.lib)
#
#
#    add_library(ZSTDCompress SHARED IMPORTED)
#    set_property(TARGET ZSTDCompress PROPERTY 
#        INTERFACE_INCLUDE_DIRECTORIES ${PROJECT_SOURCE_DIR}/third-party/zstd/include)
#    set_property(TARGET ZSTDCompress PROPERTY 
#        IMPORTED_LOCATION ${PROJECT_SOURCE_DIR}/third-party/zstd/bin/x86/windows/release/ZSTDCompress.dll)
#    set_property(TARGET ZSTDCompress PROPERTY 
#        IMPORTED_IMPLIB ${PROJECT_SOURCE_DIR}/third-party/zstd/lib/x86/windows/release/ZSTDCompress.lib)
#    set_property(TARGET ZSTDCompress PROPERTY 
#        IMPORTED_LOCATION_DEBUG ${PROJECT_SOURCE_DIR}/third-party/zstd/bin/x86/windows/debug/ZSTDCompressd.dll)
#    set_property(TARGET ZSTDCompress PROPERTY 
#        IMPORTED_IMPLIB_DEBUG ${PROJECT_SOURCE_DIR}/third-party/zstd/lib/x86/windows/debug/ZSTDCompressd.lib)
#else()
#
#    add_library(ZSTDCompress SHARED IMPORTED)
#    set_property(TARGET ZSTDCompress PROPERTY 
#        INTERFACE_INCLUDE_DIRECTORIES ${PROJECT_SOURCE_DIR}/third-party/zstd/include)
#    set_property(TARGET ZSTDCompress PROPERTY 
#        IMPORTED_LOCATION ${PROJECT_SOURCE_DIR}/third-party/zstd/bin/x86/linux/release/libZSTDCompress.so)
#    set_property(TARGET ZSTDCompress PROPERTY 
#        IMPORTED_LOCATION_DEBUG ${PROJECT_SOURCE_DIR}/third-party/zstd/bin/x86/linux/debug/libZSTDCompressd.so)
#
#endif()


# Set specify libraries or flags to use when linking a given target 
# and/or its dependents.
target_link_libraries(${target}
    PRIVATE

    PUBLIC
    ${DEFAULT_LIBRARIES}
#    boost_filesystem 
#    ZSTDCompress

    INTERFACE
)


# 
# Compile definitions
# 

target_compile_definitions(${target}
    PRIVATE

    PUBLIC
    $<$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>:${target_id}_STATIC_DEFINE>
    ${DEFAULT_COMPILE_DEFINITIONS}

    INTERFACE
)


# 
# Compile options
# 

target_compile_options(${target}
    PRIVATE

    PUBLIC
    ${DEFAULT_COMPILE_OPTIONS}

    INTERFACE
)


# 
# Linker options
# 

target_link_options(${target}
    PRIVATE

    PUBLIC
    ${DEFAULT_LINKER_OPTIONS}

    INTERFACE
)


#
# Target Health
#

perform_health_checks(
    ${target}
    ${sources}
    ${headers}
)


# 
# Deployment
# 

# Library
install(TARGETS ${target}
    EXPORT  "${target}-export"            COMPONENT dev
    RUNTIME DESTINATION ${INSTALL_BIN}    COMPONENT runtime
    LIBRARY DESTINATION ${INSTALL_SHARED} COMPONENT runtime
    ARCHIVE DESTINATION ${INSTALL_LIB}    COMPONENT dev
)

# Header files
install(DIRECTORY
    ${CMAKE_CURRENT_SOURCE_DIR}/include/${target} DESTINATION ${INSTALL_INCLUDE}
    COMPONENT dev
)

# Generated header files
install(DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}/include/${target} DESTINATION ${INSTALL_INCLUDE}
    COMPONENT dev
)

# CMake config
install(EXPORT ${target}-export
    NAMESPACE   ${META_PROJECT_NAME}::
    DESTINATION ${INSTALL_CMAKE}/${target}
    COMPONENT   dev
)
