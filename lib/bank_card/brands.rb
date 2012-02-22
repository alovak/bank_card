module BankCard
  module Brands

    def detect_brand(number)
      brand = [:visa, :american_express, :master, :jcb, :diners_club, :discover, :maestro].
        detect { |brand| send("#{brand}?", number.to_s) }

      brand ? brand : :unknown
    end

    private
    # begin with 4 length 13, 16 or more
    def visa?(number)
      number =~ /^
        4(            # begin with 4
           (\d{12})|  #       and length 13
           (\d{15,})  #       and length 16 or more
         )
      $/x
    end

    # begin with 34 or 37 and length 15
    def american_express?(number)
      number =~ /^3[47]\d{13}$/
    end

    # begin from 51 to 55 and length 16
    def master?(number)
      number =~ /^5[1-5]\d{14}$/
    end

    # begin from 3528 to 3589 and length 16
    def jcb?(number)
      number =~ /^         # begin with
        35(                # 35
            (2[89])|       #   28 to 29
            ([3-8][0-9])   #   30 to 89
          )
          \d{12}           # and length 16
      $/x
    end

    # begin from 300 to 305 and length 14
    #      or begin from 36 and length 14
    def diners_club?(number)
      number =~ /^        # begin
        (30[0-5]\d{11})|  #   from 300 to 305 and length 14
        (36\d{12})        #   with 36 and length 14
      $/x
    end

    # begin with 6011, 65, from 644 to 649, from 622126 to 622925 and length 16
    def discover?(number)
      number =~ /^         # begin with
        (6011\d{12})|        # 6011       and length 16
        (65\d{14})|          # 65         and length 16
        (64[4-9]\d{13})|     # 644 to 649 and length 16
        (622                 # 622
          (
            (12[6-9])|         #    126 to 129
            (1[3-9][0-9])|     #    130 to 199
            ([2-8]\d{2})|      #    200 to 899
            (9[01]\d)|         #    900 to 919
            (92[0-5])          #    920 to 925
          )\d{10}              #            and length 16
        )
      $/x
    end

    # begin with 5018, 5020, 5038, 6304, 6759, 6761, 6762, 6763 and length from 12 to 19
    def maestro?(number)
      number =~ /^(5018|5020|5038|6304|6759|6761|6762|6763)\d{8,15}$/
    end

  end
end
