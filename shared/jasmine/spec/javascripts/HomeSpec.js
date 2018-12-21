describe('Home', () => {
  beforeEach(() => {
    document.body.innerHTML = __html__['spec/javascripts/fixtures/home.html'];
  });

  it('renders welcome section', () => {
    expect(document.querySelector('section.welcome')).toBeVisible();
  });
});
