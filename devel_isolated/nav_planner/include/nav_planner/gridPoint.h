// Generated by gencpp from file nav_planner/gridPoint.msg
// DO NOT EDIT!


#ifndef NAV_PLANNER_MESSAGE_GRIDPOINT_H
#define NAV_PLANNER_MESSAGE_GRIDPOINT_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace nav_planner
{
template <class ContainerAllocator>
struct gridPoint_
{
  typedef gridPoint_<ContainerAllocator> Type;

  gridPoint_()
    : init(0)
    , proc(0)
    , path(0)  {
    }
  gridPoint_(const ContainerAllocator& _alloc)
    : init(0)
    , proc(0)
    , path(0)  {
  (void)_alloc;
    }



   typedef int8_t _init_type;
  _init_type init;

   typedef int8_t _proc_type;
  _proc_type proc;

   typedef int8_t _path_type;
  _path_type path;





  typedef boost::shared_ptr< ::nav_planner::gridPoint_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::nav_planner::gridPoint_<ContainerAllocator> const> ConstPtr;

}; // struct gridPoint_

typedef ::nav_planner::gridPoint_<std::allocator<void> > gridPoint;

typedef boost::shared_ptr< ::nav_planner::gridPoint > gridPointPtr;
typedef boost::shared_ptr< ::nav_planner::gridPoint const> gridPointConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::nav_planner::gridPoint_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::nav_planner::gridPoint_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace nav_planner

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'nav_planner': ['/home/kalana/FYP/src/nav_planner/msg'], 'octomap_msgs': ['/opt/ros/kinetic/share/octomap_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::nav_planner::gridPoint_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::nav_planner::gridPoint_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nav_planner::gridPoint_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nav_planner::gridPoint_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nav_planner::gridPoint_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nav_planner::gridPoint_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::nav_planner::gridPoint_<ContainerAllocator> >
{
  static const char* value()
  {
    return "6473cd93ef160624bb8e42a565e25ccb";
  }

  static const char* value(const ::nav_planner::gridPoint_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x6473cd93ef160624ULL;
  static const uint64_t static_value2 = 0xbb8e42a565e25ccbULL;
};

template<class ContainerAllocator>
struct DataType< ::nav_planner::gridPoint_<ContainerAllocator> >
{
  static const char* value()
  {
    return "nav_planner/gridPoint";
  }

  static const char* value(const ::nav_planner::gridPoint_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::nav_planner::gridPoint_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int8 init\n\
int8 proc\n\
int8 path\n\
";
  }

  static const char* value(const ::nav_planner::gridPoint_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::nav_planner::gridPoint_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.init);
      stream.next(m.proc);
      stream.next(m.path);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct gridPoint_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::nav_planner::gridPoint_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::nav_planner::gridPoint_<ContainerAllocator>& v)
  {
    s << indent << "init: ";
    Printer<int8_t>::stream(s, indent + "  ", v.init);
    s << indent << "proc: ";
    Printer<int8_t>::stream(s, indent + "  ", v.proc);
    s << indent << "path: ";
    Printer<int8_t>::stream(s, indent + "  ", v.path);
  }
};

} // namespace message_operations
} // namespace ros

#endif // NAV_PLANNER_MESSAGE_GRIDPOINT_H