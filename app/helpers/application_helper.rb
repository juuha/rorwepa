module ApplicationHelper
  def edit_and_destroy_buttons(item)
    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-warning")
    del = link_to('Destroy', item, method: :delete,
                                   data: { confirm: 'Are you sure?' },
                                   class: "btn btn-danger")
    raw("#{edit} #{del}") if current_user
  end

  def round(number)
    number_with_precision(number, precision: 1)
  end
end
