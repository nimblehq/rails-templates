From time to time, we need to add new SVG icons to the app. This document describes the steps to do that.

## Gems
The following 2 gems are used to handle SVG:
- [svgeez](https://github.com/jgarber623/svgeez): for generating an SVG sprite from a folder of SVG icons. Requires Node.js and SVGO 1.3.2.
- [inline_svg](https://github.com/jamesmartin/inline_svg): to use inline SVG for styling SVG with CSS

## Node dependencies
- [svgo](https://www.npmjs.com/package/svgo): Optimizes SVG sprite file size
  ```sh
  npm -g install svgo@1.3.2
  ```

## Add a new icon:
- Export the SVG icon from Figma
- Add the icon to `app/assets/images/icons` directory.
- Run the following command to generate the new `app/assets/images/icon-sprite.svg` file which contains all of the icons in the `icons` directory
  ```sh
  bin/svg-sprite
  ```

## Use the new icon
- Add the `icon-sprite.svg` file to the layout of the page
  ```erb
  <body>
    <%= inline_svg_tag 'icon-sprite.svg' %>
  </body>
  ```
- Use the `svg_tag` provided by the `SvgHelper` (app/helpers/svg_helper.rb) and provided `icon_id` matched with icon file name with prefix `icon-`:
  ```erb
  <%= svg_tag icon_id: 'icon-[icon-file-name]', html: {} %>

  <!-- example: -->
  <%= svg_tag icon_id: 'icon-contacts', html: { class: 'icon' } %>
  ```
