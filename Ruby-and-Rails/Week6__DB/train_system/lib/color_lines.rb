require 'train'
require 'city'
require 'stop'

class ColorLines
  def initialize
    @cities = ['Bila Cerkva', 'Dnipro-Gholovnyj', 'Kamjansjke-Pas.', 'Kharkiv-Pas.', 'Khmeljnycjkyj', 'Kremenchuk-Pas.',
               'Kropyvnycjkyj', 'Kyjiv-Pas.', 'Ljviv', 'Mariupolj', 'Mukachevo', 'Odesa-Gholovna', 'Pologhy',
               'Poltava-Pivd.', 'Slavsjke', 'Stryj', 'Svaljava', 'Ternopilj', 'Uzhghorod', 'Vinnycja', 'Volnovakha', 'Volovecj',
               'Voznesensjk', 'Zaporizhzhja-1'].map do |name|
      [name, City.new(name: name)]
    end.to_h
    @cities.values.each(&:save)

    @trains = %w[Blue Red Yellow Green].map do |name|
      [name, Train.new(number: name)]
    end.to_h
    @trains.each_value(&:save)

    blue_stops = { 'Ljviv' => 30, 'Ternopilj' => 5, 'Khmeljnycjkyj' => 10, 'Vinnycja' => 12, 'Kyjiv-Pas.' => 30 }
    @blue_stops = init_stops(blue_stops, @trains['Blue'])

    red_stops = { 'Kyjiv-Pas.' => 30, 'Kremenchuk-Pas.' => 7, 'Dnipro-Gholovnyj' => 3,
                  'Zaporizhzhja-1' => 14, 'Mariupolj' => 30 }
    @red_stops = init_stops(red_stops, @trains['Red'])

    yellow_stops = { 'Kharkiv-Pas.' => 30, 'Poltava-Pivd.' => 4, 'Kremenchuk-Pas.' => 2,
                     'Kropyvnycjkyj' => 12, 'Odesa-Gholovna' => 30 }
    @yellow_stops = init_stops(yellow_stops, @trains['Yellow'])

    green_stops = { 'Ljviv' => 30, 'Ternopilj' => 5, 'Khmeljnycjkyj' => 10, 'Odesa-Gholovna' => 30 }
    @green_stops = init_stops(green_stops, @trains['Green'])
  end

  private

  def init_stops(time_table, train)
    stops_list = time_table.transform_values do |minutes|
      Stop.new(minutes: minutes)
    end

    stops_list.each do |name, stop|
      stop.save
      stop.add_related(train)
      stop.add_related(@cities[name])
    end

    stops_list
  end
end
