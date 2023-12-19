# frozen_string_literal: true

describe 'CRUD Addon - application layout' do
  it 'attaches the current locale to the html tag' do
    expect(file('app/views/layouts/application.html.slim')).to contain('html lang=I18n.locale')
  end

  it 'loads the stylesheet entry file in the layout' do
    expect(file('app/views/layouts/application.html.slim')).to contain("javascript_include_tag 'application'")
  end

  it 'loads the javascript entry file in the layout' do
    expect(file('app/views/layouts/application.html.slim')).to contain("stylesheet_link_tag 'application'")
  end
end
