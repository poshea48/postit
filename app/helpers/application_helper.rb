module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end

  def calculate_votes(obj)
    number_of_positive_votes(obj) - number_of_negative_votes(obj)
  end

  def number_of_positive_votes(obj)
    obj.votes.select {|vote| vote.vote == true}.size
  end

  def number_of_negative_votes(obj)
    obj.votes.select {|vote| vote.vote == false}.size
  end

  # def ajax_flash(div)
  #   flash_div = ""
  #   response = ""
  #
  #   flash.each do |name, msg|
  #     if msg.is_a?(String)
  #       flash_div = "<div class=\"alert alert-#{name == :notice ? "success" : "error"}">
  #         <a class="close" data-dismiss="alert">&#215;</a>
  #         <%= content_tag :div, msg, :id => "flash_#{name}" %>
  #       </div>
  #     <% end %>
  #   <% end %>
  # end



  # def format_time(date)
  #   hours, minutes, secs = date.to_s.split(' ')[1].split(":")
  #   time_suffix = hours.to_i >= 12 ? 'pm' : 'am'
  #
  #   "#{date.month}/#{date.day}/#{date.year} #{format_hours hours}:#{minutes}#{time_suffix}"
  # end
  #
  # def format_hours(hours)
  #   new_hours = hours.to_i > 12 ? hours.to_i % 12 : hours
  #   new_hours == "00" ? 12 : new_hours
  # end

end
