// Generated by gencpp from file nav_planner/pointDataArray.msg
// DO NOT EDIT!


#ifndef NAV_PLANNER_MESSAGE_POINTDATAARRAY_H
#define NAV_PLANNER_MESSAGE_POINTDATAARRAY_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <nav_planner/pointData.h>

namespace nav_planner
{
template <class ContainerAllocator>
struct pointDataArray_
{
  typedef pointDataArray_<ContainerAllocator> Type;

  pointDataArray_()
    : centerPointsArray()  {
    }
  pointDataArray_(const ContainerAllocator& _alloc)
    : centerPointsArray(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector< ::nav_planner::pointData_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::nav_planner::pointData_<ContainerAllocator> >::other >  _centerPointsArray_type;
  _centerPointsArray_type centerPointsArray;





  typedef boost::shared_ptr< ::nav_planner::pointDataArray_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::nav_planner::pointDataArray_<ContainerAllocator> const> ConstPtr;

}; // struct pointDataArray_

typedef ::nav_planner::pointDataArray_<std::allocator<void> > pointDataArray;

typedef boost::shared_ptr< ::nav_planner::pointDataArray > pointDataArrayPtr;
typedef boost::shared_ptr< ::nav_planner::pointDataArray const> pointDataArrayConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::nav_planner::pointDataArray_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::nav_planner::pointDataArray_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::nav_planner::pointDataArray_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::nav_planner::pointDataArray_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nav_planner::pointDataArray_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nav_planner::pointDataArray_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nav_planner::pointDataArray_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nav_planner::pointDataArray_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::nav_planner::pointDataArray_<ContainerAllocator> >
{
  static const char* value()
  {
    return "a6fd97a183dd670c18cc87cf38ec2735";
  }

  static const char* value(const ::nav_planner::pointDataArray_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xa6fd97a183dd670cULL;
  static const uint64_t static_value2 = 0x18cc87cf38ec2735ULL;
};

template<class ContainerAllocator>
struct DataType< ::nav_planner::pointDataArray_<ContainerAllocator> >
{
  static const char* value()
  {
    return "nav_planner/pointDataArray";
  }

  static const char* value(const ::nav_planner::pointDataArray_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::nav_planner::pointDataArray_<ContainerAllocator> >
{
  static const char* value()
  {
    return "pointData[] centerPointsArray\n\
\n\
================================================================================\n\
MSG: nav_planner/pointData\n\
float32 x\n\
float32 y\n\
float32 z\n\
";
  }

  static const char* value(const ::nav_planner::pointDataArray_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::nav_planner::pointDataArray_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.centerPointsArray);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct pointDataArray_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::nav_planner::pointDataArray_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::nav_planner::pointDataArray_<ContainerAllocator>& v)
  {
    s << indent << "centerPointsArray[]" << std::endl;
    for (size_t i = 0; i < v.centerPointsArray.size(); ++i)
    {
      s << indent << "  centerPointsArray[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::nav_planner::pointData_<ContainerAllocator> >::stream(s, indent + "    ", v.centerPointsArray[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // NAV_PLANNER_MESSAGE_POINTDATAARRAY_H
