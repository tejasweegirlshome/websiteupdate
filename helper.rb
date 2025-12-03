require 'pry'
require 'json'

module Helper
  def get_reviews
    @@response = `
    curl $'https://www.google.com/maps/rpc/listugcposts?authuser=0&hl=en&gl=np&pb=\u00211m6\u00211s0x39eb19359b5176c7%3A0xbcbf63e05ce69bfc\u00216m4\u00214m1\u00211e1\u00214m1\u00211e3\u00212m2\u00211i10\u00212s\u00215m2\u00211smNcvaYHtH5WO4-EPp6q9gAQ\u00217e81\u00218m9\u00212b1\u00213b1\u00215b1\u00217b1\u002112m4\u00211b1\u00212b1\u00214m1\u00211e1\u002111m7\u00211e3\u00212e1\u00215m2\u00211s\u00214e1\u00216m1\u00211i2\u002113m1\u00211e1' \
      -H 'accept: */*' \
      -H 'accept-language: en-GB,en;q=0.9' \
      -b 'AEC=AaJma5vBkSDHFG5jR750PPndBeG414B_jXlIGiogv8mwseUjHz5z3m_pwA; NID=526=b76gPzSIUjFoae2q5rr0PMVeJ3sTzQ6HrRO43qwd89NIbZ3aCOAVZN7-f1fbtlkbNVA8XjmJlA1lamAd3Yw03TKEXYeFcUdOAU1EVgy9LIDAmw_fLpU5zc8itLtwecW3NltgS1Sz9Y8mNKWiAXqu9--b9O3sWSIqjYjMIAdJK_F8szJHX7Y_FmtX-MtoNTfiOfuSxFI7GIliXh1iQRDkVfUuTwnWIzFvOw; __Secure-STRP=ADq1D7pdqpYjXMQCfh09NkukJf5XEVaoG20E15z1Vt032pIkbFUBkvqBBdy15zP0Ug_1VcN2R9jntCOiH7gnwDG29t4YPfzlUIl2' \
      -H 'downlink: 10' \
      -H 'priority: u=1, i' \
      -H 'referer: https://www.google.com/' \
      -H 'rtt: 150' \
      -H 'sec-ch-ua: "Google Chrome";v="141", "Not?A_Brand";v="8", "Chromium";v="141"' \
      -H 'sec-ch-ua-mobile: ?0' \
      -H 'sec-ch-ua-platform: "macOS"' \
      -H 'sec-fetch-dest: empty' \
      -H 'sec-fetch-mode: cors' \
      -H 'sec-fetch-site: same-origin' \
      -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36' \
      -H 'x-browser-channel: stable' \
      -H 'x-browser-copyright: Copyright 2025 Google LLC. All rights reserved.' \
      -H 'x-browser-validation: qSH0RgPhYS+tEktJTy2ahvLDO9s=' \
      -H 'x-browser-year: 2025' \
      -H 'x-maps-diversion-context-bin: CAE='
    `
    data = JSON.parse(@@response[4..-1])

    # Main review array: data[2]
    reviews_raw = data[2]

    reviews_raw.map do |entry|
      next unless entry.is_a?(Array)
      author_block =  entry.flatten.compact
      next unless author_block

      name  = author_block[5] rescue nil
      date  = author_block[17] rescue nil
      image  = author_block[6] rescue nil
      text  = author_block[25] rescue nil
      link  = author_block[5] rescue nil
      rating  = author_block[23] rescue nil

      text = nil if text.scan(/.+\/.+?/).any?

      {
        name: name,
        rating: rating,
        date: date,
        text: wrap(text),
        image: image,
        link: link
      }
    end.compact
  end

  def wrap(text, line_width = 180)
    return text unless text

    text = text[0..line_width]
    text << '...' if text.length > line_width
    text
  end
end
