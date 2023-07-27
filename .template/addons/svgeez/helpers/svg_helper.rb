# frozen_string_literal: true

module SvgHelper
  DEFAULT_SVG_ATTRIBUTES = {
    width: '16',
    height: '16'
  }.freeze

  def svg_tag(html: {}, icon_id: '')
    svg_attributes = DEFAULT_SVG_ATTRIBUTES.merge(html)

    tag.svg(tag.use(nil, 'xlink:href' => "##{icon_id}"), **svg_attributes)
  end
end
