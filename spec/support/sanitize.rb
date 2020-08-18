# frozen_string_literal: true

def sanitize(html)
  ActionView::Base.full_sanitizer.sanitize(html)
end
