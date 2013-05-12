class String
  def to_touchtones
    gsub(/[abc]/i, '2').
    gsub(/[def]/i, '3').
    gsub(/[ghi]/i, '4').
    gsub(/[jkl]/i, '5').
    gsub(/[mno]/i, '6').
    gsub(/[pqrs]/i, '7').
    gsub(/[tuv]/i, '8').
    gsub(/[wxyz]/i, '9')
  end
end

