class Scraper
  def initialize
    @dates = pick_3
  end

  def pick_3
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
    # html2 = URI.open("https://www.history.navy.mil/today-in-history/#{@dates[1][0]}-#{@dates[1][1]}.html")
    # html3 = URI.open("https://www.history.navy.mil/today-in-history/#{@dates[2][0]}-#{@dates[2][1]}.html")
    doc1 = Nokogiri::HTML(html1)
    # doc2 = Nokogiri::HTML(html2)
    # doc3 = Nokogiri::HTML(html3)

    articles = {}
    doc1.css(".todayInHistoryListItem").each_with_index do |item, i|
      title = "#{@dates[0][0].capitalize} #{@dates[0][1]} #{item.css(".todayInHistoryListDate").text}"
      articles[title.to_sym] = {
        content: item.css(".todayInHistoryListSummary p").text
      } unless i.zero?
    end
    binding.pry
  end
end