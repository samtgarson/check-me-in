class SilentListeners.Menu extends SilentListener
  @silentListenerSelector: '#menu'

  instantiate: =>
    @button = $('.hamburger')
    @_bindEvents()

  _bindEvents: =>
    @button.click ->
      $('body').toggleClass('menu-open')
      $(this).toggleClass('is-active')
