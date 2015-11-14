module SubjectsHelper
  
  def link_to_image_add_enrollment(f, instructors, img, imghvr)
    
    new_enrollment = Enrollment.new
    id = new_enrollment.object_id
    fields = f.fields_for(:enrollment_attributes, new_enrollment, child_index: id) do |builder|
      render("shared/enrollment_fields", f: builder, local_instructors: instructors)
    end
    link_to(image_tag(img,  :mouseover => imghvr, class: "add_enrollment_img"), '#', class: "add_enrollment", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def orig_link_to_image_add_enrollment(f, instructors, img, imghvr)
    
    new_enrollment = Enrollment.new
    id = new_enrollment.object_id
    fields = f.fields_for(:enrollment_attributes, new_enrollment, child_index: id) do |builder|
      render("shared/enrollment_fields", f: builder, local_instructors: instructors)
    end
    link_to(image_tag(img,  :mouseover => imghvr, class: "add_enrollment_img"), '#', class: "add_enrollment", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
end
