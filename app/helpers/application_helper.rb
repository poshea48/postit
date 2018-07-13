module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime(dt)
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
