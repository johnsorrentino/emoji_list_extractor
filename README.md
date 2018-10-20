# Emoji List Extractor

Grabs the latest version of emojis from unicode.org (https://unicode.org/emoji/charts/emoji-list.html) and converts the table into a nice JSON format. 

## Usage

The list of emojis and their metadata is updated over time. To update the JSON file run the following Ruby script.

```ruby
ruby emoji_list_extractor.rb
```

## Example

```json
[
  {
    "no": "1",
    "code": "U+1F600",
    "sample": "😀",
    "cldr_short_name": "grinning face",
    "other_keywords": "face | grin | grinning face",
    "category": "Smileys",
    "subcategory": "face-smiling"
  },
  {
    "no": "2",
    "code": "U+1F603",
    "sample": "😃",
    "cldr_short_name": "grinning face with big eyes",
    "other_keywords": "face | grinning face with big eyes | mouth | open | smile",
    "category": "Smileys",
    "subcategory": "face-smiling"
  },
  {
    "no": "3",
    "code": "U+1F604",
    "sample": "😄",
    "cldr_short_name": "grinning face with smiling eyes",
    "other_keywords": "eye | face | grinning face with smiling eyes | mouth | open | smile",
    "category": "Smileys",
    "subcategory": "face-smiling"
  }
]
```
