
To adapt this template (cmakeyixqy) to your own project, follow these steps:


In the root directory adapt/change/do the following:
--------------------------------------------------------------------

* [ ] Edit LICENSE
* [ ] Edit README.md
* [ ] Rename ./cmakeyixqy-config.cmake -> ./\<project>-config.cmake
* [ ] Edit or Add new targets to ./{project}-config.cmake

CMakeLists.txt:
* [ ]  Set META_PROJECT_*
* [ ]  Set META_VERSION_*
* [ ]  Set META_AUTHOR_*
* [ ]  Set META_CMAKE_INIT_SHA (to the commit hash of the applied cmakeyixqy template, e.g., to 83d98e5b9a6fcb74a9840fcebd9579d5cccbc23d)
* [ ]  Adjust INSTALL_* to the desired install locations for all systems (defaults should be fine for a start)


In subdirectory "./deploy/" do:
--------------------------------------------------------------------

deploy/CMakeLists.txt:
* [ ] Rename deploy/packages/pack-template.cmake -> pack-\<project>.cmake

deploy/packages/pack-\<project>.cmake:
* [ ] Adjust OPTION_PACK_GENERATOR to your liking for all systems
* [ ] Adjust package options, e.g., CPACK_DEBIAN_PACKAGE_DEPENDS, CPACK_DEBIAN_PACKAGE_SECTION, CPACK_DEBIAN_PACKAGE_PRIORITY, CPACK_RPM_PACKAGE_LICENSE, CPACK_RPM_PACKAGE_GROUP, ...


In subdirectory "./docs/api-docs/" do:
--------------------------------------------------------------------

docs/api-docs/doxyfile.in:
* [ ] Adjust INPUT tag (list of doxygen annotated sources)

docs/api-docs/CMakeLists.txt
* [ ] Adjust DEPENDS parameter to include all targets of project


In subdirectory "./docs/manual/" do:
--------------------------------------------------------------------

docs/manual/cmakeyixqy.tex:
* [ ] Rename to match own project name

docs/manual/CMakeLists.txt
* [ ] Adjust source and pdf file name


In subdirectory "./source/" do:
--------------------------------------------------------------------

* [ ] Adjust version infomation in version.h.in


In subdirectory "./source/<modules>/src", print version info: 
--------------------------------------------------------------------
#include "<project>/<project>-version.h":

example 1:
--------------------------------------------------------------------
source/baselib/src/baselib.cpp:
* [ ] Substitute cmakeyixqy/cmakeyixqy-version.h -> \<project>/\<project>-version.h
* [ ] Substitute CMAKEYIXQY_VERSION -> \<PROJECT>_VERSION

example 2:
--------------------------------------------------------------------
source/fibcmd/main.cpp:
* [ ] Substitute cmakeyixqy-version.h -> \<project>-version.h
* [ ] Substitute CMAKEYIXQY_VERSION -> \<PROJECT>_VERSION


In subdirectory "./source/tests/" do:
--------------------------------------------------------------------

source/tests/CMakeLists.txt:
* [ ]  Set META_PROJECT_NAME


General stuff left to do:
--------------------------------------------------------------------

* [ ] Rename and adjust targets in source/
* [ ] Add new targets to source/CMakeLists.txt
* [ ] Add new targets to ./{project}-config.cmake
* [ ] Add new targets to the INPUT tag in docs/api-docs/doxyfile.in
* [ ] Remove data/DATA_FOLDER.txt
* [ ] Populate data/
* [ ] Remove ADAPT.md
