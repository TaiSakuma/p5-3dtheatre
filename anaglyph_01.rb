# Tai Sakuma <sakuma@fnal.gov>
require 'sketchup'

##__________________________________________________________________||
def compute_left_right_camera_args eye_center, eye_distance, target, up,

  line_of_sight = (target - eye_center)

  ## the line perpendicular to the line of sight and the direction of
  ## up
  line_of_two_eyes = line_of_sight.cross up

  line_of_two_eyes.length = eye_distance/2.0

  eye_left = eye_center - line_of_two_eyes
  eye_right =  eye_center + line_of_two_eyes

  return [eye_left, target, up], [eye_right, target, up]
end

##__________________________________________________________________||
def add_frames camera_args, name
  Sketchup.active_model.active_view.camera = Sketchup::Camera.new *camera_args
  Sketchup.active_model.pages.add name
end

##__________________________________________________________________||
eye_distance = 5.cm

# an array of arguments of compute_left_right_camera_args
camera_sequences = [
  [Geom::Point3d.new(26.10.m,  -18.8.m, 29.80.m), eye_distance, Geom::Point3d.new( -4.80.m,  6.40.m,  9.50.m), Geom::Vector3d.new(-0.35, 0.29, 0.90)],
  ## [Geom::Point3d.new(15.33.m, -11.01.m, 23.59.m), eye_distance, Geom::Point3d.new(-15.55.m, 14.20.m,  3.29.m), Geom::Vector3d.new(-0.35, 0.29, 0.90)],
  ## [Geom::Point3d.new(12.61.m,  -6.53.m, 18.03.m), eye_distance, Geom::Point3d.new(-24.11.m, 15.72.m,  5.53.m), Geom::Vector3d.new(-0.23, 0.14, 0.96)],
  ## [Geom::Point3d.new( 8.12.m,  -4.31.m, 17.00.m), eye_distance, Geom::Point3d.new(-28.57.m, 17.96.m,  4.50.m), Geom::Vector3d.new(-0.23, 0.14, 0.96)],
  [Geom::Point3d.new( 9.36.m,  -6.08.m, 16.87.m), eye_distance, Geom::Point3d.new( -6.42.m,  6.63.m, 11.10.m), Geom::Vector3d.new(-0.23, 0.14, 0.96)],
  [Geom::Point3d.new(10.98.m,  -0.58.m, 15.14.m), eye_distance, Geom::Point3d.new(-9.83.m,   1.59.m, 12.56.m), Geom::Vector3d.new(0, 0, 1)],
]

camera_args_left = [ ]
camera_args_right = [ ]
camera_sequences.each do |args|
  l, r = compute_left_right_camera_args *args
  camera_args_left << l
  camera_args_right << r
end

camera_args_left.each.with_index(1) do |arg, index|
  name = "left#{'%03d' % index}"
  add_frames arg, name
end

camera_args_right.each.with_index(1) do |arg, index|
  name = "right#{'%03d' % index}"
  add_frames arg, name
end

##__________________________________________________________________||
