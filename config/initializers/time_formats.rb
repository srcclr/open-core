Time::DATE_FORMATS.update({
  epoch: lambda { |time| time.strftime('%s').to_i * 1000 }
});
