require 'nokogiri'
require 'open-uri'
require 'json'

# Grab the latest version of the emoji list from unicode.org and convert to
# JSON. The JSON contains an array of hashes each representing an emoji.
module EmojiListExtractor
  def self.execute
    html = download_emoji_list_html
    rows = extract_table_rows(html)
    emojis = emoji_hash(rows)
    save_as_json(emojis)
  end

  def self.emoji_hash(rows)
    category, subcategory = nil
    emojis = []

    rows.each do |row|
      category = category(category, row)
      subcategory = subcategory(subcategory, row)
      next if row_type(row) != 'data'
      emoji = emoji(category, subcategory, row)
      emojis.push(emoji)
    end
    emojis
  end

  def self.download_emoji_list_html
    url = 'https://unicode.org/emoji/charts/emoji-list.html'
    URI.parse(url).open
  end

  def self.extract_table_rows(html)
    page = Nokogiri::HTML(html)
    page.css('table > tr')
  end

  def self.category(category, row)
    return category if row_type(row) != 'category'
    row.css('.bighead').text
  end

  def self.subcategory(subcategory, row)
    return subcategory if row_type(row) != 'subcategory'
    row.css('.mediumhead').text
  end

  def self.emoji(category, subcategory, row)
    columns = row.css('td')
    {
      no: columns[0].text,
      code: columns[1].text,
      sample: columns[2].at_css('img')['alt'],
      cldr_short_name: columns[3].text,
      other_keywords: columns[4].text,
      category: category,
      subcategory: subcategory
    }
  end

  def self.row_type(row)
    if row.at_css('.bighead')
      'category'
    elsif row.at_css('.mediumhead')
      'subcategory'
    elsif row.at_css('.code')
      'data'
    end
  end

  def self.save_as_json(hash)
    file = File.open('./emojis.json', 'w+')
    file.write(JSON.pretty_generate(hash))
    file.close
  end
end

EmojiListExtractor.execute
