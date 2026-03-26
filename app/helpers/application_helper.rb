module ApplicationHelper
  # Rails 8: dom_id helper
  def dom_id(record, prefix = nil)
    ActionView::RecordIdentifier.dom_id(record, prefix)
  end
end
