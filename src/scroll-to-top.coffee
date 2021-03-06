(($, window, document) ->

  "use strict"


  # SHARED VARS
  # ===========

  $window   = $ window


  # CLASS DEFINITION
  # ================

  class ScrollToTop

    constructor: (element, options) ->

      @$element = $ element
      @options  = $.extend {}, @DEFAULTS, options

      @$target  = $ options.target

      @$target.scroll $.proxy @update, this
      $window.resize $.proxy @update, this
      @$element.click $.proxy @go, this

      @update()

    DEFAULTS:

      # Pixels from top from where displaying button
      fromScrollTop: 200

      # Duration of scrolling animation
      duration:      400

      # Easing effect of animation
      easing:        'swing',

      # Target to spy
      target:        'window'

    update: ->

      options = @options

      if @$target.scrollTop() > options.fromScrollTop

        if @hidden
          @$element.fadeIn()
          @hidden = false

      else

        if not @hidden
          @$element.fadeOut()
          @hidden = true

      return this

    go: (e) ->
      options = @options

      e.preventDefault() if e

      @$target.animate { scrollTop: 0 }, options.duration, options.easing

      return this


  # PLUGIN DEFINITION
  # =================

  old = $.fn.scrolltotop

  $.fn.scrolltotop = (o) ->
    return @.each ->
      $this   = $(this)
      options = typeof o is 'object' && o

      if not $this.data 'scrolltotop'
        $this.data 'scrolltotop', new ScrollToTop this, options

      return

  $.fn.scrolltotop.Constructor = ScrollToTop


  # NO CONFLICT
  # ===========

  $.fn.scrolltotop.noConflict = ->
    $.fn.scrolltotop = old
    return this


  # DATA-API
  # ========

  $ ->
    $('[data-spy=scrolltotop]').each ->
      $this = $ this
      $this.scrolltotop $this.data()
      return
    return

) jQuery, window, document
