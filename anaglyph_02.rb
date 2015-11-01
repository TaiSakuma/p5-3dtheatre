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
def add_left_right_pages_for page, eye_distance
  Sketchup.active_model.pages.selected_page = page
  Sketchup.active_model.active_view.refresh
  camera = Sketchup.active_model.active_view.camera
  l, r = compute_left_right_camera_args camera.eye, eye_distance, camera.target, camera.up
  add_frames l, "#{page.name} left"
  add_frames r, "#{page.name} right"
end

##__________________________________________________________________||
eye_distance = 5.cm

pages = Sketchup.active_model.pages.collect { |p| p }

pages.each do |page|
  add_left_right_pages_for page, eye_distance
end

##__________________________________________________________________||
