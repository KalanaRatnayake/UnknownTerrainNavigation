// Generated by gencpp from file nav_planner/gridRow.msg
// DO NOT EDIT!


#ifndef NAV_PLANNER_MESSAGE_GRIDROW_H
#define NAV_PLANNER_MESSAGE_GRIDROW_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <nav_planner/gridPoint.h>

namespace nav_planner
{
template <class ContainerAllocator>
struct gridRow_
{
  typedef gridRow_<ContainerAllocator> Type;

  gridRow_()
    : row()  {
    }
  gridRow_(const ContainerAllocator& _alloc)
    : row(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector< ::nav_planner::gridPoint_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::nav_planner::gridPoint_<ContainerAllocator> >::other >  _row_type;
  _row_type row;





  typedef boost::shared_ptr< ::nav_planner::gridRow_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::nav_planner::gridRow_<ContainerAllocator> const> ConstPtr;

}; // struct gridRow_

typedef ::nav_planner::gridRow_<std::allocator<void> > gridRow;

typedef boost::shared_ptr< ::nav_planner::gridRow > gridRowPtr;
typedef boost::shared_ptr< ::nav_planner::gridRow const> gridRowConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::nav_planner::gridRow_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::nav_planner::gridRow_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace nav_planner

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'nav_planner': ['/home/kalana/FYP/src/nav_planner/msg'], 'octomap_msgs': ['/opt/ros/kinetic/share/octomap_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::nav_planner::gridRow_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::nav_planner::gridRow_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nav_planner::gridRow_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nav_planner::gridRow_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nav_planner::gridRow_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nav_planner::gridRow_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::nav_planner::gridRow_<ContainerAllocator> >
{
  static const char* value()
  {
    return "b79fca104e1ff6a6b0cdcd662d07d607";
  }

  static const char* value(const ::nav_planner::gridRow_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xb79fca104e1ff6a6ULL;
  static const uint64_t static_value2 = 0xb0cdcd662d07d607ULL;
};

template<class ContainerAllocator>
struct DataType< ::nav_planner::gridRow_<ContainerAllocator> >
{
  static const char* value()
  {
    return "nav_planner/gridRow";
  }

  static const char* value(const ::nav_planner::gridRow_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::nav_planner::gridRow_<ContainerAllocator> >
{
  static const char* value()
  {
    return "gridPoint[] row\n\
\n\
================================================================================\n\
MSG: nav_planner/gridPoint\n\
int8 init\n\
int8 proc\n\
";
  }

  static const char* value(const ::nav_planner::gridRow_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::nav_planner::gridRow_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.row);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct gridRow_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::nav_planner::gridRow_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::nav_planner::gridRow_<ContainerAllocator>& v)
  {
    s << indent << "row[]" << std::endl;
    for (size_t i = 0; i < v.row.size(); ++i)
    {
      s << indent << "  row[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::nav_planner::gridPoint_<ContainerAllocator> >::stream(s, indent + "    ", v.row[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // NAV_PLANNER_MESSAGE_GRIDROW_H
