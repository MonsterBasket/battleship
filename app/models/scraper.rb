class Scraper
  attr_reader :articles

  def initialize
    @dates = pick3
    @articles = []
    scrape
    split_articles
  end

  def pick3
    dates = {january: 31, february: 28, march: 31, april: 30, may: 31, june: 30, july: 31,
             august: 31, september: 30, october: 31, november: 30, december: 31}
    months = dates.keys.sample(3)
    date1 = [months[0], rand(dates[months[0]])]
    date2 = [months[1], rand(dates[months[1]])]
    date3 = [months[2], rand(dates[months[2]])]
    [date1, date2, date3]
  end

  def scrape
    html1 = URI.open("https://www.history.navy.mil/today-in-history/#{@dates[0][0]}-#{@dates[0][1]}.html")
    html2 = URI.open("https://www.history.navy.mil/today-in-history/#{@dates[1][0]}-#{@dates[1][1]}.html")
    html3 = URI.open("https://www.history.navy.mil/today-in-history/#{@dates[2][0]}-#{@dates[2][1]}.html")
    add_to_articles Nokogiri::HTML(html1)
    add_to_articles Nokogiri::HTML(html2)
    add_to_articles Nokogiri::HTML(html3)
  end

  def add_to_articles(doc)
    doc.css('.todayInHistoryListItem').each_with_index do |item, i|
      unless i.zero?
        title = "#{@dates[0][0].capitalize} #{@dates[0][1]} #{item.css('.todayInHistoryListDate').text}"
        @articles << {title: title, text: item.css('.todayInHistoryListSummary p').text}
      end
    end
  end

  def split_articles
    @articles.each do |item|
      temp = item[:text].split(' ', -1)
      item['lines'] = []
      item['lines'][0] = ''
      counter = 0
      temp.each do |word|
        item['lines'][counter] += "#{word} "
        if item['lines'][counter].length > 45
          counter += 1
          item['lines'][counter] = ''
        end
      end
    end
  end
end
