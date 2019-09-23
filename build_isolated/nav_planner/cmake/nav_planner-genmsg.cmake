# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "nav_planner: 2 messages, 4 services")

set(MSG_I_FLAGS "-Inav_planner:/home/kalana/FYP/src/nav_planner/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Ioctomap_msgs:/opt/ros/kinetic/share/octomap_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(nav_planner_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv" NAME_WE)
add_custom_target(_nav_planner_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "nav_planner" "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv" ""
)

get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointData.msg" NAME_WE)
add_custom_target(_nav_planner_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "nav_planner" "/home/kalana/FYP/src/nav_planner/msg/pointData.msg" ""
)

get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv" NAME_WE)
add_custom_target(_nav_planner_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "nav_planner" "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv" ""
)

get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv" NAME_WE)
add_custom_target(_nav_planner_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "nav_planner" "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv" ""
)

get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv" NAME_WE)
add_custom_target(_nav_planner_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "nav_planner" "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv" ""
)

get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg" NAME_WE)
add_custom_target(_nav_planner_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "nav_planner" "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg" "nav_planner/pointData"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner
)
_generate_msg_cpp(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg"
  "${MSG_I_FLAGS}"
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner
)

### Generating Services
_generate_srv_cpp(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner
)
_generate_srv_cpp(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner
)
_generate_srv_cpp(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner
)
_generate_srv_cpp(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner
)

### Generating Module File
_generate_module_cpp(nav_planner
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(nav_planner_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(nav_planner_generate_messages nav_planner_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_cpp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointData.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_cpp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_cpp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_cpp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_cpp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_cpp _nav_planner_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(nav_planner_gencpp)
add_dependencies(nav_planner_gencpp nav_planner_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS nav_planner_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner
)
_generate_msg_eus(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg"
  "${MSG_I_FLAGS}"
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner
)

### Generating Services
_generate_srv_eus(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner
)
_generate_srv_eus(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner
)
_generate_srv_eus(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner
)
_generate_srv_eus(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner
)

### Generating Module File
_generate_module_eus(nav_planner
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(nav_planner_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(nav_planner_generate_messages nav_planner_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_eus _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointData.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_eus _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_eus _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_eus _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_eus _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_eus _nav_planner_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(nav_planner_geneus)
add_dependencies(nav_planner_geneus nav_planner_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS nav_planner_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner
)
_generate_msg_lisp(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg"
  "${MSG_I_FLAGS}"
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner
)

### Generating Services
_generate_srv_lisp(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner
)
_generate_srv_lisp(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner
)
_generate_srv_lisp(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner
)
_generate_srv_lisp(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner
)

### Generating Module File
_generate_module_lisp(nav_planner
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(nav_planner_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(nav_planner_generate_messages nav_planner_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_lisp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointData.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_lisp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_lisp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_lisp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_lisp _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_lisp _nav_planner_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(nav_planner_genlisp)
add_dependencies(nav_planner_genlisp nav_planner_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS nav_planner_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner
)
_generate_msg_nodejs(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg"
  "${MSG_I_FLAGS}"
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner
)

### Generating Services
_generate_srv_nodejs(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner
)
_generate_srv_nodejs(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner
)
_generate_srv_nodejs(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner
)
_generate_srv_nodejs(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner
)

### Generating Module File
_generate_module_nodejs(nav_planner
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(nav_planner_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(nav_planner_generate_messages nav_planner_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_nodejs _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointData.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_nodejs _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_nodejs _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_nodejs _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_nodejs _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_nodejs _nav_planner_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(nav_planner_gennodejs)
add_dependencies(nav_planner_gennodejs nav_planner_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS nav_planner_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner
)
_generate_msg_py(nav_planner
  "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg"
  "${MSG_I_FLAGS}"
  "/home/kalana/FYP/src/nav_planner/msg/pointData.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner
)

### Generating Services
_generate_srv_py(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner
)
_generate_srv_py(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner
)
_generate_srv_py(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner
)
_generate_srv_py(nav_planner
  "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner
)

### Generating Module File
_generate_module_py(nav_planner
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(nav_planner_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(nav_planner_generate_messages nav_planner_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/waterDetect.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_py _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointData.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_py _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/goalControl.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_py _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseRotate.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_py _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/srv/baseDrive.srv" NAME_WE)
add_dependencies(nav_planner_generate_messages_py _nav_planner_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/kalana/FYP/src/nav_planner/msg/pointDataArray.msg" NAME_WE)
add_dependencies(nav_planner_generate_messages_py _nav_planner_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(nav_planner_genpy)
add_dependencies(nav_planner_genpy nav_planner_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS nav_planner_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_planner
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(nav_planner_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET octomap_msgs_generate_messages_cpp)
  add_dependencies(nav_planner_generate_messages_cpp octomap_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/nav_planner
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(nav_planner_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET octomap_msgs_generate_messages_eus)
  add_dependencies(nav_planner_generate_messages_eus octomap_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_planner
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(nav_planner_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET octomap_msgs_generate_messages_lisp)
  add_dependencies(nav_planner_generate_messages_lisp octomap_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/nav_planner
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(nav_planner_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET octomap_msgs_generate_messages_nodejs)
  add_dependencies(nav_planner_generate_messages_nodejs octomap_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_planner
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(nav_planner_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET octomap_msgs_generate_messages_py)
  add_dependencies(nav_planner_generate_messages_py octomap_msgs_generate_messages_py)
endif()
