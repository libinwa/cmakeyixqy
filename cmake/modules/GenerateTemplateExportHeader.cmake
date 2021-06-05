
# Creates an export header similar to generate_export_header, but for templates.
# The main difference is that for MSVC, templates must not get exported.
# When the file ${export_file} is included in source code, the macro ${target_id}_TEMPLATE_API
# may get used to define public visibility for templates on GCC and Clang platforms.


# We must run the following at "include" time, not at function call time,
# to find the path to this module rather than the path to a calling list file
get_filename_component(_templatedir ${CMAKE_CURRENT_LIST_FILE} PATH)

function(generate_template_export_header target target_id export_file)
    if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "MSVC")
        configure_file(${_templatedir}/GenerateTemplateExportHeader_msvc_api.h.in ${CMAKE_CURRENT_BINARY_DIR}/${export_file} @ONLY)
    else()
        configure_file(${_templatedir}/GenerateTemplateExportHeader_api.h.in ${CMAKE_CURRENT_BINARY_DIR}/${export_file} @ONLY)
    endif()
endfunction()
