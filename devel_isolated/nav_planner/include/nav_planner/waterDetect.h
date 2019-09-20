// Generated by gencpp from file nav_planner/waterDetect.msg
// DO NOT EDIT!


#ifndef NAV_PLANNER_MESSAGE_WATERDETECT_H
#define NAV_PLANNER_MESSAGE_WATERDETECT_H

#include <ros/service_traits.h>


#include <nav_planner/waterDetectRequest.h>
#include <nav_planner/waterDetectResponse.h>


namespace nav_planner
{

struct waterDetect
{

typedef waterDetectRequest Request;
typedef waterDetectResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct waterDetect
} // namespace nav_planner


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::nav_planner::waterDetect > {
  static const char* value()
  {
    return "1db7aa6468aac5d9a2abbc22f9783ea6";
  }

  static const char* value(const ::nav_planner::waterDetect&) { return value(); }
};

template<>
struct DataType< ::nav_planner::waterDetect > {
  static const char* value()
  {
    return "nav_planner/waterDetect";
  }

  static const char* value(const ::nav_planner::waterDetect&) { return value(); }
};


// service_traits::MD5Sum< ::nav_planner::waterDetectRequest> should match 
// service_traits::MD5Sum< ::nav_planner::waterDetect > 
template<>
struct MD5Sum< ::nav_planner::waterDetectRequest>
{
  static const char* value()
  {
    return MD5Sum< ::nav_planner::waterDetect >::value();
  }
  static const char* value(const ::nav_planner::waterDetectRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::nav_planner::waterDetectRequest> should match 
// service_traits::DataType< ::nav_planner::waterDetect > 
template<>
struct DataType< ::nav_planner::waterDetectRequest>
{
  static const char* value()
  {
    return DataType< ::nav_planner::waterDetect >::value();
  }
  static const char* value(const ::nav_planner::waterDetectRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::nav_planner::waterDetectResponse> should match 
// service_traits::MD5Sum< ::nav_planner::waterDetect > 
template<>
struct MD5Sum< ::nav_planner::waterDetectResponse>
{
  static const char* value()
  {
    return MD5Sum< ::nav_planner::waterDetect >::value();
  }
  static const char* value(const ::nav_planner::waterDetectResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::nav_planner::waterDetectResponse> should match 
// service_traits::DataType< ::nav_planner::waterDetect > 
template<>
struct DataType< ::nav_planner::waterDetectResponse>
{
  static const char* value()
  {
    return DataType< ::nav_planner::waterDetect >::value();
  }
  static const char* value(const ::nav_planner::waterDetectResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // NAV_PLANNER_MESSAGE_WATERDETECT_H
