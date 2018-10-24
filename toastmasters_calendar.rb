require 'rubygems'
require 'active_support'
require 'recurrence'
require 'byebug'

def victoria_holidays_2019
  [
    Date.parse('Tue 1 Jan 2019'),
    Date.parse('Mon 28 Jan 2019'),
    Date.parse('Mon 11 Mar 2019'),
    Date.parse('Fri 19 Apr 2019'),
    Date.parse('Sat 20 Apr 2019'),
    Date.parse('Sun 21 Apr 2019'),
    Date.parse('Mon 22 Apr 2019'),
    Date.parse('Thu 25 Apr 2019'),
    Date.parse('Mon 10 Jun 2019'),
    Date.parse('Tue 5 Nov 2019'),
    Date.parse('Wed 25 Dec 2019'),
    Date.parse('Thu 26 Dec 2019')
  ]
end

def no_meeting_days_2019
  [
    Date.parse('Tue 24 Dec 2019')
  ]
end

def all_tuesdays_in_2019
  Recurrence.new(
    every: :week,
    on: :tuesday,
    starts: '2019-01-01',
    until: '2019-12-31'
  )
end

def all_second_and_fourth_tuesdays
  all_tuesdays_in_2019
    .events
    .group_by(&:month)
    .map { |_month, tuesdays| [tuesdays[1], tuesdays[3]] }
    .flatten
    .map(&:to_date)
    .sort
end

def print(meeting_days)
  meeting_days.each { |date| puts date.strftime(' %d/%m/%Y') }
end

meeting_days = all_second_and_fourth_tuesdays - victoria_holidays_2019 - no_meeting_days_2019

print(meeting_days)
