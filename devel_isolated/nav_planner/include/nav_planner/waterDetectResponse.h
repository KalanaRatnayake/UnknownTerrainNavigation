// Generated by gencpp from file nav_planner/waterDetectResponse.msg
// DO NOT EDIT!


#ifndef NAV_PLANNER_MESSAGE_WATERDETECTRESPONSE_H
#define NAV_PLANNER_MESSAGE_WATERDETECTRESPONSE_H


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
struct waterDetectResponse_
{
  typedef waterDetectResponse_<ContainerAllocator> Type;

  waterDetectResponse_()
    : left(0.0)
    , middle(0.0)
    , right(0.0)  {
    }
  waterDetectResponse_(const ContainerAllocator& _alloc)
    : left(0.0)
    , middle(0.0)
    , right(0.0)  {
  (void)_alloc;
    }



   typedef float _left_type;
  _left_type left;

   typedef float _middle_type;
  _middle_type middle;

   typedef float _right_type;
  _right_type right;





  typedef boost::shared_ptr< ::nav_planner::waterDetectResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::nav_planner::waterDetectResponse_<ContainerAllocator> const> ConstPtr;

}; // struct waterDetectResponse_

typedef ::nav_planner::waterDetectResponse_<std::allocator<void> > waterDetectResponse;

typedef boost::shared_ptr< ::nav_planner::waterDetectResponse > waterDetectResponsePtr;
typedef boost::shared_ptr< ::nav_planner::waterDetectResponse const> waterDetectResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::nav_planner::waterDetectResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::nav_planner::waterDetectResponse_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::nav_planner::waterDetectResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::nav_planner::waterDetectResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nav_planner::waterDetectResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nav_planner::waterDetectResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nav_planner::waterDetectResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nav_planner::waterDetectResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::nav_planner::waterDetectResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "103e35c87f127f93102b26951773e9e2";
  }

  static const char* value(const ::nav_planner::waterDetectResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x103e35c87f127f93ULL;
  static const uint64_t static_value2 = 0x102b26951773e9e2ULL;
};

template<class ContainerAllocator>
struct DataType< ::nav_planner::waterDetectResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "nav_planner/waterDetectResponse";
  }

  static const char* value(const ::nav_planner::waterDetectResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::nav_planner::waterDetectResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 left\n\
float32 middle\n\
float32 right\n\
\n\
";
  }

  static const char* value(const ::nav_planner::waterDetectResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::nav_planner::waterDetectResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.left);
      stream.next(m.middle);
      stream.next(m.right);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct waterDetectResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::nav_planner::waterDetectResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::nav_planner::waterDetectResponse_<ContainerAllocator>& v)
  {
    s << indent << "left: ";
    Printer<float>::stream(s, indent + "  ", v.left);
    s << indent << "middle: ";
    Printer<float>::stream(s, indent + "  ", v.middle);
    s << indent << "right: ";
    Printer<float>::stream(s, indent + "  ", v.right);
  }
};

} // namespace message_operations
} // namespace ros

#endif // NAV_PLANNER_MESSAGE_WATERDETECTRESPONSE_H
