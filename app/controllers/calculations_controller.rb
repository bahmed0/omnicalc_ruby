class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(/\s+/, "").length

    @separated_words = @text.split
    @occurrences = []
    @separated_words.each do |word| 
      if @special_word.in?(word)
      @occurrences.push(1)
      end
    end
      
    @occurrences = @occurrences.sum
      
    

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    
    rate_as_decimal_permonth= @apr./(100)./(12).to_f
    number_payments=@years.*(12)
    one_plus_monthly_rate=1.+(rate_as_decimal_permonth).to_f
    discount_factor_numerator=one_plus_monthly_rate.**(number_payments).-(1)
    discount_factor_denominator1=(one_plus_monthly_rate).**number_payments
    discount_factor_denominator=discount_factor_denominator1.*(rate_as_decimal_permonth)
    discount_factor=discount_factor_numerator./(discount_factor_denominator)
    @monthly_payment = @principal./(discount_factor)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = Chronic.parse(params[:ending_time]).-(Chronic.parse(params[:starting_time]))
    @minutes = Chronic.parse(params[:ending_time]).-(Chronic.parse(params[:starting_time]))./(60)
    @hours = Chronic.parse(params[:ending_time]).-(Chronic.parse(params[:starting_time]))./(60)./(60)
    @days = Chronic.parse(params[:ending_time]).-(Chronic.parse(params[:starting_time]))./(60)./(60)./(24)
    @weeks = Chronic.parse(params[:ending_time]).-(Chronic.parse(params[:starting_time]))./(60)./(60)./(24)./(7)
    @years = Chronic.parse(params[:ending_time]).-(Chronic.parse(params[:starting_time]))./(60)./(60)./(24)./(7)./(52)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

  n=@numbers  
  
    @sorted_numbers = n.sort

    @count = n.count

    @minimum = n.min

    @maximum = n.max

    @range = @maximum.-(@minimum)
    
    if
      @count.odd?
      @median = @sorted_numbers[(@count-1)/2]
    else
      @median = (@sorted_numbers[(@count-1)/2] + @sorted_numbers[(@count)/2])/2
    end

    @sum = n.sum

    @mean = @sum.to_f./(@count).to_f
    
    number_subtract_mean = []
    @numbers.each do |num|
      difference = (num - @mean)**2
      number_subtract_mean.push(difference)
    
    @variance = number_subtract_mean.sum./(@count)
  end

    @standard_deviation = @variance.**(0.5)

    @mode = n.uniq.max_by{ |i| @numbers.count( i )}

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
