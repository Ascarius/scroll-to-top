(function($, window, document) {
  "use strict";
  var $body, $window, ScrollToTop, old, scrollTop;
  $window = $(window);
  scrollTop = $window.scrollTop();
  $body = $(document.body);
  $window.scroll(function() {
    scrollTop = $window.scrollTop();
  });
  ScrollToTop = (function() {
    function ScrollToTop(element, options) {
      this.$element = $(element);
      this.options = $.extend({}, this.DEFAULTS, options);
      $window.scroll($.proxy(this.update, this));
      $window.resize($.proxy(this.update, this));
      this.$element.click($.proxy(this.go, this));
      this.update();
    }

    ScrollToTop.prototype.DEFAULTS = {
      fromScrollTop: 200,
      duration: 400,
      easing: 'swing'
    };

    ScrollToTop.prototype.update = function() {
      var options;
      options = this.options;
      if (scrollTop > options.fromScrollTop) {
        if (this.hidden) {
          this.$element.fadeIn();
          this.hidden = false;
        }
      } else {
        if (!this.hidden) {
          this.$element.fadeOut();
          this.hidden = true;
        }
      }
      return this;
    };

    ScrollToTop.prototype.go = function(e) {
      var options;
      options = this.options;
      if (e) {
        e.preventDefault();
      }
      $body.animate({
        scrollTop: 0
      }, options.duration, options.easing);
      return this;
    };

    return ScrollToTop;

  })();
  old = $.fn.scrolltotop;
  $.fn.scrolltotop = function(o) {
    return this.each(function() {
      var $this, options;
      $this = $(this);
      options = typeof o === 'object' && o;
      if (!$this.data('scrolltotop')) {
        $this.data('scrolltotop', new ScrollToTop(this(options)));
      }
    });
  };
  $.fn.scrolltotop.Constructor = ScrollToTop;
  $.fn.scrolltotop.noConflict = function() {
    $.fn.scrolltotop = old;
  };
  return $(function() {
    $('[data-spy=scrolltotop]').each(function() {
      var $this;
      $this = $(this);
      $this.scrolltotop($this.data());
    });
  });
})(jQuery, window, document);
