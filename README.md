# SrtParser2

https://github.com/cpetersen/srt/issues/29  
空行を含む srt をパースするための gem です。

```
1
00:00:03,500 --> 00:00:12,450

[音楽]

2
00:00:12,450 --> 00:00:12,460



3
00:00:12,460 --> 00:00:13,860

ん
```

```ruby
result = SrtParser2.parse(srt_body)
expect(result.lines[0]).to have_attributes(sequence: 1, text: ['[音楽]'])
expect(result.lines[1]).to have_attributes(sequence: 2, text: [])
expect(result.lines[2]).to have_attributes(sequence: 3, text: ['ん'])
```

## Usage

```ruby
result = SrtParser2.parse(srt_body)
result.lines.each do |line|
  puts line.text
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/srt_parser2.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
