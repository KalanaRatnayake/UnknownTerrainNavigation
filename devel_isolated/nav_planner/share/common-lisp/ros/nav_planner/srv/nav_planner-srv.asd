
(cl:in-package :asdf)

(defsystem "nav_planner-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "goalControl" :depends-on ("_package_goalControl"))
    (:file "_package_goalControl" :depends-on ("_package"))
  ))