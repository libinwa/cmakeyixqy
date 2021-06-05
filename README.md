## More Mordern CMake Project Template

## 一厢情愿的目录结构
```
ProjectRoot
    +- README.md
    +- CMakeLists.txt   最顶层CMakeLists.txt, 只包含对整体工程的配置, 不涉及具体模块
    +- <工程名称>-config.cmake    在这里配置工程包含的具体模块, 该文件会被最顶层CMakeLists.txt 引用
    +- cmake   包含工程自定义的cmake模块和脚本
         +- modules
               +- ClangTidy.cmake
               +- CppCheck.cmake
               +- ...
         +- scripts
    +- data    编译生成的目标程序运行时所依赖的配置数据
    +- deploy
         +- README.md
         +- CMakeLists.txt 使用CPack打包应用该配置
         +- packages
             +- pack-<工程名称>.cmake    工程打包配置
         +- dependencies 打包时其他依赖, 例如ubuntu常常需要从ubuntu-ppa下载包  
    +- docs
         +- README.md
         +- CMakeLists.txt
         +- api-docs
             +- CMakeLists.txt
             +- doxyfile.in
         +- manual
             +- CMakeLists.txt
             +- <工程名称>.tex
    +- source
         +- README.md  简要说明各模块，例如哪些是命令行可执行程序模块，哪些是GUI可执行程序模块，哪些是静态库，动态库, 代码检查使用的哪种linter
         +- CMakeLists.txt 工程下开发的模块列表(add_subdirectory), 还有适用于所有模块的配置
         +- ProjectModule1   工程下开发实现的模块1
              +- CMakeLists.txt 适用于该模块的配置, 可以单独使用cmake根据CMakeLists.txt配置生成模块目标
              +- include
              +- src
         +- ProjectModule2   工程下开发实现的模块2
         +- baselib   工程下开发实现的模块示例baselib
              +- CMakeLists.txt 
              +- include
              +- src
         +- fiblib   工程下开发实现的模块示例fiblib
              +- CMakeLists.txt 
              +- include
              +- src
         +- examples 工程下开发实现的模块示例examples
              +- CMakeLists.txt 
              +- fibcmd
                  +- CMakeLists.txt 
                  +- src
              +- fibgui
                  +- CMakeLists.txt 
                  +- src
         +- ...
         +- ...
         +- ...
         +- ProjectModuleN   工程下开发实现的模块N
         +- test   单元测试
             +- CMakeLists.txt 
             +- googletest  单元测试依赖的 gtest 库
             +- ProjectModule1单元测试
                 +- CMakeLists.txt 
                 +- src
             +- ProjectModule2单元测试
                 +- CMakeLists.txt 
                 +- src
             +- fiblib-test  模块fiblib的单元测试
                 +- CMakeLists.txt 
                 +- src
                     +- main.cpp
                     +- fibonacci_test.cpp
             +- ...
             +- ...
             +- ...
             +- ProjectModuleN单元测试
                 +- CMakeLists.txt 
                 +- src

```