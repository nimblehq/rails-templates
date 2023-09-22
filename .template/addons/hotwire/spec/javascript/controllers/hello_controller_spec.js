import { Application } from '@hotwired/stimulus';

import HelloController from '../../../app/javascript/controllers/hello_controller';

describe('HelloConttroller', () => {
  describe('#greet', () => {
    beforeEach(() => {
      document.body.innerHTML = `<div id="element" data-controller="hello"></div>`;

      const application = Application.start();
      application.register('hello', HelloController);
    });

    it('displays hello world into the main element', () => {
      const element = document.getElementById('element');

      expect(element.textContent).toEqual('Hello World!');
    });
  });
});
