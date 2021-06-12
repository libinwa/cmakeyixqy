
# 
# External dependencies
# 

# find_package(THIRDPARTY REQUIRED)

#SET(CMAKE_PREFIX_PATH "C:\\Qt\\Qt5.12.8\\5.12.8\\msvc2017_64\\lib\\cmake")

find_package(Qt5Core    5.12)
find_package(Qt5Gui     5.12)
find_package(Qt5Widgets 5.12)

# Enable automoc
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(AUTOMOC_MOC_OPTIONS PROPERTIES FOLDER CMakeAutomocTargets)
set_property(GLOBAL PROPERTY AUTOMOC_FOLDER CMakeAutomocTargets)

# ENABLE CMP0020: Automatically link Qt executables to qtmain target on Windows.
set_policy(CMP0020 NEW)


# 
# Executable name and options
# 

# Target name
set(target fibgui)

# Exit here if required dependencies are not met
if (NOT Qt5Core_FOUND)
    message(STATUS "Executable ${target} skipped: Qt5 not found")
    return()
else()
    message(STATUS "Executable ${target}")
endif()


# 
# Sources
# 

set(include_path "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(source_path  "${CMAKE_CURRENT_SOURCE_DIR}/src")

set(headers
    #${include_path}/MainDialog.h
    MainWindow.h
)

set(sources
    #${source_path}/main.cpp
    main.cpp
    MainWindow.cpp
    MainWindow.ui
)

# Group source files
set(header_group "Header Files (API)")
set(source_group "Source Files")
source_group_by_path(${include_path} "\\\\.h$|\\\\.hpp$" 
    ${header_group} ${headers})
source_group_by_path(${source_path}  "\\\\.cpp$|\\\\.c$|\\\\.h$|\\\\.hpp$" 
    ${source_group} ${sources})

# 
# Create executable
# 

# Build executable
add_executable(${target}
    MACOSX_BUNDLE
    ${headers}
    ${sources}
)

# Create namespaced alias
add_executable(${META_PROJECT_NAME}::${target} ALIAS ${target})


# 
# Project options
# 

set_target_properties(${target}
    PROPERTIES
    ${DEFAULT_PROJECT_OPTIONS}
    FOLDER "${IDE_FOLDER}"
    VERSION ${META_VERSION}
)


# 
# Include directories
# 

target_include_directories(${target}
    PRIVATE
    ${DEFAULT_INCLUDE_DIRECTORIES}
    ${PROJECT_BINARY_DIR}/source/include
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_BINARY_DIR}/include
)


# 
# Libraries
# 

target_link_libraries(${target}
    PRIVATE
    ${DEFAULT_LIBRARIES}
    Qt5::Core
    Qt5::Gui
    Qt5::Widgets
    ${META_PROJECT_NAME}::baselib
    ${META_PROJECT_NAME}::fiblib
)


# 
# Compile definitions
# 

target_compile_definitions(${target}
    PRIVATE
    ${DEFAULT_COMPILE_DEFINITIONS}
)


# 
# Compile options
# 

target_compile_options(${target}
    PRIVATE
    ${DEFAULT_COMPILE_OPTIONS}
)


# 
# Linker options
# 

target_link_options(${target}
    PRIVATE
    ${DEFAULT_LINKER_OPTIONS}
)


#
# Target Health
#

perform_health_checks(
    ${target}
    ${headers}
    ${sources}
)


# 
# Deployment
# 

# Executable
install(TARGETS ${target}
    RUNTIME DESTINATION ${INSTALL_BIN} COMPONENT examples
    BUNDLE  DESTINATION ${INSTALL_BIN} COMPONENT examples
)
