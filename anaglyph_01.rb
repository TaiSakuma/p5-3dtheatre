# Tai Sakuma <sakuma@fnal.gov>
require 'sketchup'


##__________________________________________________________________||
## the center of two eyes
eye = Geom::Point3d.new 10.98602.m, -0.586575.m, 15.146532.m

## the location of the target
target = Geom::Point3d.new -9.830495.m, 1.599027.m, 12.576466.m

up = [0,0,1]


line_of_sight = (target - eye)
puts line_of_sight
puts line_of_sight.class

## the line perpendicular to the line of sight and with the constant
## height
line_of_two_eyes = Geom::Vector3d.new line_of_sight[1], - line_of_sight[0], 0

eye_distance = 5.cm

line_of_two_eyes.length = eye_distance/2.0

eye_right =  eye + line_of_two_eyes
eye_left = eye - line_of_two_eyes

Sketchup.active_model.active_view.camera = Sketchup::Camera.new eye_right, target, up
Sketchup.active_model.pages.add
 
Sketchup.active_model.active_view.camera = Sketchup::Camera.new eye_left, target, up
Sketchup.active_model.pages.add

##__________________________________________________________________||
