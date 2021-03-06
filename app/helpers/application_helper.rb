module ApplicationHelper

  def errors_for(object)
    render "/shared/form_errors", object: object if object.errors.any?
  end
  alias :form_errors :errors_for

  def highlight_code(code)
    CodeRay.scan(code, :ruby).div(:css => :class)
  end

  def offset(per_page = Kaminari.config.default_per_page)
    ((params[:page] || 1).to_i - 1) * per_page
  end

  def google_analytics_js
    "<script type='text/javascript'>

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{ENV['google_analytics_id']}']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>".html_safe
  end

  def gravatar_url(email, options = {})
    options = {r: "pg", d: "mm", s: 24}.merge(options) # pg rating
    id = Digest::MD5.hexdigest(email)
    "http://gravatar.com/avatar/#{id}.png?#{options.to_query}"
  end

  def gravatar_image(email, size = 24, css = {})
    email ||= ""
    options = {s: size}
    css = {class: "gravatar"}.merge(css)
    image_tag gravatar_url(email, options), css
  end
end
